module seven_segment_display(
    input CLK, // 100MHz clock
    input [15:0] numbers, //4*4 bits numbers
    output reg [7:0] segments,
    output reg [3:0]anodes
    );
    
    reg [1:0] current_digit = 0; // Active digit (0-3)
    
    reg slow_clk = 0;
    reg [16:0] counter = 0; // 17-bit counter (log2(100_000_000 / 1000))

    always @(posedge CLK) begin
        counter <= counter + 1;
        if (counter == 49_999) begin
            counter <= 0;
            slow_clk <= ~slow_clk; // Toggle slow clock every 50,000 cycles
        end
    end
    
    // Segment encoding
    
    always @(*) begin
        case (numbers[4 * current_digit +: 4]) // Select current digit's value
            4'd0: segments = 8'b10000001;
            4'd1: segments = 8'b11001111;
            4'd2: segments = 8'b10010010;
            4'd3: segments = 8'b10000110;
            4'd4: segments = 8'b11001100;
            4'd5: segments = 8'b10100100;
            4'd6: segments = 8'b10100000;
            4'd7: segments = 8'b10001111;
            4'd8: segments = 8'b10000000;
            4'd9: segments = 8'b10000100;
            default: segments = 8'b11111111; // Blank
        endcase
    end
    
    // Multiplexing logic
    always @(posedge slow_clk) begin
        current_digit <= current_digit + 1;   // Cycle through digits
        anodes <= ~(4'b0001 << current_digit); // Activate current anode (active low)
    end
endmodule
