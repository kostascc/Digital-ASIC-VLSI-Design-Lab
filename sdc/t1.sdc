#####################################################
## AES Synthesis .tcl
## This file is part of a project on:
## "Large-Scale Digital VLSI-ASIC ICs"
##
## Author:
##  2022 © Konstantinos Chatzis
##  kachatzis@ece.auth.gr
##  Aristotle University of Thessaloniki, Greece
#####################################################

# Library: fast_vdd1v2_basicCells.lib
# Time Unit: 1ns
# Capacitive Load Unit: 1pF
# Voltage Unit: 1V


# CLK signnal of 10ns period, 50% duty cycle
create_clock [get_ports  clk] -name clkt1 -period 10 -waveform {0 5}

# CLK latency of 400ps
set_clock_latency -source 0.4  [get_clocks clkt1]

# CLK uncertainty of 50ps
set_clock_uncertainty 0.05 [get_clocks clkt1]

# CLK rise/fall time at 1% of the period
set_clock_transition -rise 0.1 [get_clocks clkt1]
set_clock_transition -fall 0.1 [get_clocks clkt1]

# Delay: 
#         Min: Minimum Data Arrival Time, Hold Analysis
#         Max: Maximum Data Arrival Time, Setup Analysis

# Output Delay for Setup Analysis of 1ns (including CLK delay)
set_output_delay -clock clkt1 -network_latency_included -max 1 [all_outputs]

# Output Delay for Hold Analysis of 0.1ns (including CLK delay) 
set_output_delay -clock clkt1 -network_latency_included -min 0.1 [all_outputs]

# Input Delay for Setup Analysis of 1ns (including CLK delay)
set_input_delay -clock clkt1 -network_latency_included -max 1 [all_inputs]

# Input Delay for Hold Analysis of 0.1ns (including CLK delay)
set_input_delay -clock clkt1 -network_latency_included -min 0.1 [all_inputs]


# Capacitance: 
#         Min: Hold Analysis
#         Max: Setup Analysis

# Output capacitance for Setup Analysis at 0.5pF
set_load -max 0.5 [all_outputs]

# Output capacitance for Hold Analysis at 0.01pF
set_load -min 0.01 [all_outputs]

# Use cells BUFX2 for Setup and BUFX16 for Hold Analysis.
set_driving_cell -lib_cell BUFX2 -max [all_inputs]
set_driving_cell -lib_cell BUFX16 -min [all_inputs]
