module stopwatch(
    input CLK,
    input CLK_1Hz,               // 1 Hz clock signal
    input stop,
    input reset,
    output reg [15:0] numbers    // 16-bit output: [15:12]=min tens, [11:8]=min ones, [7:4]=sec tens, [3:0]=sec ones
);
    reg [5:0] seconds = 0;       // 6-bit counter for seconds (0 to 59)
    reg [7:0] minutes = 0;       // 8-bit counter for minutes (0 to 99)
    reg stop_state = 1;
    reg stop_d = 0 ;                 //delayed signal
    
    always @(posedge CLK) begin
        stop_d <= stop;       // Store the previous value of stop
        // Toggle stop_state on rising edge of the stop button
        if (stop_d == 1'b0 && stop == 1'b1) begin
            stop_state <= ~stop_state;
        end
    end

    always @(posedge CLK_1Hz or posedge reset) begin
        if(reset) begin
            seconds <= 0;
            minutes <= 0;
        
        end else if(!stop_state) begin    // When stop_state is low, counting is active
            // Increment seconds
            if (seconds == 59) begin
                seconds <= 0;       // Reset seconds to 0
                if (minutes == 99) begin
                    minutes <= 0;   // Reset minutes to 0 after 99
                end else begin
                    minutes <= minutes + 1; // Increment minutes
                end
            end else begin
                seconds <= seconds + 1; // Increment seconds
            end
       end
    end

    // Convert to BCD format for seven-segment display
    always @(*) begin
        numbers[3:0]   = seconds % 10;   // Seconds ones place
        numbers[7:4]   = seconds / 10;   // Seconds tens place
        numbers[11:8]  = minutes % 10;   // Minutes ones place
        numbers[15:12] = minutes / 10;   // Minutes tens place
    end

endmodule

