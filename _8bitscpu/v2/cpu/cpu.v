module cpu(
    input wire clk,
    input wire reset
);

    wire pc_write;
    wire branch_taken;
    wire [7:0] count;

    wire ir_write;
    wire [7:0] instruction_to_ir;
    wire [7:0] instruction;

    wire [1:0] opcode;
    wire [2:0] reg1_addr;
    wire [2:0] reg2_addr;

    wire [7:0] immediate;

    wire write_enable;
    wire [7:0] write_data;
    wire [7:0] reg1_data;
    wire [7:0] reg2_data;

    wire alu_src_sel;
    wire [7:0] alu_in_2;

    wire [7:0] alu_result;

    wire wb_data_sel;

    wire branch_en;

    program_counter u_pc(
        .clk(clk),
        .reset(reset),
        .pc_write(pc_write),
        .pc_branch(immediate),
        .branch_taken(branch_taken),
        .count(count)
    );

    instruction_memory u_insmem(
        .mem_addr(count),
        .instruction(instruction_to_ir)
    );

    instruction_register u_insreg(
        .clk(clk),
        .reset(reset),
        .ir_write(ir_write),
        .instruction_in(instruction_to_ir),
        .instruction_out(instruction)
    );

    instruction_decoder u_insdecoder(
        .instruction(instruction),
        .opcode(opcode),
        .reg1_addr(reg1_addr),
        .reg2_addr(reg2_addr)
    );

    immediate_generator u_immgen(
        .instruction(instruction),
        .immediate(immediate)
    );

    register_file u_regfile(
        .clk(clk),
        .reset(reset),
        .reg1_addr(reg1_addr),
        .reg2_addr(reg2_addr),
        .write_addr(reg1_addr),
        .write_enable(write_enable),
        .write_data(write_data),
        .reg1_data(reg1_data),
        .reg2_data(reg2_data)
    );


    alu_mux u_alumux(
        .alu_src_sel(alu_src_sel),
        .immediate(immediate),
        .reg2_data(reg2_data),
        .alu_in_2(alu_in_2)
    );

    alu u_alu(
        .input1(reg1_data),
        .input2(alu_in_2),
        .alu_result(alu_result)
    );

    writeback_mux u_wbmux(
        .reg2_data(reg2_data),
        .alu_result(alu_result),
        .wb_data_sel(wb_data_sel),
        .write_data(write_data)
    );

    branch_control U_bchcontrol(
        .branch_en(branch_en),
        .reg1_data(reg1_data),
        .branch_taken(branch_taken)
    );

    cpu_control u_cpucontrol(
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .ir_write(ir_write),
        .pc_write(pc_write),
        .reg_write(write_enable),
        .alu_src_sel(alu_src_sel),
        .wb_data_sel(wb_data_sel),
        .branch_en(branch_en)
    );

endmodule