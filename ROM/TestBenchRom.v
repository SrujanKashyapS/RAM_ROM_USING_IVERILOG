`timescale 1ns/1ps

module memory_tb;

   // Parameters
   parameter DATA_WIDTH = 8;
   parameter ADDR_WIDTH = 8;
   parameter MEM_DEPTH = 256;

   // Signals
   reg clk;
   reg [ADDR_WIDTH-1:0] addr;
   reg [DATA_WIDTH-1:0] data_in;
   reg we;
   wire [DATA_WIDTH-1:0] data_out_ram, data_out_rom;

   // Instantiate the RAM
   memory #(
       .DATA_WIDTH(DATA_WIDTH),
       .ADDR_WIDTH(ADDR_WIDTH),
       .MEM_DEPTH(MEM_DEPTH),
       .IS_RAM(1)
   ) ram_inst (
       .clk(clk),
       .addr(addr),
       .data_in(data_in),
       .we(we),
       .data_out(data_out_ram)
   );

   // Instantiate the ROM
   memory #(
       .DATA_WIDTH(DATA_WIDTH),
       .ADDR_WIDTH(ADDR_WIDTH),
       .MEM_DEPTH(MEM_DEPTH),
       .IS_RAM(0)
   ) rom_inst (
       .clk(clk),
       .addr(addr),
       .data_in(data_in),
       .we(we),
       .data_out(data_out_rom)
   );

   // Clock generation
   always #5 clk = ~clk;

   // Test sequence
   initial begin
       // Add these lines at the beginning of the initial block
       $dumpfile("memory_waveform.vcd");
       $dumpvars(0, memory_tb);

       // Initialize signals
       clk = 0;
       addr = 0;
       data_in = 0;
       we = 0;

       // Wait for a few clock cycles
       #20;

       // Write to RAM
       we = 1;
       addr = 8'h00;
       data_in = 8'h55;
       #10;
       addr = 8'h01;
       data_in = 8'h66;
       #10;
       addr = 8'h02;
       data_in = 8'h77;
       #10;
       we = 0;

       // Read from RAM
       #10;
       addr = 8'h00;
       #10;
       $display("RAM Read Address 0x00: %h", data_out_ram);
       addr = 8'h01;
       #10;
       $display("RAM Read Address 0x01: %h", data_out_ram);
       addr = 8'h02;
       #10;
       $display("RAM Read Address 0x02: %h", data_out_ram);

       // Read from ROM
       addr = 8'h00;
       #10;
       $display("ROM Read Address 0x00: %h", data_out_rom);
       addr = 8'h01;
       #10;
       $display("ROM Read Address 0x01: %h", data_out_rom);
       addr = 8'h02;
       #10;
       $display("ROM Read Address 0x02: %h", data_out_rom);

       // End simulation
       #10;
       $finish;
   end

endmodule


