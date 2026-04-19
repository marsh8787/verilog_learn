IVERILOG ?= iverilog
VVP ?= vvp

TOP_CPU = cpu
TOP_FPGA = cpu_fpga

SRC = $(wildcard *.v)

OUT_CPU = simv_cpu
OUT_FPGA = simv_cpu_fpga

.PHONY: all compile compile-cpu compile-fpga run-cpu run-fpga clean help

all: compile

compile: compile-cpu compile-fpga

compile-cpu:
	$(IVERILOG) -g2012 -Wall -s $(TOP_CPU) -o $(OUT_CPU) $(SRC)

compile-fpga:
	$(IVERILOG) -g2012 -Wall -s $(TOP_FPGA) -o $(OUT_FPGA) $(SRC)

run-cpu: compile-cpu
	$(VVP) $(OUT_CPU)

run-fpga: compile-fpga
	$(VVP) $(OUT_FPGA)

help:
	@echo Targets:
	@echo   make compile      - Build cpu and cpu_fpga
	@echo   make compile-cpu  - Build cpu top only
	@echo   make compile-fpga - Build cpu_fpga top only
	@echo   make run-cpu      - Run cpu binary with vvp
	@echo   make run-fpga     - Run cpu_fpga binary with vvp
	@echo   make clean        - Remove build artifacts

clean:
ifeq ($(OS),Windows_NT)
	-if exist "$(OUT_CPU)" del /Q "$(OUT_CPU)"
	-if exist "$(OUT_CPU).exe" del /Q "$(OUT_CPU).exe"
	-if exist "$(OUT_FPGA)" del /Q "$(OUT_FPGA)"
	-if exist "$(OUT_FPGA).exe" del /Q "$(OUT_FPGA).exe"
	-if exist "*.vcd" del /Q "*.vcd"
else
	rm -f $(OUT_CPU) $(OUT_CPU).exe $(OUT_FPGA) $(OUT_FPGA).exe *.vcd
endif