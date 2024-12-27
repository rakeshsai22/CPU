`define ADD_OP  6'b100000
`define SUB_OP  6'b100010
`define OR_OP   6'b100101
`define AND_OP  6'b100100
`define XOR_OP  6'b100110
`define NOR_OP  6'b100111
`define SLT_OP  6'b101010
`define SLTU_OP 6'b101011
`define SHL_OP  6'b000010
`define LSR_OP  6'b000011
`define ASR_OP  6'b000100

module alu ( // inputs --> wire: to get the signals from the tb
    input wire[31:0] opr_a_alu_i,
    input wire[31:0] opr_b_alu_i,
    input wire[5:0] op_alu_i,
    output wire[31:0] res_alu_o, // 32 bitalu result
    output wire z_alu_o, // zero flag
    output wire n_alu_o // sign flag checking for a negative sign
);
    // intermediate signals

    wire [31:0] res_alu;
    wire z_alu;
    wire n_alu;
    wire v_alu;
    wire[31:0] opr_b_alu_i;
    wire cin_alu;
    wire[31:0] adder_out_alu;
    wire carry_out_alu;
    wire [31:0] logical_out_alu;
    wire[31:0] shifter_out_alu;
    wire comparator_out_alu;

    // combinational block assignments
    assign res_alu_o = res_alu;
    assign z_alu_o = z_alu;
    assign n_alu_o =n_alu;
    assign opr_b_negated_alu = op_alu_i[0] ? ~opr_b_alu_i:opr_b_alu_i;
    assign cin_alu = op_alu_i[0];
    assign z_alu = ~|res_alu;
    assign n_alu = (v_alu)? opr_a_alu_i[31]:adder_out_alu[31]; //v_alu : overflow flag
    assign res_alu = ((op_alu_i == 'ADD_OP) || (op_alu_i == 'SUB_OP)) ? adder_out_alu: 
    ((op_alu_i == 'SHL_OP) || (op_alu_i == 'LSR_OP)|| (op_alu_i =='ASR_OP))
    ((op_alu_I=='OR_OP) || (op_alu_i == 'AND_OP)||(op_alu_i == 'NOR_OP)|| ((op_alu_i =='SLTU_OP)) ? comparator_out_alu :
    ((op_alu_i == 'SLT_OP)) ? {{31{1'b0}}, n_alu}: 31'hxxxx_xxxx;


    adder A1 (
        .op1 (opr_a_alu_i),
        .op2 (opr_b_negated_alu),
        .cin (cin_alu),
        .sum(adder_out_alu),
        .carry (carry_out_alu),
        .v_flag (v_alu)
    );

    shifter S1 (
        .op1 (opr_a_alu_i),
        .shamt (opr_b_alu_i[5:0]),
        .operation (op_alu_i[2:1]),
        .res (shifter_out_alu)
    ) 

    logical L1 (
        .op1 (opr_a_alu_i),
        .op2 (opr_b_alu_i),
        .operation (op_alu_i[5:3]),
        .res (logical_out_alu)
    );
    comparator C1 (
        .op1 (opr_a_alu_i),
        .op2 (opr_b_alu_i),
        .operation (op_alu_i[5:3]),
        .res (comparator_out_alu)
    );

endmodule