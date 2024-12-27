module pc_reg (
    input wire clk,
    input wire rst,
    input wire[31:0] nxt_pc_reg_i,
    output wire[31:0] nxt_pc_reg_o,
    );

    reg [31:0] nxt_pc_reg;

    assign nxt_pc_reg_o = next_pc_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            next_pc_reg<=31'b0;
        end
        else begin
            nxt_pc_reg<=nxt_pc_reg_i;
        end

    end
    
endmodule