`timescale 1ns / 1ps

module alu_control(
    input wire [1:0] alu_op,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output reg [3:0] alu_ctrl
);
    always @(*) begin
        case (alu_op)
            2'b00: alu_ctrl = 4'b0010; // add (lw, sw, addi)
            2'b01: alu_ctrl = 4'b0110; // sub (beq)
            
            2'b10: begin // R-type
                case (funct3)
                    3'b000: alu_ctrl = (funct7 == 7'b0100000) ? 4'b0110 : 4'b0010; // sub or add
                    3'b111: alu_ctrl = 4'b0000; // and
                    3'b110: alu_ctrl = 4'b0001; // or
                    3'b100: alu_ctrl = 4'b0011; // xor
                    3'b001: alu_ctrl = 4'b0100; // sll
                    3'b101: alu_ctrl = (funct7[5]) ? 4'b1001 : 4'b0101; // sra/srl
                    3'b010: alu_ctrl = 4'b0111; // slt
                    3'b011: alu_ctrl = 4'b1000; // sltu
                    default: alu_ctrl = 4'b1111; // undefined
                endcase
            end
            
            default: alu_ctrl = 4'b1111;
        endcase
    end
endmodule
