module instruction_memory(
    input  wire [7:0] addr,
    output wire [7:0] instruction
);

    reg [7:0] mems [0:255];
    assign instruction = mems[addr];
endmodule

module instruction_register(
    input wire clk,
    input wire reset,
    input wire [7:0] instruction_in,
    output reg [7:0] instruction_out
);
    
    always @(posedge clk)begin
        if(reset)begin
            instruction_out <= {8{1'b0}};
        end
        else begin
            instruction_out <= instruction_in;
        end
    end
endmodule