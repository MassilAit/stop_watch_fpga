module mode_selection(
    input [3:0] BTN_clean,
    input [1:0] SW,
    input [15:0] numbers_clock,
    input [15:0] numbers_stop_watch,
    output reg select_button_clock,
    output reg up_btn_clock,
    output reg dwn_btn_clock,
    output reg sel_clock,
    output reg stop_watch,
    output reg reset_watch,
    output reg [15:0] numbers
    );
    
    // 7-segment output
    always @(*) begin
        case(SW[0])
            1'b0 : numbers <= numbers_clock;
            1'b1 : numbers <= numbers_stop_watch;
        endcase
    end
    
    //Clock buttons
    always @(*) begin
        case(SW[0])
            1'b0 : begin
                select_button_clock <= SW[1];
                up_btn_clock <= BTN_clean[1];
                dwn_btn_clock <= BTN_clean[0];
                sel_clock <= BTN_clean[2];    
            end
            
            1'b1 : begin
                select_button_clock <= 1'b0;
                up_btn_clock <= 1'b0;
                dwn_btn_clock <= 1'b0;
                sel_clock <= 1'b0;    
            end
           
        endcase 
    end
    
    //Stop Watch buttons
    always @(*) begin
        case(SW[0])
            1'b0 : begin
                stop_watch <= 1'b0;
                reset_watch <= 1'b0;   
            end
            
            1'b1 : begin
                stop_watch <= BTN_clean[1];
                reset_watch <= BTN_clean[0];      
            end
           
        endcase 
    end
endmodule
