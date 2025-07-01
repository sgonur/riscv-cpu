`timescale 1ns / 1ps

module reg_file(
    input wire clk,
    input wire reg_write,
    input wire [4:0] rs1, rs2, rd,
    input wire [31:0] wd,
    output [31:0] rd1, rd2
    );
    
    reg [31:0] registers [0:31];
    assign rd1 = (rs1 != 0) ? registers[rs1] :0;
    assign rd2 = (rs2 != 0) ? registers[rs2] :0;
    
    always @(posedge clk) begin 
        if (reg_write && rd != 0)
            registers[rd] <= wd;
    end
    
endmodule
