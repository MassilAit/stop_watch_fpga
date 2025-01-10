module top_level(
    input CLK,               // 100 MHz clock input
    input [2:0] BTN,
    input [1:0] SW,
    output [7:0] SSEG_CA,
    output [3:0] SSEG_AN
);

    // Internal signals to interface modules
    wire CLK_1Hz;
    
    // 7-Segments 
    wire [15:0] numbers_stop_watch;
    wire [15:0] numbers_clock;
    wire [15:0] numbers;
    
    //Debouce buttons
    wire [3:0] BTN_clean;
    
    //Buttons clock module
    wire select_button_clock;
    wire up_btn_clock;
    wire dwn_btn_clock;
    wire sel_clock;
    
    //Buttons stop watch module
    wire stop_watch;
    wire reset_watch;
    
    
    //Debounce Module
    debounce u_debounce(
        .CLK(CLK),
        .BTN(BTN),
        .BTN_clean(BTN_clean)   
    );
    
    mode_selection u_mode_selection(
        .BTN_clean(BTN_clean),
        .SW(SW),
        .numbers_clock(numbers_clock),
       . numbers_stop_watch(numbers_stop_watch),
       .select_button_clock(select_button_clock),
       .up_btn_clock(up_btn_clock),
       .dwn_btn_clock(dwn_btn_clock),
       .sel_clock(sel_clock),
       .stop_watch(stop_watch),
       .reset_watch(reset_watch),
       .numbers(numbers)
    );

    // Instantiate the clock_divider module to generate the 1Hz clock
    clock_divider u_clock_divider(
        .CLK(CLK),             // 100 MHz clock input
        .CLK_1Hz(CLK_1Hz)      // 1 Hz clock output
    );

    // Instantiate the stopwatch module
    stopwatch u_stopwatch(
        .CLK(CLK),              // 100 MHz clock signal 
        .CLK_1Hz(CLK_1Hz),      // 1 Hz clock input
        .stop(stop_watch),
        .reset(reset_watch),
        .numbers(numbers_stop_watch)       // Seven_segement output
    );
    
    // Instantiate the clock module
    clock u_clock(
        .CLK(CLK),              // 100 MHz clock signal 
        .CLK_1Hz(CLK_1Hz),      // 1 Hz clock input
        .select_button(select_button_clock),
        .up_btn(up_btn_clock),
        .dwn_btn(dwn_btn_clock),
        .sel(sel_clock),
        .numbers(numbers_clock)       // Seven_segement output
    );
    
    //Seven Segement module
    seven_segment_display u_seven_segment(
        .CLK(CLK),
        .numbers(numbers),
        .segments(SSEG_CA),
        .anodes(SSEG_AN)
    );
    

endmodule