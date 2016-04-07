// ROM initializer to provide instructions/data to the configuration system
module cdce_command_rom
       (
         input clk, reset_n,
         input [ 7: 0 ] address,
         output [ 3: 0 ] controller_command,
         output [ 31: 0 ] cdce_shift_data
       );

// Memory variable
reg [ 35: 0 ] rom[ 7: 0 ];

reg [ 35: 0 ] command_reg;

assign controller_command = command_reg[ 35: 32 ];
assign cdce_shift_data = command_reg[ 31: 0 ];

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
