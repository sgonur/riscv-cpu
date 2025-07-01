module seg_selector(
    input wire clk,
    input wire reset,
    input [15:0] hex,
    output reg [3:0] an,
    output wire [6:0] seg,
    output wire dp 
    );
    
    // Counter for slower refresh rate (adjust width as needed)
    reg [19:0] counter = 0;  // ~1ms refresh at 100MHz clock
    reg [1:0] sel = 0;
    
    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
            sel <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == 0)  // Overflow triggers digit change
                sel <= sel + 1;  // Fixed syntax here
        end
    end
    
    reg [3:0] nib;
    always @(*) begin
        case (sel)
            2'd0: nib = hex[3:0];
            2'd1: nib = hex[7:4];
            2'd2: nib = hex[11:8];
            default: nib = hex[15:12];
        endcase
    end
    
    always @(*) begin
        an = 4'b1111;
        an[sel] = 1'b0;
    end
    
    wire [6:0] seg_hi;
    hex7seg H (.n(nib), .seg(seg_hi));
    assign seg = ~seg_hi;
    assign dp  = 1'b1;
endmodule