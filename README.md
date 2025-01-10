# Clock and Stopwatch on BASYS 3

This project implements a clock and stopwatch system using Verilog on the BASYS 3 FPGA board. The user can switch between the clock and stopwatch modes using the physical buttons on the board. The time is displayed on the 7-segment display.

## Features

- **Two Modes**:
  - **Clock Mode**: Displays the current time, incrementing every second.
  - **Stopwatch Mode**: Allows the user to start, stop, reset, and set the stopwatch.
- **Mode Switching**: Controlled using a button on the BASYS 3 board.
- **Debounced Inputs**: Button presses are debounced to prevent false triggering.
- **Accurate Timing**: A clock divider ensures the system operates at 1 Hz for timekeeping.
- **Seven-Segment Display**: Displays time or stopwatch values.

## Modules

### 1. `clock_divider`
- **Function**: Reduces the 100 MHz input clock signal from the BASYS 3 board to a 1 Hz signal.
- **Purpose**: Provides a stable time base for the clock and stopwatch.

### 2. `seven_segment_display`
- **Function**: Handles the 7-segment display to show numerical values.
- **Purpose**: Displays the current time or stopwatch value based on the selected mode.

### 3. `stopwatch`
- **Function**: Implements the stopwatch functionality, including start, stop, reset, and set features.
- **Purpose**: Tracks elapsed time for the stopwatch mode.

### 4. `clock`
- **Function**: Implements a 24-hour clock.
- **Purpose**: Displays the current time in clock mode.

### 5. `mode_selection`
- **Function**: Handles the selection between clock and stopwatch modes.
- **Purpose**: Determines which mode is active and updates the display accordingly.

### 6. `debounce`
- **Function**: Debounces physical button presses to avoid unintended multiple signals.
- **Purpose**: Ensures accurate and reliable button input.

## How It Works

1. **Mode Selection**:
   - Use the designated button on the BASYS 3 board to toggle between Clock and Stopwatch modes.
   - The active mode is reflected on the 7-segment display.

2. **Clock Mode**:
   - Displays the current time in hours, minutes, and seconds.
   - Time increments every second, driven by the `clock_divider`.

3. **Stopwatch Mode**:
   - Start, stop, reset, and set the stopwatch using the available buttons.
   - Elapsed time is displayed on the 7-segment display.

4. **Debounced Inputs**:
   - All button presses are processed through the `debounce` module to ensure stable operation.

5. **Seven-Segment Display**:
   - Both modes utilize the 7-segment display to show the time or stopwatch value clearly.

---

This project showcases the use of Verilog to design and implement digital systems with accurate timing, efficient mode control, and user interaction using hardware buttons.
