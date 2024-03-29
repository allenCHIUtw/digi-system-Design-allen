Update: 2023/03/28
This testbench supports RV32I, RV32IC, RTL, and SYN

Source:
    >	source /usr/cad/cadence/cshrc
    >	source /usr/cad/synopsys/CIC/vcs.cshrc
    >	source /usr/cad/synopsys/CIC/verdi.cshrc
    >	source /usr/cad/synopsys/CIC/synthesis.cshrc

RTL simulation:
- RV32I:  //yes 
    > vcs RISCV_tb.v +define+RV32I+RTL -full64 -R -debug_access+all +v2k
- RV32IC:
    > vcs RISCV_tb.v +define+RV32IC+RTL -full64 -R -debug_access+all +v2k
    
--------------------------------------------------------------------------
Files for synthesis:
- .synopsys_dc.setup
- CHIP_syn.sdc or CHIP_RV32IC_syn.sdc

Synthesis command:
- Open Design Compiler:
    > dv -no_gui
- In Design Compiler:
- RV32I:
    design_vision> read_verilog CHIP.v
    design_vision> source CHIP_syn.sdc
- RV32IC:
    design_vision> read_verilog CHIP_RV32IC.v
    design_vision> source CHIP_RV32IC_syn.sdc

- Check if your design passes timing slack:
    design_vision> report_timing
- Check area:
    design_vision> report_area

- To reopen the design:
- RV32I:	
    design_vision> read_ddc CHIP_syn.ddc
- RV32IC:
    design_vision> read_ddc CHIP_RV32IC_syn.ddc
- Close Design Compiler:
    design_vision> exit
    
--------------------------------------------------------------------------
Post-synthesis simulation:
- Check if you have a SDF file (CHIP_syn.sdf)
- Check if you have a library file (tsmc13.v)
- Note: To copy tsmc13.v to your current directory:
    >	cp /home/raid7_2/course/cvsd/CBDK_IC_Contest/CIC/Verilog/tsmc13.v .

- RV32I:
    >	vcs RISCV_tb.v +define+RV32I+SYN -full64 -R -debug_access+all +v2k
- RV32IC:
    >	vcs RISCV_tb.v +define+RV32IC+SYN -full64 -R -debug_access+all +v2k

--------------------------------------------------------------------------
Pattern generation:
- Open the python script in ./pattern/pattern_gen.py
- Change the variables in the script
- Run the script, and there will be two new files:
	data.txt
	ans.txt