// Code your design here
module inst_mem (
    input wire clk,
  input wire[31:0] addr_imem_ram_i, // addr inp to access inst mem
  input wire[31:0] wr_inst_imem_ram_i, // instr to be written into the memory
    input wire wr_en_imem_ram_i,
  output wire[31:0] read_int_imem_ram_o // out: instr fetched from the memory
    );
  reg [31:0] imem[1023:0]; // mem array to store instructions : 4KB instruction memory (word-addressable 1024 * 32 bit words)
//    initial begin
//     integer i;
//     for (i = 0; i < 1024; i = i + 1) begin
//         imem[i] = 32'h0000_0000;
//     end
//   end
  wire[31:0] read_inst; // reg to hold fetched instrs
  wire [31:0] shifted_read_addr; //word-aligned by shifting byte address
    assign read_inst_imem_ram_o = read_inst; 
  
  // align input address to word boundaries (div by 4)
    assign shifted_read_addr = (addr_imem_ram_i & 32'hFFFF_FFFC)>>2;

    always @(posedge clk) begin
        if(wr_en_imem_ram_i) begin
            imem[shifted_read_addr]<= wr_inst_imem_ram_i;
        end
    end
    assign read_inst = imem[shifted_read_addr];
    
endmodule