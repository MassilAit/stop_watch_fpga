module clock(
    input CLK,
    input CLK_1Hz,
    input select_button,
    input up_btn,
    input dwn_btn,
    input sel,
    output reg [15:0] numbers
);
    reg [5:0] seconds = 30;
    reg [5:0] minutes = 35;
    reg [4:0] hours   = 16;

    reg up_btn_d, dwn_btn_d;
    reg [5:0] automatic_minutes;
    reg [4:0] automatic_hours;
    
    reg is_min = 1;
    reg sel_d = 0 ;                 //delayed signal
    
    // Select minutes or Hours
    always @(posedge CLK) begin
        if (select_button) begin
            sel_d <= sel;       // Store the previous value of sel
            // Toggle is_min on rising edge of the sel button
            if (sel_d == 1'b0 && sel == 1'b1) begin
                is_min <= ~is_min;
            end
        end
    end

    // Manual adjustment process (CLK domain)
    always @(posedge CLK) begin
        up_btn_d <= up_btn;
        dwn_btn_d <= dwn_btn;
        
        if (select_button) begin
  
            if (up_btn_d == 1'b0 && up_btn == 1'b1) begin
                case(is_min) 
                    1'b0 : begin 
                        if (hours == 23) 
                            hours <= 0;
                        else 
                            hours <= hours + 1;
                        end
                        
                     1'b1 : begin 
                        if (minutes == 59) 
                            minutes <= 0;
                        else 
                            minutes <= minutes + 1;
                        end
                                      
               endcase
            end
            if (dwn_btn_d == 1'b0 && dwn_btn == 1'b1) begin
                case(is_min) 
                    1'b0 : begin 
                        if (hours == 0) 
                            hours <= 23;
                        else 
                            hours <= hours - 1;
                        end
                        
                     1'b1 : begin 
                        if (minutes == 0) 
                            minutes <= 59;
                        else 
                            minutes <= minutes - 1;
                        end
                                      
               endcase
            end
            
        end else begin
            minutes<=automatic_minutes;
            hours<=automatic_hours;
        end
    end

    // Automatic update process (CLK_1Hz domain)
    always @(posedge CLK_1Hz) begin
        if (!select_button) begin
            if (seconds == 59) begin
                seconds <= 0;
                if (automatic_minutes == 59) begin
                    automatic_minutes <= 0;
                    automatic_hours <= (hours == 23) ? 0 : automatic_hours + 1;
                end else begin
                    automatic_minutes <= automatic_minutes + 1;
                end
            end else begin
                seconds <= seconds + 1;
            end
        end else begin
            automatic_minutes <= minutes;
            automatic_hours   <= hours;
        end
       
    end

    // Convert to BCD format for seven-segment display
    always @(*) begin
        numbers[3:0]   = minutes % 10;
        numbers[7:4]   = minutes / 10;
        numbers[11:8]  = hours % 10;
        numbers[15:12] = hours / 10;
    end

endmodule
