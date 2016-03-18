// Handwritten ROM to hold the commands to send to the AFE
// Format:
//   [ 23: 20 ] command to state machine
//      0000: stop, no further valid commands
//      0001: valid command to send
//      others: reserved
//   [ 19: 0 ] 20-bit command to be sent to the AFE over SPI
module afe_command_rom
       (
         input clk, reset_n,
         input [ 7: 0 ] address,
         output [ 23: 0 ] command
       );

// Memory variable
reg [ 23: 0 ] rom[ 7: 0 ];

reg [ 23: 0 ] command_reg;
assign command = command_reg;

// ROM initialization
initial
begin
  // Read hex memory from file
  // Relative path from this Verilog file
  $readmemh( "../rom_data/afe_configuration_rom_data.txt", rom );
end

// ROM controller
always @( posedge clk ) begin
  command_reg <= rom[ address ];
end

endmodule
