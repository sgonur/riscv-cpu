`timescale 1ns / 1ps

module instruction_mem(
    input wire [31:0] addr, // 32 address input
    output [31:0] instr // 32 bit instruction output
);
    reg [31:0] memory [0:255]; // 256 instructions
    
    initial begin
        $readmemh("prog.mem", memory); // Load program
    end
    
    assign instr = memory[addr[9:2]]; // word aligned
    
endmodule
