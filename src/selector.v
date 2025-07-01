`timescale 1ns / 1ps

module selector(
    input [1:0] idx,
    input [15:0] hex,
    output reg [3:0] nib
    );
    
    always @(*)
        case (idx)
            2'b00: nib = hex[3:0];   // Rightmost digit
            2'b01: nib = hex[7:4];   // 2nd digit
            2'b10: nib = hex[11:8];  // 3rd digit
            2'b11: nib = hex[15:12]; // Leftmost digit
        endcase
endmodule
