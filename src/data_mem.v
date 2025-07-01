`timescale 1ns / 1ps

module data_mem(
    input wire clk,
    input wire mem_write,
    input wire [31:0] addr,
    input wire [31:0] write_data,
    output [31:0] read_data
);
    /* Creates an array of 256 memory words where each word is 32 bits
       1 kb of ram (256 words * 4 bytes = 1024 bytes*/
    reg [31:0] memory [0:255];
    assign read_data = memory[addr[9:2]]; // 1kb of 32 bit memory
    
    // This block writes to memory on the rising clock edge of the clock 
    always @(posedge clk) begin
        if (mem_write) // if this is true we store the write_data in the memory of the given address
            memory[addr[9:2]] <= write_data; //choose the bits 9 to 2 as the two lowest bits are always 0
    end
endmodule
