module memory #(
   parameter DATA_WIDTH = 8,
   parameter ADDR_WIDTH = 8,
   parameter MEM_DEPTH = 256,
   parameter IS_RAM = 1
) (
   input wire clk,
   input wire [ADDR_WIDTH-1:0] addr,
   input wire [DATA_WIDTH-1:0] data_in,
   input wire we,
   output reg [DATA_WIDTH-1:0] data_out
);

   // Memory array
   reg [DATA_WIDTH-1:0] mem [0:MEM_DEPTH-1];

   // Initialize memory for ROM functionality
   initial begin
       if (!IS_RAM) begin
           // Example: Initialize with some data
           mem[0] = 8'hAA;
           mem[1] = 8'hBB;
           mem[2] = 8'hCC;
           // ... add more initializations as needed
       end
   end

   // Read operation
   always @(posedge clk) begin
       data_out <= mem[addr];
   end

   // Write operation (only for RAM)
   always @(posedge clk) begin
       if (IS_RAM && we) begin
           mem[addr] <= data_in;
       end
   end

endmodule
