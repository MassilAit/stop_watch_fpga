module debounce (
    input wire CLK,                        // System clock
    input wire [3:0] BTN,                  // Raw button inputs
    output reg [3:0] BTN_clean             // Debounced button outputs
);

    // Internal signals
    reg [3:0] BTN_sync_0 = 4'b0;           // First stage synchronizer
    reg [3:0] BTN_sync_1 = 4'b0;           // Second stage synchronizer
    reg [19:0] counter [3:0]; // Counter for each button
    reg [3:0] counter_en = 4'b0;           // Counter enable for each button

    integer i;

    // Synchronize the button inputs to avoid metastability
    always @(posedge CLK) begin
        BTN_sync_0 <= BTN;
        BTN_sync_1 <= BTN_sync_0;
    end

    // Debounce logic for each button
    always @(posedge CLK) begin
        for (i = 0; i < 4; i = i + 1) begin
            if (BTN_sync_1[i] != BTN_clean[i]) begin
                counter_en[i] <= 1'b1; // Start counting if input changes
            end else begin
                counter_en[i] <= 1'b0; // Stop counting if input stabilizes
            end

            if (counter_en[i]) begin
                counter[i] <= counter[i] + 1'b1;
                if (counter[i] == {20{1'b1}}) begin
                    BTN_clean[i] <= BTN_sync_1[i]; // Update output after debounce
                    counter_en[i] <= 1'b0;        // Disable counter
                    counter[i] <= {20{1'b0}}; // Reset counter
                end
            end else begin
                counter[i] <= {20{1'b0}}; // Reset counter when not enabled
            end
        end
    end

endmodule

