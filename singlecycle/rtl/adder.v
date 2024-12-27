module adder (
    input clk;
    input res;
    input reg[31:0]a;
    input reg [31:0]b;
    output sum;
);
    reg cout;
    reg cin;
    assign sum<= a+b;
    
endmodule