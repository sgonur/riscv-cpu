module hex7seg (
    input  [3:0] n,
    output reg [6:0] seg    // still active-high here
);
    always @(*) begin
        case (n)
            4'h0: seg = 7'b0111111; // 0: a,b,c,d,e,f ON, g OFF
            4'h1: seg = 7'b0000110; // 1: b,c ON
            4'h2: seg = 7'b1011011; // 2: a,b,g,e,d ON
            4'h3: seg = 7'b1001111; // 3: a,b,g,c,d ON
            4'h4: seg = 7'b1100110; // 4: f,g,b,c ON
            4'h5: seg = 7'b1101101; // 5: a,f,g,c,d ON
            4'h6: seg = 7'b1111101; // 6: a,f,g,e,d,c ON
            4'h7: seg = 7'b0000111; // 7: a,b,c ON
            4'h8: seg = 7'b1111111; // 8: all segments ON
            4'h9: seg = 7'b1101111; // 9: a,b,c,d,f,g ON
            4'hA: seg = 7'b1110111; // A: a,b,c,e,f,g ON
            4'hB: seg = 7'b1111100; // b: f,g,e,d,c ON
            4'hC: seg = 7'b0111001; // C: a,f,e,d ON
            4'hD: seg = 7'b1011110; // d: b,g,e,d,c ON
            4'hE: seg = 7'b1111001; // E: a,f,g,e,d ON
            4'hF: seg = 7'b1110001; // F: a,f,g,e ON
        endcase
    end
endmodule
