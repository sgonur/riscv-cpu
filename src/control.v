`timescale 1ns / 1ps

module control(
    input wire [6:0] opcode,
    output reg reg_write,
    output reg alu_src,
    output reg mem_to_reg,
    output reg mem_write,
    output reg branch,
    output reg [1:0] alu_op
);
    always @(*) begin
        reg_write = 0;
        alu_src = 0;
        mem_to_reg = 0;
        mem_write = 0;
        branch = 0;
        alu_op = 2'b00;
        
        case (opcode)
             7'b0110011: begin // R-Type (add, sub, and, or, etc.)
                reg_write = 1;
                alu_src = 0;
                mem_to_reg = 0;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b10;
             end
             
             7'b0010011: begin // I-Type immediate (addi, slti, etc.)
                reg_write = 1;
                alu_src = 1;
                mem_to_reg = 0;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b00;
             end
             
             7'b0000011: begin // Load instructions (lw, lb, etc.)
                reg_write = 1;
                alu_src = 1;
                mem_to_reg = 1;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b00;
             end
             
             7'b0100011: begin // Store instructions (sw, sb, etc.)
                reg_write = 0;
                alu_src = 1;
                mem_to_reg = 0;
                mem_write = 1;
                branch = 0;
                alu_op = 2'b00;
             end
             
             7'b1100011: begin // Branch instructions (beq, bne, etc.)
                reg_write = 0;
                alu_src = 0;
                mem_to_reg = 0;
                mem_write = 0;
                branch = 1;
                alu_op = 2'b01;
             end
             
             7'b0110111: begin // LUI (Load Upper Immediate)
                reg_write = 1;
                alu_src = 0;
                mem_to_reg = 0;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b00;
             end
             
             7'b1101111: begin // JAL (Jump and Link)
                reg_write = 1;
                alu_src = 0;
                mem_to_reg = 0;
                mem_write = 0;
                branch = 1;
                alu_op = 2'b00;
             end
             
             default: begin // Handle undefined opcodes
                reg_write = 0;
                alu_src = 0;
                mem_to_reg = 0;
                mem_write = 0;
                branch = 0;
                alu_op = 2'b00;
             end
        endcase
    end
endmodule
