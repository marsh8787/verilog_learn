module program_counter(
    input wire pc_write,
    input wire reset,
    input wire clk,
    input wire [7:0] pc_branch,
    input wire branch_taken,
    output wire [7:0] count
);
    reg [7:0] pc;
    reg [7:0] pc_next;

    always @(posedge clk) begin
        if(reset)begin
            pc <= 0;
        end
        else if(!pc_write) begin
            pc <= pc;
        end
        else begin
            pc <= pc_next;
        end
    end

    always @(*) begin
        if(branch_taken)begin
            pc_next = pc + pc_branch;
        end
        else begin
            pc_next = pc + 1;
        end
    end

    assign count = pc;
endmodule