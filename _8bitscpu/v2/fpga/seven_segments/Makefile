TOP = bin2bcd
SRC = bin2bcd.v tb_bin2bcd.v
OUT = simv
VCD = tb_bin2bcd.vcd

all: run

compile:
	iverilog -o $(OUT) $(SRC)

run: compile
	vvp $(OUT)

wave: run
	gtkwave $(VCD)

clean:
	-if exist "$(VCD)" del /Q "$(VCD)"
	-if exist "$(OUT)" del /Q "$(OUT)"