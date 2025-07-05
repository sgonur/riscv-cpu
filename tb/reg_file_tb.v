`timescale 1ns / 1ps

module reg_file_tb; 
    // Input
    reg clk;
    reg reg_write;
    reg [4:0] rs1, rs2, rd;
    reg [31:0] wd;
    
    // Output
    wire [31:0] rd1, rd2;
    
    reg_file uut (
        .clk(clk),
        .reg_write(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );
   
    // Clock Generation
    always #5 clk = ~clk;
    
    initial begin
        $display("Starting Test");
        clk = 0;
        reg_write = 0;
        rs1 = 0; rs2 = 0; rd = 0;
        wd = 0;
        
        // Write to register 1
        reg_write = 1;
        rd = 5'd1;
        wd = 32'hABCD1234;
        #10
        
        // Read register 1
        reg_write = 0;
        rs1 = 5'd1;
        rs2 = 5'd0;
        #10
        $display("Read from x1: %h | Read from x0: %h", rd1, rd2);
        
        // Test that x0 always stays zero
        reg_write = 1;
        rd = 5'd0;
        wd = 32'hFFFFFFFF;
        #10;

        reg_write = 0;
        rs1 = 5'd0;
        #10;
        $display("Read from x0 after write attempt: %h", rd1);
        
        $display("Tests Completed");
        $stop;
    
    end

endmodule

 