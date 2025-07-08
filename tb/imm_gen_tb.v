module imm_gen_tb;
    // Input 
    reg [31:0] instr;
    // Output
    wire [31:0] imm_out;
    
    imm_gen uut (
        .instr(instr),
        .imm_out(imm_out)
    );
    
    initial begin
        $display("Starting Immediate Generator Test");
        
        // Test I-Type: addi x1, x2, -4 (imm = 0xFFFFFFFC)
        instr = 32'b111111111100_00010_000_00001_0010011;
        #10;
        $display("I-type: instr = %h, imm = %h (expected FFFFFFFC)", instr, imm_out);
        
        // Test S-Type: sw x5, -8(x1) (imm = 0xFFFFFFF8)
        instr = 32'b1111111_00101_00001_010_11000_0100011;
        #10;
        $display("S-type: instr = %h, imm = %h (expected FFFFFFF8)", instr, imm_out);
        
        // Test B-Type: beq x1, x2, -4 (imm = 0xFFFFFFFC)
        // For -4: imm[12:1] = 111111111110 (12-bit signed)
        // Bit mapping: [31]=imm[12], [7]=imm[11], [30:25]=imm[10:5], [11:8]=imm[4:1]
        // -4 = 0xFFE (bits 11:0), so: imm[12]=1, imm[11]=1, imm[10:5]=111111, imm[4:1]=1110
        instr = 32'b1_111111_00010_00001_000_1110_1_1100011;
        #10;
        $display("B-type: instr = %h, imm = %h (expected FFFFFFFC)", instr, imm_out);
        
        // Test U-Type: lui x1, 0x12345 (imm = 0x12345000)
        instr = 32'b00010010001101000101_00001_0110111;
        #10;
        $display("U-type: instr = %h, imm = %h (expected 12345000)", instr, imm_out);
        
        // Test J-Type: jal x1, 256 (imm = 0x00000100)
        // For +256: imm[20:1] = 00000000100000000000 (20-bit)
        // Bit mapping: [31]=imm[20], [19:12]=imm[19:12], [20]=imm[11], [30:21]=imm[10:1]
        // 256 = 0x100, so: imm[20]=0, imm[19:12]=00000001, imm[11]=0, imm[10:1]=0000000000
        instr = 32'b0_0000000000_0_00000001_00001_1101111;
        #10;
        $display("J-type: instr = %h, imm = %h (expected 00000100)", instr, imm_out);
        
        // Additional test: Positive I-type immediate
        instr = 32'b000001100100_00100_000_00011_0010011;
        #10;
        $display("I-type (positive): instr = %h, imm = %h (expected 00000064)", instr, imm_out);
        
        // Debug: Let's test a simple B-type case
        // beq x0, x0, +4 (imm = 0x00000004)
        // For +4: imm[12:1] = 000000000010
        // imm[12]=0, imm[11]=0, imm[10:5]=000000, imm[4:1]=0010
        instr = 32'b0_000000_00000_00000_000_0010_0_1100011;
        #10;
        $display("B-type (+4): instr = %h, imm = %h (expected 00000004)", instr, imm_out);
        
        $display("Immediate Generator test complete.");
        $stop;        
    end
endmodule