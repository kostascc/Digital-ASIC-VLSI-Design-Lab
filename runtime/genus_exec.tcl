# Initialize
gui_show
report_messages
set_db / .use_scan_seqs_for_non_dft false  # Disable SDFFs

# Set Paths
set_db init_lib_search_path { /mnt/apps/prebuilt/eda/designkits/GPDK/gsclib045/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045/timing /mnt/apps/prebuilt/eda/designkits/GPDK/gsclib045/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045/lef /mnt/apps/prebuilt/eda/designkits/GPDK/gsclib045/lan/flow/t1u1/reference_libs/GPDK045/gsclib045_svt_v4.4/gsclib045/qrc/qx} 
set_db script_search_path ./sdc
set_db init_hdl_search_path ./hdl

# Select Libraries
set_db library fast_vdd1v2_basicCells.lib
set_db lef_library { gsclib045_tech.lef gsclib045_macro.lef }
read_qrc gpdk045.tch

# Import and Elaborate the design
read_hdl -f ./hdl.list.tmp
elaborate aes > ./reports/elaborate.log
check_design  > ./reports/design.log

# Import and Check Constraints
read_sdc t1.sdc
check_timing_intent > ./reports/timing_intent.rep

# Sythesize
syn_generic # > ./reports/generic.syn
syn_map     # > ./reports/map.syn
syn_opt     # > ./reports/opt.syn

# Report
write_reports -directory ./tmp/ -tag aes_sumrep
report_summary      > ./reports/qos_summary.rep
report_area -detail > ./reports/area.rep
report_timing       > ./reports/timing.rep
report_power        > ./reports/power.rep
report_clocks       > ./reports/clocks.rep
report_qor -levels_of_logic -power > ./reports/qor.rep
report_gates -power -net_power -yield > ./reports/gates.rep

# Export Gate-Level Netlist
write_hdl    ./exports/design.v
write_script ./exports/constraints.g
write_sdc    ./exports/constraints.sdc
write_design aes -basename ./exports/aes_synth -innovus

report_messages > ./reports/messages.rep

exit
