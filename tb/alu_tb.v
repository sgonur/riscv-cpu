`timescale 1ns / 1ps

    
module alu_tb;
    // Signals
    reg [31:0] a;
    reg [31:0] b;
    reg [3:0] alu_op;
    wire [31:0] result;
    wire zero;
    alu utt (
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .result(result),
        .zero(zero)
    );
    
    initial begin
        $display("Starting Test");
        
        // Test ADD
        a = 32'd10; b = 32'd5; alu_op = 4'b0010; #10;
        $display("ADD (10 + 5): Result = %d | Zero = %b", result, zero);

        // Test SUB
        a = 32'd10; b = 32'd5; alu_op = 4'b0110; #10;
        $display("SUB (10 - 5): Result = %d | Zero = %b", result, zero);

        // Test AND
        a = 32'd10; b = 32'd5; alu_op = 4'b0000; #10;
        $display("AND (10 & 5): Result = %d | Zero = %b", result, zero);

        // Test OR
        a = 32'd10; b = 32'd5; alu_op = 4'b0001; #10;
        $display("OR (10 | 5): Result = %d | Zero = %b", result, zero);

        // Test SLT (signed)
        a = -32'd1; b = 32'd5; alu_op = 4'b0111; #10;
        $display("SLT (-1 < 5): Result = %d | Zero = %b", result, zero);

        // Test XOR
        a = 32'd10; b = 32'd5; alu_op = 4'b0011; #10;
        $display("XOR (10 ^ 5): Result = %d | Zero = %b", result, zero);

        // Test SLL
        a = 32'd1; b = 32'd3; alu_op = 4'b0100; #10;
        $display("SLL (1 << 3): Result = %d | Zero = %b", result, zero);

        // Test SRL
        a = 32'd16; b = 32'd2; alu_op = 4'b0101; #10;
        $display("SRL (16 >> 2): Result = %d | Zero = %b", result, zero);

        // Test SLTU (unsigned)
        a = 32'd1; b = 32'd5; alu_op = 4'b1000; #10;
        $display("SLTU (1 < 5 unsigned): Result = %d | Zero = %b", result, zero);
        
        $display("Tests Complete");
        $stop;
    end
    
endmodule
