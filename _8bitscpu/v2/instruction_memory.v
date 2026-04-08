module instruction_memory(
    input wire [7:0] mem_addr,
    output wire [7:0] instruction
);
    reg [7:0] mem [0:255];

    integer i;

    initial begin
        for(i = 0;i < 256; i = i + 1)begin
            mem[i] = 0;
        end
    end    

    assign instruction = mem[mem_addr];
endmodule