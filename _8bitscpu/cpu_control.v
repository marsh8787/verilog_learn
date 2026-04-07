module cpu_control(
    input wire clk,
    input wire reset,
    input wire [1:0] opcode,
    output reg ir_write,
    output reg pc_write,
    output reg reg_write,
    output reg alu_src,
    output reg branch_en
);

    localparam FETCH = 1'b0;
    localparam EXECUTE = 1'b1;

    reg state,next_state;

    always @(posedge clk)begin
        if(reset)begin
            state <= FETCH;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case(state)
            FETCH: next_state = EXECUTE;
            EXECUTE: next_state = FETCH;
            default: next_state = FETCH;
        endcase
    end

    always @(*) begin
        ir_write = 0;
        pc_write = 0;
        reg_write = 0;
        alu_src = 0;
        branch_en = 0;
        case(state)
            FETCH:
            begin
                ir_write = 1;
                pc_write = 0;
                reg_write = 0;
                alu_src = 0;
                branch_en = 0;
            end
            EXECUTE:
            begin
                ir_write = 0;
                pc_write = 1;
                reg_write = ((opcode == 2'b10) || (opcode == 2'b11)) ? 0 : 1;
                alu_src = (opcode == 2'b01)? 1:0;
                branch_en = (opcode == 2'b10)? 1:0;
            end
        endcase
    end
    
endmodule