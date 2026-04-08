module register_file(
    input wire [2:0] reg1_addr,
    input wire [2:0] reg2_addr,
    input wire [2:0] write_addr,
    input wire write_enable,
    input wire [7:0] write_data,
    input wire clk,
    input wire reset,
    output wire [7:0] reg1_data,
    output wire [7:0] reg2_data,

    output wire [7:0] regs0_data,
    output wire [7:0] regs1_data,
    output wire [7:0] regs2_data,
    output wire [7:0] regs3_data,
    output wire [7:0] regs4_data,
    output wire [7:0] regs5_data,
    output wire [7:0] regs6_data,
    output wire [7:0] regs7_data
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
    assign reg2_data = (reg2_addr == 0)? 8'b0 : regs[reg2_addr];
    
    assign regs0_data = regs[0];
    assign regs1_data = regs[1];
    assign regs2_data = regs[2];
    assign regs3_data = regs[3];
    assign regs4_data = regs[4];
    assign regs5_data = regs[5];
    assign regs6_data = regs[6];
    assign regs7_data = regs[7];
    
endmodule