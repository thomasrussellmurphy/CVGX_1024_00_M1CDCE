// Module to simply send the AFE the 20-bit commands
module afe_serial_out
       (
         input clk, reset_n,
         input enable,
         input start_transaction,
         input [ 19: 0 ] parallel_input,
         output cs_n,
         output mosi,
         output transaction_done
       );

// State machine parameterized states
parameter idle_state = 3'd0,
          load_state = 3'd1,
          shifting_state = 3'd2,
          delay_state = 3'd3;

reg cs_reg, transaction_done_reg;
assign cs_n = ~cs_reg;  // Active low conversion
assign transaction_done = transaction_done_reg;

// State machine state storage
reg [ 2: 0 ] state, next_state;
reg [ 4: 0 ] shift_out_count;

// State machine internal control signals
reg enable_shift, load_shift;

// Manual instantiation of the lpm_shiftreg
lpm_shiftreg shiftreg20 (
               .clock ( clk ),
               .aclr ( ~reset_n ),
               .data ( parallel_input ),
               .load ( load_shift ),
               .enable ( enable_shift ),
               .shiftout ( mosi )
               // synopsys translate_off
               ,
               .aset (),
               .q (),
               .sclr (),
               .shiftin (),
               .sset ()
               // synopsys translate_on
             );
defparam
  shiftreg20.lpm_direction = "LEFT",
  shiftreg20.lpm_type = "LPM_SHIFTREG",
  shiftreg20.lpm_width = 20;

// Registered processes
always @( posedge clk or negedge reset_n ) begin
  if ( ~reset_n )
  begin
    state <= idle_state;
    enable_shift <= 1'b0;
    load_shift <= 1'b0;
    shift_out_count <= 5'b0;
    transaction_done_reg <= 1'b0;
    cs_reg <= 1'b0;
  end else
  begin
    state <= next_state;

    case ( state )
      idle_state:
      begin
        enable_shift <= 1'b0;
        load_shift <= 1'b0;
        shift_out_count <= 5'd19;

        // disable done-ness when starting
        transaction_done_reg <= ~start_transaction;
        cs_reg <= 1'b0;
      end
      load_state:
      begin
        enable_shift <= 1'b1;
        load_shift <= 1'b1;
        shift_out_count <= 5'd19;

        transaction_done_reg <= 1'b0;
        cs_reg <= 1'b0;
      end
      shifting_state:
      begin
        enable_shift <= 1'b1;
        load_shift <= 1'b0;
        shift_out_count <= shift_out_count - 1'b1;

        transaction_done_reg <= 1'b0;
        cs_reg <= 1'b1;
      end
      // delay_state uses default
      default:
      begin
        enable_shift <= 1'b0;
        load_shift <= 1'b0;
        shift_out_count <= 5'd19;

        transaction_done_reg <= 1'b1;
        cs_reg <= 1'b0;
      end
    endcase
  end
end

// Combinational next-state calculation
always @( state, start_transaction, shift_out_count, enable ) begin
  case ( state )
    idle_state:
    begin
      if ( start_transaction & enable )
      begin
        next_state = load_state;
      end else
      begin
        next_state = idle_state;
      end
    end
    load_state:
    begin
      next_state = shifting_state;
    end
    shifting_state:
    begin
      if ( shift_out_count == 1'b1 )
      begin
        next_state = delay_state;
      end else
      begin
        // A single cycle to ensure deadtime between transactions
        next_state = shifting_state;
      end
    end
    // delay_state uses default
    default:
    begin
      next_state = idle_state;
    end
  endcase
end
endmodule
