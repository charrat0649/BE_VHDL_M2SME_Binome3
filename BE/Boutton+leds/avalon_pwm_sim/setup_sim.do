    set sopc "c:/altera/11.0sp1/quartus//sopc_builder"
    set sopc_perl "c:/altera/11.0sp1/quartus//bin/perl"
    echo "Sopc_Builder Directory: $sopc";

# ModelSimPE and OEM have different requirements
# regarding how they simulate their test bench.
# We account for that here.
if { [ string match "*ModelSim ALTERA*" [ vsim -version ] ] } {
 alias _init_setup {vlib work
                       vmap altera               work
                       vmap arriaii_hssi         work
                       vmap arriaii_pcie_hip     work
                       vmap cycloneiv_pcie_hip   work
                       vmap cycloneiv_hssi       work
                       vmap hardcopyiv_pcie_hip  work
                       vmap hardcopyiv_hssi      work
                       vcom -93 -explicit c:/altera/11.0sp1/quartus/libraries/vhdl/altera/altera_europa_support_lib.vhd
		       } } else {
 alias _init_setup {vlib work
                       vmap altera               work
                       vmap arriaii_hssi         work
                       vmap arriaii_pcie_hip     work
                       vmap cycloneiv_pcie_hip   work
                       vmap cycloneiv_hssi       work
                       vmap hardcopyiv_pcie_hip  work
                       vmap hardcopyiv_hssi      work
                       vmap lpm                  work
                       vmap altera_mf            work
                       vmap sgate_pack           work
                       vmap sgate                work
                       vmap stratixiigx_hssi     work
                       vmap arriagx_hssi         work
                       vmap stratixgx_hssi       work
                       vmap stratixiv_hssi       work
                       vmap stratixiv_pcie_hip   work
                       vmap altgxb_lib           work
                       vcom -93 -explicit c:/altera/11.0sp1/quartus/libraries/vhdl/altera/altera_europa_support_lib.vhd
                       vcom -93 -explicit c:/altera/11.0sp1/quartus/eda/sim_lib/altera_mf_components.vhd
                       vcom -93 -explicit c:/altera/11.0sp1/quartus/eda/sim_lib/altera_mf.vhd
                       vcom -93 -explicit c:/altera/11.0sp1/quartus/eda/sim_lib/220pack.vhd
                       vcom -93 -explicit c:/altera/11.0sp1/quartus/eda/sim_lib/220model.vhd
                       vcom -93 -explicit c:/altera/11.0sp1/quartus/eda/sim_lib/sgate_pack.vhd
                       vcom -93 -explicit c:/altera/11.0sp1/quartus/eda/sim_lib/sgate.vhd
                       } } 


# ModelSimPE and OEM have different requirements
# regarding how they simulate their test bench.
# We account for that here.
if { [ string match "*ModelSim ALTERA*" [ vsim -version ] ] } {
 alias _vsim {vsim -t ps +nowarnTFMPC  -L lpm -L altera -L altera_mf -L sgate -L stratixiv -L stratixiv_hssi -L stratixiv_pcie_hip -L altera_lnsim test_bench }  } else {
 alias _vsim {vsim -t ps +nowarnTFMPC test_bench }  } 

alias test_contents_files {if {[ file exists "contents_file_warning.txt" ]} { set ch [open "contents_file_warning.txt" r];  while { 1 } { if ([eof $ch]) {break}; gets $ch line; puts $line; }; close $ch; } }
alias s "_init_setup
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/sopc_builder_tutorial/PWM_0.vhd
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/SOPC_PWM/Avalon_PWM.vhd
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/sopc_builder_tutorial/PWM_0_0.vhd
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/sopc_builder_tutorial/jtag_uart_0.vhd
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/sopc_builder_tutorial/cpu_0_test_bench.vhd
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/sopc_builder_tutorial/cpu_0_oci_test_bench.vhd
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/sopc_builder_tutorial/cpu_0_jtag_debug_module_tck.vhd
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/sopc_builder_tutorial/cpu_0_jtag_debug_module_sysclk.vhd
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/sopc_builder_tutorial/cpu_0_jtag_debug_module_wrapper.vhd
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/sopc_builder_tutorial/cpu_0.vhd
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/sopc_builder_tutorial/LEDs.vhd
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/sopc_builder_tutorial/Switches.vhd
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/sopc_builder_tutorial/onchip_memory2_0.vhd
vcom -93 -explicit C:/Users/Etudiant/Documents/BE_CHARRAT_MOATASSIM/sopc_builder_tutorial/Avalon_PWM.vhd
_vsim
do virtuals.do
set StdArithNoWarnings 1
; test_contents_files"
alias r "exec $sopc_perl/bin/perl -I $sopc/bin/perl_lib -I $sopc/bin $sopc/bin/run_command_in_unix_like_shell.pl $sopc { cd ../;  ./Avalon_PWM_generation_script  } "
alias c "echo {Regenerating memory contents.
 (This may take a moment)...}; restart -f; exec $sopc_perl/bin/perl -I $sopc/bin/perl_lib -I $sopc/bin $sopc/bin/run_command_in_unix_like_shell.pl $sopc { cd ../;  ./Avalon_PWM_generation_script  }  --software_only=1"
alias w "do wave_presets.do"
alias l "do list_presets.do"
#
# s_cycloneiv: compile simulation models for cyclone 4.
proc s_cycloneiv {} {
  if { [ expr ! [ string match "*ModelSim ALTERA*" [ vsim -version ] ] ] } {
    vlib work
    _init_setup
    set qsimlib c:/altera/11.0sp1/quartus/eda/sim_lib
    set vhd_files [ list \
      $qsimlib/cycloneiv_atoms.vhd \
      $qsimlib/cycloneiv_components.vhd \
      $qsimlib/cycloneiv_hssi_components.vhd \
      $qsimlib/cycloneiv_hssi_atoms.vhd \
      $qsimlib/cycloneiv_pcie_hip_components.vhd \
      $qsimlib/cycloneiv_pcie_hip_atoms.vhd \
      $qsimlib/cycloneive_atoms.vhd \
      $qsimlib/cycloneive_components.vhd \
    ]
    foreach file $vhd_files {if {[ file exists $file ]} {vcom -93 -explicit $file}}
  }
}
#
# s_stratixiv: compile simulation models for stratix 4.
proc s_stratixiv {} {
  if { [ expr ! [ string match "*ModelSim ALTERA*" [ vsim -version ] ] ] } {
    vlib work
    _init_setup
    set qsimlib c:/altera/11.0sp1/quartus/eda/sim_lib
    set vhd_files [ list \
      $qsimlib/stratixiv_atoms.vhd \
      $qsimlib/stratixiv_components.vhd \
      $qsimlib/stratixiv_hssi_components.vhd \
      $qsimlib/stratixiv_hssi_atoms.vhd \
      $qsimlib/stratixiv_pcie_hip_components.vhd \
      $qsimlib/stratixiv_pcie_hip_atoms.vhd \
    ]
    foreach file $vhd_files {if {[ file exists $file ]} {vcom -93 -explicit $file}}
  }
}
#
# s_stratixv: compile simulation models for stratix 5.
proc s_stratixv {} {
  if { [ expr ! [ string match "*ModelSim ALTERA*" [ vsim -version ] ] ] } {
    vlib work
    _init_setup
    set qsimlib c:/altera/11.0sp1/quartus/eda/sim_lib
    set vendor_sv_files [ list \
      $qsimlib/mentor/stratixv_pcie_hip_atoms_ncrypt.v \
      $qsimlib/mentor/altera_lnsim_for_vhdl.sv \
    ]
    set vendor_v_files [ list \
      $qsimlib/mentor/stratixv_atoms_ncrypt.v \
      $qsimlib/mentor/stratixv_hssi_atoms_ncrypt.v \
      $qsimlib/mentor/stratixv_atoms_for_vhdl.v \
      $qsimlib/mentor/stratixv_hssi_atoms_for_vhdl.v \
    ]
    foreach file $vendor_sv_files {if {[ file exists $file ]} {vlog -sv $file}}
    foreach file $vendor_v_files  {if {[ file exists $file ]} {vlog $file}}
    set vhd_files [ list \
      $qsimlib/stratixv_pcie_hip_components.vhd \
      $qsimlib/stratixv_pcie_hip_atoms.vhd \
    ]
    foreach file $vhd_files {if {[ file exists $file ]} {vcom -93 -explicit $file}}
  }
}
alias jtag_uart_0_log "./jtag_uart_0_log.bat $sopc_perl/bin &"
alias h "
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @@
echo @@        setup_sim.do
echo @@
echo @@   Defined aliases:
echo @@
echo @@   s  -- Load all design (HDL) files.
echo @@           re-vlog/re-vcom and re-vsim the design.
echo @@
echo @@   s_cycloneiv -- For Modelsim SE, compile Cyclone IV models. (Ignored
echo @@     in Modelsim AE.)
echo @@
echo @@   s_stratixiv -- For Modelsim SE, compile Stratix IV models. (Ignored
echo @@     in Modelsim AE.)
echo @@
echo @@   s_stratixv -- For Modelsim SE, compile Stratix V models. (Ignored
echo @@     in Modelsim AE.)
echo @@
echo @@   w  -- Sets-up waveforms for this design
echo @@          Each SOPC-Builder component may have
echo @@          signals 'marked' for display during
echo @@          simulation.  This command opens a wave-
echo @@          window containing all such signals.
echo @@
echo @@   l  -- Sets-up list waveforms for this design
echo @@          Each SOPC-Builder component may have
echo @@          signals 'marked' for listing during
echo @@          simulation.  This command opens a list-
echo @@          window containing all such signals.
echo @@
echo @@   jtag_uart_0_log  -- display interactive output window for jtag_uart_0

echo @@
echo @@   h  -- print this message 
echo @@
echo @@ ***Special VHDL settings***
echo @@    StdArithNoWarnings=1 in s command
echo @@"

h
