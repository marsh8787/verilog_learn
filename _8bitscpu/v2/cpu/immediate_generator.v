module immediate_generator(
    input wire [7:0] instruction,
    output wire [7:0] immediate
);
    assign immediate = {{5{instruction[2]}},instruction[2:0]};
endmodule