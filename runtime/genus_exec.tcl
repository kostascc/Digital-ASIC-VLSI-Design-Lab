# Initialize
#gui_show
report_messages
set_db use_scan_seqs_for_non_dft false

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
elaborate aes
check_design  > ./reports/genus/design.log

# Import and Check Constraints
read_sdc t1.sdc
check_timing_intent > ./reports/genus/timing_intent.rpt

# Sythesize
syn_generic
syn_map
syn_opt

# Report
write_reports  -directory ./reports/genus/ -tag summary
report_summary -directory ./reports/genus/
report_area    -detail > ./reports/genus/area.rpt
report_timing          > ./reports/genus/timing.rpt
report_power           > ./reports/genus/power.rpt
report_clocks          > ./reports/genus/clocks.rpt
report_qor     -levels_of_logic -power > ./reports/genus/qor.rpt
report_gates   -power -net_power -yield > ./reports/genus/gates.rpt

# Export Gate-Level Netlist
write_hdl    >  ./exports/genus/design.v
write_script > ./exports/genus/constraints.g
write_sdc    > ./exports/genus/constraints.sdc
write_design aes -basename ./exports/genus/ -innovus

report_messages > ./reports/genus/messages.log

exit
