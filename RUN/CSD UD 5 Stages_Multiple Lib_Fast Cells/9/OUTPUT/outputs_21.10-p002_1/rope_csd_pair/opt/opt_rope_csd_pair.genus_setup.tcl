################################################################################
#
# Genus(TM) Synthesis Solution setup file
# Created by Genus(TM) Synthesis Solution 21.10-p002_1
#   on 04/22/2026 18:43:26
#
# This file can only be run in Genus Common UI mode.
#
################################################################################


# This script is intended for use with Genus(TM) Synthesis Solution version 21.10-p002_1


# Remove Existing Design
################################################################################
if {[::legacy::find -design design:rope_csd_pair] ne ""} {
  puts "** A design with the same name is already loaded. It will be removed. **"
  delete_obj design:rope_csd_pair
}


# To allow user-readonly attributes
################################################################################
::legacy::set_attribute -quiet force_tui_is_remote 1 /


# Libraries
################################################################################
::legacy::set_attribute library {/home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045/timing/fast_vdd1v2_basicCells.lib /home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045/timing/fast_vdd1v2_multibitsDFF.lib /home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045_hvt/timing/fast_vdd1v2_basicCells_hvt.lib /home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045_lvt/timing/fast_vdd1v2_basicCells_lvt.lib} /

::legacy::set_attribute lef_library {/home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045/lef/gsclib045_tech.lef /home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045/lef/gsclib045_macro.lef /home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045/lef/gsclib045_multibitsDFF.lef /home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045_hvt/lef/gsclib045_hvt_macro.lef /home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045_lvt/lef/gsclib045_lvt_macro.lef} /
::legacy::set_attribute qrc_tech_file /home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045_tech/qrc/qx/gpdk045.tch /


# Design
################################################################################
read_netlist -top rope_csd_pair OUTPUT/outputs_21.10-p002_1/rope_csd_pair/opt/opt_rope_csd_pair.v.gz
read_metric -id current OUTPUT/outputs_21.10-p002_1/rope_csd_pair/opt/opt_rope_csd_pair.metrics.json

phys::read_script OUTPUT/outputs_21.10-p002_1/rope_csd_pair/opt/opt_rope_csd_pair.g.gz
puts "\n** Restoration Completed **\n"


# Data Integrity Check
################################################################################
# program version
if {"[string_representation [::legacy::get_attribute program_version /]]" != "21.10-p002_1"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden program_version: 21.10-p002_1  current program_version: [string_representation [::legacy::get_attribute program_version /]]"
}
# license
if {"[string_representation [::legacy::get_attribute startup_license /]]" != "Genus_Synthesis"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden license: Genus_Synthesis  current license: [string_representation [::legacy::get_attribute startup_license /]]"
}
# slack
set _slk_ [::legacy::get_attribute slack design:rope_csd_pair]
if {[regexp {^-?[0-9.]+$} $_slk_]} {
  set _slk_ [format %.1f $_slk_]
}
if {$_slk_ != "1234.3"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack: 1234.3,  current slack: $_slk_"
}
unset _slk_
# multi-mode slack
# tns
set _tns_ [::legacy::get_attribute tns design:rope_csd_pair]
if {[regexp {^-?[0-9.]+$} $_tns_]} {
  set _tns_ [format %.0f $_tns_]
}
if {$_tns_ != "0"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden tns: 0,  current tns: $_tns_"
}
unset _tns_
# cell area
set _cell_area_ [::legacy::get_attribute cell_area design:rope_csd_pair]
if {[regexp {^-?[0-9.]+$} $_cell_area_]} {
  set _cell_area_ [format %.0f $_cell_area_]
}
if {$_cell_area_ != "2734"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden cell area: 2734,  current cell area: $_cell_area_"
}
unset _cell_area_
# net area
set _net_area_ [::legacy::get_attribute net_area design:rope_csd_pair]
if {[regexp {^-?[0-9.]+$} $_net_area_]} {
  set _net_area_ [format %.0f $_net_area_]
}
if {$_net_area_ != "1336"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden net area: 1336,  current net area: $_net_area_"
}
unset _net_area_
