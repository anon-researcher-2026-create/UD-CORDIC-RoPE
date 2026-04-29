# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.10-p002_1 on Wed Apr 22 19:04:50 IST 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design rope_binary_ud_pair

create_clock -name "clk" -period 2.0 -waveform {0.0 1.0} [get_ports clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports rst]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_even[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_even[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_even[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_even[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_even[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_even[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_even[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_even[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_odd[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_odd[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_odd[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_odd[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_odd[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_odd[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_odd[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_odd[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {ud_bits[9]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {ud_bits[8]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {ud_bits[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {ud_bits[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {ud_bits[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {ud_bits[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {ud_bits[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {ud_bits[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {ud_bits[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {ud_bits[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_even[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_even[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_even[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_even[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_even[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_even[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_even[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_even[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_odd[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_odd[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_odd[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_odd[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_odd[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_odd[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_odd[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_odd[0]}]
