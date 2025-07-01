`timescale 1ns / 1ps

module ring_counter(
    input wire clk,
    input wire reset,
    output reg [3:0] an,
    output reg [1:0] dig_on
    );
    
    reg [15:0] counter = 0;
    
    always @(posedge clk) begin
        if (reset) begin
            dig_on <= 0;
            counter <= 0;
        end else begin
            if (counter == 16'd65535) begin
                counter <= 0;
                dig_on <= dig_on + 1;
            end else begin
                counter <= counter + 1;
            end
        end
    end
    
    always @(*) begin
        an = 4'b1111;
        an[dig_on] = 1'b0;
    end
endmodule
