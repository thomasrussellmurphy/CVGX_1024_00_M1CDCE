module afe_command_controller
       (
         input clk, reset_n,
         input enable,
         input serial_ready,
         input [ 23: 0 ] controller_command,
         output [ 7: 0 ] rom_address,
         output [ 19: 0 ] afe_command,
         output start_transaction,
         output done
       );

// Controller commands from afe_command_rom
parameter
  COMMAND_TO_SEND = 4'b0001,
  SEQUENCE_DONE = 4'b0000;

// State machine parameterized states
parameter
  init_state = 3'd0,
  wait_state = 3'd1,
  fetch_state = 3'd2,
  trigger_state = 3'd3,
  delay_state = 3'd4,
  increment_state = 3'd5,
  done_state = 3'd6;

// State machine state storage
reg [ 2: 0 ] state, next_state;

// Command processing
wire [ 3: 0 ] command;
assign command = controller_command[ 23: 20 ];

assign afe_command = controller_command[ 19: 0 ];

// System outputs
reg start_transaction_reg, done_reg;
reg [ 7: 0 ] current_address;

assign start_transaction = start_transaction_reg;
assign done = done_reg;
assign rom_address = current_address;

// State machine control
always @( posedge clk or negedge reset_n ) begin
  if ( ~reset_n )
  begin
    state <= init_state;
  end else
  begin
    state <= next_state;
  end
end

// Combinational next-state calculation
always @( state, enable, serial_ready, command ) begin
  case ( state )
    init_state:
    begin
      if ( enable )
      begin
        // Once enabled, can wait for serial module to be ready
        next_state = wait_state;
      end else
      begin
        next_state = init_state;
      end
    end
    wait_state:
    begin
      if ( serial_ready )
      begin
        // When the serial is ready, fetch the next command
        next_state = fetch_state;
      end else
      begin
        next_state = wait_state;
      end
    end
    fetch_state:
    begin
      if ( command == COMMAND_TO_SEND )
      begin
        // With a valid command, trigger the serial module
        next_state = trigger_state;
      end else if ( command == SEQUENCE_DONE )
      begin
        next_state = done_state;
      end else
      begin
        // Terminate on invalid state machine command
        next_state = done_state;
      end
    end
    trigger_state:
    begin
      // Always transition to delay before incrementing
      next_state = delay_state;
    end
    delay_state:
    begin
      // Always transition to increment
      next_state = increment_state;
    end
    increment_state:
    begin
      // Always transition to wait for next serial_ready
      next_state = wait_state;
    end
    // done_state uses default
    default:
    begin
      next_state <= done_state;
    end
  endcase
end

// Control all the outputs based on state machine
always @( posedge clk or negedge reset_n ) begin
  if ( ~reset_n )
  begin
    current_address <= 7'b0;
    start_transaction_reg <= 1'b0;
    done_reg <= 1'b0;
  end else
  begin
    // Control the current_address
    case ( state )
      increment_state:
      begin
        current_address <= current_address + 1'b1;
      end
      default:
      begin
        current_address <= current_address;
      end
    endcase

    // Control the start_transaction
    case ( state )
      trigger_state:
      begin
        start_transaction_reg <= 1'b1;
      end
      default:
      begin
        start_transaction_reg <= 1'b0;
      end
    endcase

    // Control the done
    case ( state )
      done_state:
      begin
        done_reg <= 1'b1;
      end
      default:
      begin
        done_reg <= 1'b0;
      end
    endcase
  end
end

endmodule
