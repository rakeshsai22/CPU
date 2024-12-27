module data_mem(
    input wire clk,
    input wire[31:0] addr_dmem_ram_i, // byte addressable mem address
    input wire[31:0] wr_data_dmem_ram_i, //data to be return
    input wire[0:3] wr_strb_dmem_ram_i, // write strobe / byte enable >> eacch bit in this signal enables writing to one byte in the 32 bit word
    // this selective writing is necessary for unaligned memory accesses >> storing a 1 byte in 32 bit mem
    input wire wr_en_dmem_ram_i,
    output wire[31:0] read_data_dmem_ram_o
    );
    
    parameter data_seg_begin = 32'h1000; // base address of the data segment

    parameter data_seg_size = 32'h100000; // size of the segment in bytes
    reg [31:0] dmem[0:data_seg_size]; // word addressable data array

    wire[31:0] read_data;
    //  wr_strb_dmem_ram_i -> 1 bit to mask 8 bits
    wire[31:0] wr_strb = {wr_strb_dmem_ram_i[3],wr_strb_dmem_ram_i[3],wr_strb_dmem_ram_i[3],wr_strb_dmem_ram_i[3],
                          wr_strb_dmem_ram_i[3],wr_strb_dmem_ram_i[3],wr_strb_dmem_ram_i[3],wr_strb_dmem_ram_i[3],  
                          wr_strb_dmem_ram_i[2],wr_strb_dmem_ram_i[2],wr_strb_dmem_ram_i[2],wr_strb_dmem_ram_i[2], 
                          wr_strb_dmem_ram_i[2],wr_strb_dmem_ram_i[2],wr_strb_dmem_ram_i[2],wr_strb_dmem_ram_i[2], 
                          wr_strb_dmem_ram_i[1],wr_strb_dmem_ram_i[1],wr_strb_dmem_ram_i[1],wr_strb_dmem_ram_i[1], 
                          wr_strb_dmem_ram_i[1],wr_strb_dmem_ram_i[1],wr_strb_dmem_ram_i[1],wr_strb_dmem_ram_i[1], 
                          wr_strb_dmem_ram_i[0],wr_strb_dmem_ram_i[0],wr_strb_dmem_ram_i[0],wr_strb_dmem_ram_i[0], 
                          wr_strb_dmem_ram_i[0],wr_strb_dmem_ram_i[0],wr_strb_dmem_ram_i[0],wr_strb_dmem_ram_i[0]};

    assign read_data_dmem_ram_o = read_data;
    always @(posedge clk) begin
        if (wr_en_dmem_ram_i) begin
            dmem[((addr_dmem_ram_i - data_seg_begin)&(~32'h3))>>2] <= ((wr_data_dmem_ram_i & wr_strb)| (~wr_strb & read_data));
        end
    end
    assign read_data= dmem[((addr_dmem_ram_i - data_seg_begin)&(~32'h3))>>2];
endmodule
