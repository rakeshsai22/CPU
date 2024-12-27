//Instruction decoder
`include "/home/snakkill/CPU/singlecycle/rtl/mips_instr_defines.v"

module decode 
    (
        input   wire[31:0]  instr_dec_i,
        input   wire        sign_ext_i,
        output  wire[4:0]   rt_dec_o,
        output  wire[4:0]   rs_dec_o,
        output  wire[4:0]   rd_dec_o,
        output  wire[5:0]   op_dec_o,
        output  wire[5:0]   funct_dec_o,
        output  wire[4:0]   shamt_dec_o,
        output  wire[25:0]  target_dec_o,
        output  wire[31:0]  sign_imm_dec_o,
        output  wire        is_r_type_dec_o,
        output  wire        is_i_type_dec_o,
        output  wire        is_j_type_dec_o,
        output  wire        use_link_reg_dec_o
    );

    //Populate the output fields using the input instruction
    wire[4:0]   rt_dec;
    wire[4:0]   rs_dec;
    wire[4:0]   rd_dec;
    wire[5:0]   op_dec;
    wire[5:0]   funct_dec;
    wire[4:0]   shamt_dec;
    wire[25:0]  target_dec;
    wire[31:0]  sign_imm_dec;
    wire        is_r_type_dec;
    wire        is_i_type_dec;
    wire        is_j_type_dec;
    wire        use_link_reg_dec;


    assign rt_dec_o           = rt_dec;
    assign rs_dec_o           = rs_dec;
    assign rd_dec_o           = rd_dec;
    assign op_dec_o           = op_dec;
    assign funct_dec_o        = funct_dec;
    assign shamt_dec_o        = shamt_dec;
    assign target_dec_o       = target_dec;
    assign sign_imm_dec_o     = sign_imm_dec;
    assign is_r_type_dec_o    = is_r_type_dec;
    assign is_i_type_dec_o    = is_i_type_dec;
    assign is_j_type_dec_o    = is_j_type_dec;
    assign use_link_reg_dec_o = use_link_reg_dec;

    assign sign_imm_dec      = (sign_ext_i) ? {{16{instr_dec_i[15]}},instr_dec_i[15:0]} : 
                                              {16'b0, instr_dec_i[15:0]};
    assign rd_dec            = instr_dec_i[15:11];
    assign rt_dec            = instr_dec_i[20:16];
    assign rs_dec            = instr_dec_i[25:21];
    assign op_dec            = instr_dec_i[31:26];
    assign target_dec        = instr_dec_i[25:0];
    assign funct_dec         = instr_dec_i[5:0];
    assign shamt_dec         = instr_dec_i[10:6];
    assign is_r_type_dec     = (op_dec == 6'h0);
    assign is_i_type_dec     = ((op_dec != 6'h0) && ((op_dec != `J) && (op_dec != `JAL)));
    assign is_j_type_dec     = ((op_dec == `J) || (op_dec == `JAL));
    assign use_link_reg_dec  = (((op_dec == `BVAR) && ((rt_dec == `BLTZAL) || (rt_dec == `BGEZAL))) ||
                               ((is_r_type_dec) && ((funct_dec == `JALR))) ||
                               ((is_j_type_dec) && ((op_dec == `JAL))));
                               
    
endmodule