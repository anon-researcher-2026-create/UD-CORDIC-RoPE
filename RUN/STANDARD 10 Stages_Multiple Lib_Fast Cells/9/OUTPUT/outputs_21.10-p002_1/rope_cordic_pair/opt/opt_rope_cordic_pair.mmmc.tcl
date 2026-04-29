#################################################################################
#
# Created by Genus(TM) Synthesis Solution 21.10-p002_1 on Wed Apr 22 19:19:53 IST 2026
#
#################################################################################

## library_sets
create_library_set -name default_emulate_libset_max \
    -timing { /home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045/timing/fast_vdd1v2_basicCells.lib /home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045/timing/fast_vdd1v2_multibitsDFF.lib /home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045_hvt/timing/fast_vdd1v2_basicCells_hvt.lib /home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045_lvt/timing/fast_vdd1v2_basicCells_lvt.lib }

## opcond
create_opcond -name default_emulate_opcond \
    -process 1.0 \
    -voltage 1.32 \
    -temperature 0.0

## timing_condition
create_timing_condition -name default_emulate_timing_cond_max \
    -opcond default_emulate_opcond \
    -library_sets { default_emulate_libset_max }

## rc_corner
create_rc_corner -name default_emulate_rc_corner \
    -temperature 0.0 \
    -qrc_tech /home/redhatacademy19/Documents/Siddhant/gsclib045_all_v4.8/gsclib045_tech/qrc/qx/gpdk045.tch \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0}

## delay_corner
create_delay_corner -name default_emulate_delay_corner \
    -early_timing_condition { default_emulate_timing_cond_max } \
    -late_timing_condition { default_emulate_timing_cond_max } \
    -early_rc_corner default_emulate_rc_corner \
    -late_rc_corner default_emulate_rc_corner

## constraint_mode
create_constraint_mode -name default_emulate_constraint_mode \
    -sdc_files { OUTPUT/outputs_21.10-p002_1/rope_cordic_pair/opt/opt_rope_cordic_pair.default_emulate_constraint_mode.sdc }

## analysis_view
create_analysis_view -name default_emulate_view \
    -constraint_mode default_emulate_constraint_mode \
    -delay_corner default_emulate_delay_corner

## set_analysis_view
set_analysis_view -setup { default_emulate_view } \
                  -hold { default_emulate_view }
