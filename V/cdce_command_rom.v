// ROM initializer to provide instructions/data to the configuration system
module cdce_command_rom
       (
         input clk, reset_n,
         input [ 7: 0 ] address,
         output [ 35: 0 ] command
       );

// Memory variable
reg [ 35: 0 ] rom[ 7: 0 ];

reg [ 35: 0 ] command_reg;
assign command = command_reg;

// ROM initialization
initial
begin
  // Read hex memory from file
  // Relative path from this Verilog file
  $readmemh( "../rom_data/cdce_configuration_rom_data.txt", rom );
end

// ROM controller
always @( posedge clk ) begin
  command_reg <= rom[ address ];
end

endmodule
