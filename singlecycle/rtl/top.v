`include "data_mem.v"
`include "inst_mem.v"
`include "pc_reg.v"
module top
    (
        input   wire        clk,
        input   wire        reset
    );

    wire [31:0] curr_pc;
    wire [31:0] next_pc;
    wire [31:0] instr;
    wire [31:0] data_out;

    pc_reg PC (
        .clk (clk),
        .rst (reset),
        .nxt_pc_reg_i (next_pc),
        .nxt_pc_reg_o (curr_pc)
    );

    // Instruction Memory
    inst_mem I_MEM (
        .clk (clk),
        .addr_imem_ram_i (curr_pc),
        .wr_inst_imem_ram_i (32'b0),  // No writes to instruction memory
        .wr_en_imem_ram_i (1'b0),     // Read-only
        .read_int_imem_ram_o (instr)
    );

    // Data Memory (example usage)
    data_mem D_MEM (
        .clk (clk),
        .addr_dmem_ram_i (curr_pc),
        .wr_data_dmem_ram_i (32'b0),
        .wr_strb_dmem_ram_i (4'hF),   // Write full word
        .wr_en_dmem_ram_i (1'b0),     // No writes initially
        .read_data_dmem_ram_o (data_out)
    );

    assign next_pc = curr_pc + 4;

endmodule
