`timescale 1ns/1ps


module top_tb;

    // Inputs
    reg clk;
    reg reset;

    // Instantiate the Unit Under Test (UUT)
    top uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 ns clock period (100 MHz)

    initial begin
        clk = 0;
        reset = 1;
        #10;
        reset = 0;
        #100;
        $stop;
    end

    // Instruction memory initialization
    initial begin
        // Assuming `instr_mem` is byte-addressable and initialized in the design
        // Assign some test instructions
        uut.I_MEM.imem[0] = 32'h12345678; // Dummy instruction at address 0
        uut.I_MEM.imem[1] = 32'h89ABCDEF; // Dummy instruction at address 4
        uut.I_MEM.imem[2] = 32'hDEADBEEF; // Dummy instruction at address 8
        uut.I_MEM.imem[3] = 32'hCAFEBABE; // Dummy instruction at address 12

        // Data memory (for demonstration purposes)
        uut.D_MEM.dmem[0] = 32'h11111111; // Data at address 0x1000
        uut.D_MEM.dmem[1] = 32'h22222222; // Data at address 0x1004
        uut.D_MEM.dmem[2] = 32'h33333333; // Data at address 0x1008
        uut.D_MEM.dmem[3] = 32'h44444444; // Data at address 0x100C
    end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule
