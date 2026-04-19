module instruction_register(
    input wire clk,
    input wire cpu_en,
    input wire reset,
    input wire [7:0] instruction_in,
    input wire ir_write,
    output reg [7:0] instruction_out
);
    always @(posedge clk)begin
        if(reset)begin
            instruction_out <= 8'b0;
        end
        else if(cpu_en)begin
            if(ir_write)begin
                instruction_out <= instruction_in;
            end
            else begin
                instruction_out <= instruction_out;
            end
        end
    end
endmodule
