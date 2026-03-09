module register_file(
    input wire       clk,
    input wire       write_enable,
    input wire       reset,
    input wire [2:0] rs1,
    input wire [2:0] rs2,
    input wire [2:0] write_addr,
    input wire [7:0] write_data,
    output wire [7:0] reg_data1,
    output wire [7:0] reg_data2
);
    integer i;

    reg [7:0] regs [0:7];

    initial begin
        regs[0] = 0;
        regs[1] = 8'd5;
        regs[2] = 8'd3;
        regs[3] = 8'd12;
        regs[4] = 8'd1;
        regs[5] = 0;
        regs[6] = 0;
        regs[7] = 0;
    end

    always @(posedge clk)begin
        if(reset)begin
            for (i = 0;i < 8;i = i+1) begin
                regs[i] <= 0;
            end
        end
        else if(write_enable && write_addr!=0)begin
            regs[write_addr] <= write_data;
        end
    end

    assign reg_data1 = (rs1 == 0) ? 8'b0 : regs[rs1];
    assign reg_data2 = (rs2 == 0) ? 8'b0 : regs[rs2];

endmodule

module alu(
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [1:0] alu_op,
    output reg  [7:0] Y
);

    /*  
    -alu_op = 00 → ADD
    alu_op = 01 → SUB
    alu_op = 10 → AND
    alu_op = 11 → OR
    */

    always @(*)begin
        case (alu_op)
            2'b00 : Y = A + B;
            2'b01 : Y = A - B;
            2'b10 : Y = A & B;
            2'b11 : Y = A | B;
            default : Y = 0;
        endcase
    end
endmodule

module instruction_decoder(
    input  wire [7:0] instruction,
    output wire [1:0] opcode,
    output wire [2:0] rs1,
    output wire [2:0] rs2
);
    assign opcode = instruction[7:6];
    assign rs1 = instruction[5:3];
    assign rs2 = instruction[2:0];
endmodule



module cpu_execute(
    input wire clk,
    input wire reset,
    input wire [7:0] instruction,
    output wire [7:0] rs1_data,
    output wire [7:0] rs2_data,
    output wire [7:0] alu_out
);
    wire [1:0] opcode;
    wire [2:0] rs1;
    wire [2:0] rs2;

    wire [7:0] reg_data1;
    wire [7:0] reg_data2;
    wire write_enable;
    wire [7:0] writeback_data;

    


    instruction_decoder inde(
        .instruction(instruction),
        .opcode(opcode),
        .rs1(rs1),
        .rs2(rs2)
    );

    register_file rsgfile(
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .rs1(rs1),
        .rs2(rs2),
        .write_addr(rs1),
        .write_data(writeback_data),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2)
    );

    alu alu1(
        .A(reg_data1),
        .B(reg_data2),
        .alu_op(opcode),
        .Y(writeback_data)
    );

    assign write_enable = 1'b1;
    assign rs1_data = reg_data1;
    assign rs2_data = reg_data2;
    assign alu_out = writeback_data;

endmodule
