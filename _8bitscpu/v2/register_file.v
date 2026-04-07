module register_file(
    input wire [2:0] reg1_addr,
    input wire [2:0] reg2_addr,
    input wire [2:0] write_addr,
    input wire write_enable,
    input wire [7:0] write_data,
    input wire clk,
    input wire reset,
    output wire [7:0] reg1_data,
    output wire [7:0] reg2_data
);

    reg [7:0] regs[0:7];

    integer i;

    always @(posedge clk) begin
        if(reset)begin
            for(i = 0;i < 8;i = i + 1)begin
                regs[i] <= 8'b0;
            end
        end
        else if(write_enable && write_addr != 0)begin
            regs[write_addr] <= write_data;
        end
    end 

    assign reg1_data = (reg1_addr == 0)? 8'b0 : regs[reg1_addr];
    assign reg1_data = (reg1_addr == 0)? 8'b0 : regs[reg1_addr];
    
endmodule