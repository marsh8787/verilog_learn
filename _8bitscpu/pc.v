module program_counter(
    input wire clk,
    input wire reset,
    input wire [7:0] pc_next,
    output reg [7:0] pc    
);
    always @(posedge clk)begin
        if(reset)begin
            pc <= 0;
        end
        else begin
            pc <= pc_next;
        end
    end 
    
endmodule

module pc_increment(
    input wire [7:0] pc,
    output wire [7:0] pc_plus1
);
    assign pc_plus1 = pc + 1;
endmodule

module pc_branch_adder(
    input  wire [7:0] pc,
    input  wire [7:0] branch_offset,
    output wire [7:0] pc_branch
);
    assign pc_branch = pc + branch_offset;
endmodule

module immediate_generator(
    input wire [7:0] instruction,
    output wire [7:0] imm
);
    assign imm = {4'b0000,instruction[3:0]};
endmodule

module cpu_datapath(
    input wire clk,
    input wire reset,
    input wire branch_taken,
    input wire [7:0] instruction,
    output wire [7:0] pc
);

    wire [7:0] pc_plus1;
    wire [7:0] pc_branch;
    wire [7:0] pc_next;
    wire [7:0] imm;

    program_counter pc1(
        .pc(pc),
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next)
    );

    pc_increment pcpuls1(
        .pc(pc),
        .pc_plus1(pc_plus1)
    );

    pc_branch_adder pc_br_add(
        .pc(pc),
        .branch_offset(imm),
        .pc_branch(pc_branch)
    );

    immediate_generator immgene1(
        .instruction(instruction),
        .imm(imm)
    );

    assign pc_next = (branch_taken) ? pc_branch : pc_plus1;

endmodule