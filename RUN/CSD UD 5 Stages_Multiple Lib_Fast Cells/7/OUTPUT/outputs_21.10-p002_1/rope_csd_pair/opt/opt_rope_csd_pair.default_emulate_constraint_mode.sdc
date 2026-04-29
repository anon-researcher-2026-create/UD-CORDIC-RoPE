# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.10-p002_1 on Wed Apr 22 18:51:53 IST 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design rope_csd_pair

create_clock -name "clk" -period 2.0 -waveform {0.0 1.0} [get_ports clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports rst]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_in[8]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_in[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_in[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_in[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_in[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_in[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_in[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_in[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_in[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_in[8]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_in[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_in[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_in[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_in[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_in[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_in[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_in[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_in[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {angle_bits[9]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {angle_bits[8]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {angle_bits[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {angle_bits[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {angle_bits[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {angle_bits[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {angle_bits[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {angle_bits[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {angle_bits[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {angle_bits[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_out[8]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_out[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_out[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_out[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_out[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_out[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_out[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_out[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {x_out[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_out[8]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_out[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_out[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_out[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_out[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_out[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_out[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_out[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.2 [get_ports {y_out[0]}]
