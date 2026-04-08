TOP = cpu
SRC = cpu.v alu_mux.v alu.v branch_control.v cpu_control.v immediate_generator.v instruction_decoder.v instruction_memory.v instruction_register.v program_counter.v register_file.v writeback_mux.v tb_cpu.v
OUT = simv
VCD = tb_cpu.vcd

all: run

compile:
	iverilog -o $(OUT) $(SRC)

run: compile
	vvp $(OUT)

wave: run
	gtkwave $(VCD)

clean:
	rm $(VCD) $(OUT) 