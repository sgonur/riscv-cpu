`timescale 1ns / 1ps

module branch_logic(
    input wire branch,
    input wire [2:0] funct3,
    input wire [31:0] rs1_val,
    input wire [31:0] rs2_val,
    output reg take_branch
 );
    always @(*) begin
        if (!branch) begin
            take_branch = 0;
        end else begin
            case (funct3)
                3'b000: take_branch = (rs1_val == rs2_val); // beq
                3'b001: take_branch = (rs1_val != rs2_val); // bne
                3'b100: take_branch = ($signed(rs1_val) < $signed(rs2_val)); // blt
                3'b101: take_branch = ($signed(rs1_val) >= $signed(rs2_val)); // bge
                3'b110: take_branch = (rs1_val < rs2_val); // bltu
                3'b111: take_branch = (rs1_val >= rs2_val); // bgeu
                default: take_branch = 0;
            endcase
        end
    end         
endmodule
