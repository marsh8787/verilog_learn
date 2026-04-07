TOP = cpu_execute
SRC = cpu_execute.v tb_cpu_execute.v
OUT = simv
VCD = tb_cpu_execute.vcd

all: run

compile:
	iverilog -o $(OUT) $(SRC)

run: compile
	vvp $(OUT)

wave: run
	gtkwave $(VCD)

clean:
	rm $(VCD) $(OUT) 