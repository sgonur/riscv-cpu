`timescale 1ns / 1ps

module display_digs(
    input wire clk,
    input wire reset,
    input [15:0] hex,
    output [3:0] an,
    output [6:0] seg,
    output dp
    );
    
    wire [1:0] idx;
    ring_counter rc (.clk(clk), .reset(reset), .an(an), .dig_on(idx));
    
    wire [3:0] nibs;
    selector sel (.idx(idx), .hex(hex), .nib(nibs));
    
    wire [6:0] seg_on;
    hex7seg seggg (.n(nibs), .seg(seg_on));
    assign seg = ~seg_on;
    assign dp = 1'b1;
     
endmodule
