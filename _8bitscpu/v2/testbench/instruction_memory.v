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

        mem[0]  = 8'b11001000;  // CP   R1, R0      ; R1 = 0
        mem[1]  = 8'b01001011;  // ADDI R1, +3      ; R1 = 3
        mem[2]  = 8'b01001011;  // ADDI R1, +3      ; R1 = 6
        mem[3]  = 8'b01001111;  // ADDI R1, -1      ; R1 = 5

        mem[4]  = 8'b11010001;  // CP   R2, R1      ; R2 = 5
        mem[5]  = 8'b00010001;  // ADD  R2, R1      ; R2 = 10
        mem[6]  = 8'b01010100;  // ADDI R2, -4      ; R2 = 6

        mem[7]  = 8'b11011000;  // CP   R3, R0      ; R3 = 0
        mem[8]  = 8'b10011010;  // BEQZ R3, +2      ; taken -> PC = 10
        mem[9]  = 8'b01001001;  // ADDI R1, +1      ; 這條應被跳過

        mem[10] = 8'b01011001;  // ADDI R3, +1      ; R3 = 1
        mem[11] = 8'b10011010;  // BEQZ R3, +2      ; not taken
        mem[12] = 8'b01001001;  // ADDI R1, +1      ; R1 = 6

        mem[13] = 8'b11100000;  // CP   R4, R0      ; R4 = 0
        mem[14] = 8'b01100010;  // ADDI R4, +2      ; R4 = 2
        mem[15] = 8'b00100001;  // ADD  R4, R1      ; R4 = 8
        mem[16] = 8'b01100101;  // ADDI R4, -3      ; R4 = 5

        mem[17] = 8'b11101100;  // CP   R5, R4      ; R5 = 5
        mem[18] = 8'b00101010;  // ADD  R5, R2      ; R5 = 11
        mem[19] = 8'b01101100;  // ADDI R5, -4      ; R5 = 7

        mem[20] = 8'b11110000;  // CP   R6, R0      ; R6 = 0
        mem[21] = 8'b10110010;  // BEQZ R6, +2      ; taken -> PC = 23
        mem[22] = 8'b01010001;  // ADDI R2, +1      ; 這條應被跳過

        mem[23] = 8'b01110010;  // ADDI R6, +2      ; R6 = 2
        mem[24] = 8'b10110010;  // BEQZ R6, +2      ; not taken
        mem[25] = 8'b11111110;  // CP   R7, R6      ; R7 = 2
        mem[26] = 8'b00111001;  // ADD  R7, R1      ; R7 = 8
        mem[27] = 8'b01111111;  // ADDI R7, -1      ; R7 = 7

        mem[28] = 8'b11010111;  // CP   R2, R7      ; R2 = 7
        mem[29] = 8'b10000111;  // BEQZ R0, -1      ; taken -> PC = 28，形成 28<->29 迴圈
    end    

    assign instruction = mem[mem_addr];
endmodule