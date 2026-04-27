# =========================================================
# 0. MEMORY FAILSAFE
# =========================================================
import torch
import gc
torch.cuda.empty_cache()
gc.collect()

# =========================================================
# 1. IMPORTS & SETUP
# =========================================================
import math
from transformers import AutoModelForCausalLM, AutoTokenizer
from transformers.models.phi3 import modeling_phi3
from datasets import load_dataset
from tqdm import tqdm

device = "cuda" if torch.cuda.is_available() else "cpu"
print("Using device:", device)

# =========================================================
# 2. MODEL LOADING (NATIVE PHI-3 INTEGRATION)
# =========================================================
model_name = "microsoft/Phi-3-mini-4k-instruct"

print(f"Loading tokenizer for {model_name}...")
tokenizer = AutoTokenizer.from_pretrained(model_name)

if tokenizer.pad_token is None:
    tokenizer.pad_token = tokenizer.eos_token

print("Loading Phi-3 3.8B from cache (Native HF Implementation)...")
# REMOVED trust_remote_code=True to prevent the KeyError crash
model = AutoModelForCausalLM.from_pretrained(
    model_name,
    torch_dtype=torch.float16,
    device_map="auto",
    use_safetensors=True
)
model.eval()
print("Model loaded successfully.")

# =========================================================
# 3. DYNAMIC RoPE PATCH (BINARY VS CSD MATH)
# =========================================================
if not hasattr(modeling_phi3, "_ORIG_ROPE"):
    modeling_phi3._ORIG_ROPE = modeling_phi3.apply_rotary_pos_emb

_ORIG = modeling_phi3._ORIG_ROPE

def rotate_half(x):
    half = x.shape[-1] // 2
    x1 = x[..., :half]
    x2 = x[..., half:]
    return torch.cat((-x2, x1), dim=-1)

def cordic_rope(q, k, cos, sin, unsqueeze_dim=1, std_dev=0.01):
    theta = torch.atan2(sin, cos)
    noise = torch.randn_like(theta) * std_dev
    theta_approx = theta + noise

    c_approx = torch.cos(theta_approx).unsqueeze(unsqueeze_dim)
    s_approx = torch.sin(theta_approx).unsqueeze(unsqueeze_dim)

    q_embed = (q * c_approx) + (rotate_half(q) * s_approx)
    k_embed = (k * c_approx) + (rotate_half(k) * s_approx)
    return q_embed, k_embed

CURRENT_MODE = "float"

def patched_rope(q, k, cos, sin, *args, **kwargs):
    if CURRENT_MODE == "float":
        return _ORIG(q, k, cos, sin, *args, **kwargs)

    mode_name, frac_bits = CURRENT_MODE
    u_dim = kwargs.get("unsqueeze_dim", 1)

    if mode_name == "binary":
        max_error = 1.216 * (2 ** -frac_bits)
    elif mode_name == "csd":
        max_error = 1.024 * (2 ** -frac_bits)

    std_dev = max_error / 3
    return cordic_rope(q, k, cos, sin, unsqueeze_dim=u_dim, std_dev=std_dev)

modeling_phi3.apply_rotary_pos_emb = patched_rope

# =========================================================
# 4. DATASET
# =========================================================
print("Loading Wikitext-2 dataset...")
dataset = load_dataset("wikitext", "wikitext-2-raw-v1", split="test")

# =========================================================
# 5. CONTINUOUS CONTEXT EVALUATOR (DYNAMIC BOS FIX)
# =========================================================
def compute_perplexity_continuous(model, tokenizer, dataset, desc):
    full_text = "\n\n".join([sample["text"] for sample in dataset if len(sample["text"].strip()) > 0])
    encodings = tokenizer(full_text, return_tensors="pt", add_special_tokens=False)
    seq_len = encodings.input_ids.size(1)
    
    max_length = 1024 
    stride = 512 
    
    bos_id = tokenizer.bos_token_id if tokenizer.bos_token_id is not None else 1
    
    nlls = []
    prev_end_loc = 0
    
    for begin_loc in tqdm(range(0, seq_len, stride), desc=f"Evaluating {desc}"):
        end_loc = min(begin_loc + max_length, seq_len)
        trg_len = end_loc - prev_end_loc 
        
        input_ids = encodings.input_ids[:, begin_loc:end_loc].to("cuda:0")
        
        input_ids[:, 0] = bos_id 
        
        target_ids = input_ids.clone()
        target_ids[:, :-trg_len] = -100 
        
        with torch.no_grad():
            outputs = model(input_ids, labels=target_ids)
            neg_log_likelihood = outputs.loss * trg_len
            nlls.append(neg_log_likelihood.item())
            
        del input_ids, target_ids, outputs
        torch.cuda.empty_cache()
        
        prev_end_loc = end_loc
        if end_loc == seq_len:
            break
            
    total_loss = sum(nlls) / seq_len
    ppl = math.exp(total_loss)
    
    return ppl

# =========================================================
# 6. RUN THE DOUBLE BIT-WIDTH SWEEP
# =========================================================
results_binary = {}
results_csd = {}

print("\n" + "="*60)
print(" STARTING PHI-3 (3.8B) DOUBLE SWEEP: BINARY vs CSD")
print("="*60)

CURRENT_MODE = "float"
print("\n[0/24] Running FP16 Baseline...")
fp16_baseline = compute_perplexity_continuous(model, tokenizer, dataset, "[FP16 Baseline]")

loop_counter = 1
for frac_bits in range(3, 15):
    total_bits = 1 + 1 + frac_bits
    label = f"{total_bits}-bit (f={frac_bits})"
    print(f"\n[{loop_counter}/24] Running Standard BINARY for {label}...")
    CURRENT_MODE = ("binary", frac_bits)
    results_binary[label] = compute_perplexity_continuous(model, tokenizer, dataset, f"[BIN {label}]")
    loop_counter += 1

for frac_bits in range(3, 15):
    total_bits = 1 + 1 + frac_bits
    label = f"{total_bits}-bit (f={frac_bits})"
    print(f"\n[{loop_counter}/24] Running CSD Optimized for {label}...")
    CURRENT_MODE = ("csd", frac_bits)
    results_csd[label] = compute_perplexity_continuous(model, tokenizer, dataset, f"[CSD {label}]")
    loop_counter += 1

modeling_phi3.apply_rotary_pos_emb = _ORIG

# =========================================================
# 7. FINAL IEEE-READY TABLE PRINTER
# =========================================================
print("\n\n" + "="*60)
print(" FINAL PHI-3 (3.8B) SWEEP RESULTS: BINARY vs CSD")
print("="*60)
print(f"FP16 Baseline (Control) : {fp16_baseline:.4f}")
print("-" * 60)
print(f"{'Bit-Width':<18} | {'Binary Perplexity':<18} | {'CSD Perplexity':<18}")
print("-" * 60)

for frac_bits in range(3, 15):
    total_bits = 1 + 1 + frac_bits
    label = f"{total_bits}-bit (f={frac_bits})"
    bin_val = results_binary[label]
    csd_val = results_csd[label]
    print(f"{label:<18} | {bin_val:<18.4f} | {csd_val:<18.4f}")

print("="*60)
