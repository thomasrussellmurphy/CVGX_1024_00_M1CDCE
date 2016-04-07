// Module to connect the parts of the CDCE configuration system
module cdce_configure
       (
         input clk, reset_n,
         input miso,
         output pdn,
         output cs_n,
         output mosi,
         output device_sync,
         output configure_done
       );

// CDCE power down and sync are active low, so disable both
assign pdn = 1'b1;
assign device_sync = 1'b1;

// Don't have an upstream reset before starting configuration (always be done)
wire reset_done = 1'b1;

wire transaction_done;
wire start_transaction;
wire command_transactions_done;

assign configure_done = command_transactions_done;

wire [ 3: 0 ] controller_command;
wire [ 31: 0 ] cdce_command;
wire [ 7: 0 ] rom_address;

cdce_command_controller command_controller
                        (
                          .clk( clk ),
                          .reset_n( reset_n ),
                          .enable( reset_done ),
                          .serial_ready( transaction_done ),
                          .command( controller_command ),
                          .rom_address( rom_address ),
                          .start_transaction( start_transaction ),
                          .done( command_transactions_done )
                        );

cdce_command_rom command_rom
                 (
                   .clk( clk ),
                   .reset_n( reset_n ),
                   .address( rom_address ),
                   .controller_command( controller_command ),
                   .cdce_shift_data( cdce_command )
                 );

cdce_serial_out serial_out
                (
                  .clk( clk ),
                  .reset_n( reset_n ),
                  .enable( reset_done ),
                  .start_transaction( start_transaction ),
                  .parallel_input( cdce_command ),
                  .cs_n( cs_n ),
                  .mosi( mosi ),
                  .transaction_done( transaction_done )
                );

endmodule
