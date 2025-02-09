module uart_tx {
    input  logic clk,           // System clock
    input  logic rst,           // Reset
    input  logic tx_start,      // Start transmission
    input  logic [7:0] tx_data, // Data to transmit
    output logic tx,            // UART transmit line (serial ouput)
    output logic tx_busy        // Transmission in progress
};


//parameters
paramter CLK_FREQ = 50_000_000; //50 MHz
parameter BAUD_RATE = 115200; //bits per second
localparam BAUD_TICKS = CLK_FREQ / BAUD_RATE; 

typedef enum logic [1:0] { IDLE, START, DATA, STOP } state_t;
state_t state;

// Instantiate baud generator for tx
  baud_gen #(.OVERSAMPLE(1)) u_baud_tx (
    .clk(clk),
    .rst_n(rst_n),
    .tx_tick(tx_tick),
    .rx_tick() // Unused
  );

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        tx <= 1; //idle state
        baud_counter <= 0; //not declared yet
        bit_index <= 0; //not decalred yet
        tx_busy <= 0; 
    end else begin 
        case (state)
            IDLE: begin
            end

            START: begin
                tx <= 1'b0; // Start bit (low)
                if (tx_tick) state <= DATA; // If tx_tick state is on, then the state will be START
            end

            DATA: begin
            end

            STOP: begin
            end
        endcase
    end     
end
endmodule