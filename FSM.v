module fsm3_onehot (
    input wire clk,
    input wire reset,
    input wire btn,
    output reg [2:0] state,
    output wire [2:0] led
);

    localparam S0 = 3'b001,S1 = 3'b010,S2 = 3'b100;

    reg [2:0] next_state;

    assign led = state;

    always @(posedge clk) begin
        if(reset)begin
            state <= S0;
        end
        else begin
            state <= next_state;
        end
    end    

    always @(*)begin
        next_state = state;

        case(state)
            S0 : if(btn) next_state = S1;
            S1 : if(btn) next_state = S2;
            S2 : if(btn) next_state = S0;
            default : next_state = S0;
        endcase
    end

endmodule

module fsm4_door_alarm(
    input wire clk,
    input wire reset,
    input wire coin,
    input wire push,
    input wire timeout,
    output wire [3:0] sta,
    output reg unlock
);
    localparam LOCKED = 4'b0001,PAID = 4'b0010,OPEN = 4'b0100,ALARM = 4'b1000;

    reg [3:0] state,next_state; 

    assign sta = state;

    always @(posedge clk)begin
        if(reset)begin
            state <= LOCKED;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*)begin
        next_state = state;
        unlock = 0;
        case(state)
            LOCKED : 
                if(coin)begin
                    next_state = PAID;
                end
            PAID :
                if(push)begin
                    next_state = OPEN;
                end
                else if(timeout) begin
                    next_state = ALARM;
                end
            OPEN :
                begin
                next_state = LOCKED;
                unlock = 1;
                end
            ALARM :
                if(coin)begin
                    next_state = LOCKED;
                end
            default : next_state = LOCKED;
        endcase
    end
endmodule

module fsm4_door_alarm_s(
    input wire clk,
    input wire reset,
    input wire coin,
    input wire push,
    input wire timeout,
    output reg unlock
);

    localparam LOCKED = 4'b0001,PAID = 4'b0010,OPEN = 4'b0100,ALARM = 4'b1000;

    reg [3:0] state,next_state; 
    //2ff
    reg coin_ff1,coin_ff2;
    reg push_ff1,push_ff2;
    reg timeout_ff1,timeout_ff2;
    wire coin_s;
    wire push_s;
    wire timeout_s;    
    assign coin_s = coin_ff2;
    assign push_s = push_ff2;
    assign timeout_s = timeout_ff2;
    //debounce
    reg push_clean;
    reg [18:0] debounce_ctn;
    parameter DE_CNT_MAX = 500000;
    //edge detect
    reg push_prev;
    wire push_pulse;
    assign push_pulse = push_clean & ~push_prev;



    always @(posedge clk)begin
        if(reset)begin
            coin_ff1 <= 0;
            coin_ff2 <= 0;
            push_ff1 <= 0;
            push_ff2 <= 0;
            timeout_ff1 <= 0;
            timeout_ff2 <= 0;
            push_prev <= 0;
        end
        else begin
            coin_ff1 <= coin;
            coin_ff2 <= coin_ff1;
            push_ff1 <= push;
            push_ff2 <= push_ff1;
            timeout_ff1 <= timeout;
            timeout_ff2 <= timeout_ff1; 
        end
    end

    always @(posedge clk)begin
        if(reset)begin
            push_clean <=0;
            debounce_ctn <= 0;
        end
        else begin
            if(push_s == push_clean)begin
                debounce_ctn <= 0;
            end
            else if(debounce_ctn == DE_CNT_MAX-1)begin
                push_clean <= push_ff2;
                debounce_ctn <= 0;
            end
            else begin
                debounce_ctn <= debounce_ctn + 1;
            end
        end
    end

    always @(posedge clk)begin
        if(reset)begin
            push_prev <= 0;
        end
        else begin
            push_prev <= push_clean;
        end
    end

    always @(posedge clk)begin
        if(reset)begin
            state <= LOCKED;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*)begin
        next_state = state;
        unlock = 0;
        push_pulse = push_s & ~push_prev;
        case(state)
            LOCKED : 
                if(coin_s)begin
                    next_state = PAID;
                end
            PAID :
                if(push_pulse)begin
                    next_state = OPEN;
                end
                else if(timeout_s) begin
                    next_state = ALARM;
                end
            OPEN :
                begin
                next_state = LOCKED;
                unlock = 1;
                end
            ALARM :
                if(coin_s)begin
                    next_state = LOCKED;
                end
            default : next_state = LOCKED;
        endcase
    end
endmodule

