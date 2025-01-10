
module clock_divider(
    input wire CLK, //100 Mhz clock input
    output reg CLK_1Hz // 1 Hz clock output
    );
    
    reg [26:0] counter;
    
    always @(posedge CLK) begin
        if(counter == 49_999_999) begin
            counter <= 0;
            CLK_1Hz <= ~CLK_1Hz;
        
        end else begin
            counter <= counter + 1;
        end
    end
endmodule
