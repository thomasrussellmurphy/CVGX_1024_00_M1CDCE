
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module CVGX_1024_00_M1CDCE(

	//////////// CLOCK //////////
	CLOCK_125_p,
	CLOCK_50_B5B,
	CLOCK_50_B6A,
	CLOCK_50_B7A,
	CLOCK_50_B8A,

	//////////// LED //////////
	LEDG,
	LEDR,

	//////////// KEY //////////
	CPU_RESET_n,
	KEY,

	//////////// SW //////////
	SW,

	//////////// SEG7 //////////
	HEX0,
	HEX1,

	//////////// HDMI-TX //////////
	HDMI_TX_CLK,
	HDMI_TX_D,
	HDMI_TX_DE,
	HDMI_TX_HS,
	HDMI_TX_INT,
	HDMI_TX_VS,

	//////////// ADC SPI //////////
	ADC_CONVST,
	ADC_SCK,
	ADC_SDI,
	ADC_SDO,

	//////////// Audio //////////
	AUD_ADCDAT,
	AUD_ADCLRCK,
	AUD_BCLK,
	AUD_DACDAT,
	AUD_DACLRCK,
	AUD_XCK,

	//////////// I2C for Audio/HDMI-TX/Si5338/HSMC //////////
	I2C_SCL,
	I2C_SDA,

	//////////// SDCARD //////////
	SD_CLK,
	SD_CMD,
	SD_DAT,

	//////////// Uart to USB //////////
	UART_RX,
	UART_TX,

	//////////// SRAM //////////
	SRAM_A,
	SRAM_CE_n,
	SRAM_D,
	SRAM_LB_n,
	SRAM_OE_n,
	SRAM_UB_n,
	SRAM_WE_n,

	//////////// GPIO, GPIO connect to GPIO Default //////////
	GPIO,

	//////////// HSMC, HSMC connect to HSMC Default //////////
	HSMC_CLKIN_N,
	HSMC_CLKIN_P,
	HSMC_CLKIN0,
	HSMC_CLKOUT_N,
	HSMC_CLKOUT_P,
	HSMC_CLKOUT0,
	HSMC_D,
	HSMC_GXB_RX_P,
	HSMC_GXB_TX_P,
	HSMC_RX_N,
	HSMC_RX_P,
	HSMC_TX_N,
	HSMC_TX_P 
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input 		          		CLOCK_125_p;
input 		          		CLOCK_50_B5B;
input 		          		CLOCK_50_B6A;
input 		          		CLOCK_50_B7A;
input 		          		CLOCK_50_B8A;

//////////// LED //////////
output		     [7:0]		LEDG;
output		     [9:0]		LEDR;

//////////// KEY //////////
input 		          		CPU_RESET_n;
input 		     [3:0]		KEY;

//////////// SW //////////
input 		     [9:0]		SW;

//////////// SEG7 //////////
output		     [6:0]		HEX0;
output		     [6:0]		HEX1;

//////////// HDMI-TX //////////
output		          		HDMI_TX_CLK;
output		    [23:0]		HDMI_TX_D;
output		          		HDMI_TX_DE;
output		          		HDMI_TX_HS;
input 		          		HDMI_TX_INT;
output		          		HDMI_TX_VS;

//////////// ADC SPI //////////
output		          		ADC_CONVST;
output		          		ADC_SCK;
output		          		ADC_SDI;
input 		          		ADC_SDO;

//////////// Audio //////////
input 		          		AUD_ADCDAT;
inout 		          		AUD_ADCLRCK;
inout 		          		AUD_BCLK;
output		          		AUD_DACDAT;
inout 		          		AUD_DACLRCK;
output		          		AUD_XCK;

//////////// I2C for Audio/HDMI-TX/Si5338/HSMC //////////
output		          		I2C_SCL;
inout 		          		I2C_SDA;

//////////// SDCARD //////////
output		          		SD_CLK;
inout 		          		SD_CMD;
inout 		     [3:0]		SD_DAT;

//////////// Uart to USB //////////
input 		          		UART_RX;
output		          		UART_TX;

//////////// SRAM //////////
output		    [17:0]		SRAM_A;
output		          		SRAM_CE_n;
inout 		    [15:0]		SRAM_D;
output		          		SRAM_LB_n;
output		          		SRAM_OE_n;
output		          		SRAM_UB_n;
output		          		SRAM_WE_n;

//////////// GPIO, GPIO connect to GPIO Default //////////
inout 		    [35:0]		GPIO;

//////////// HSMC, HSMC connect to HSMC Default //////////
input 		     [2:1]		HSMC_CLKIN_N;
input 		     [2:1]		HSMC_CLKIN_P;
input 		          		HSMC_CLKIN0;
output		     [2:1]		HSMC_CLKOUT_N;
output		     [2:1]		HSMC_CLKOUT_P;
output		          		HSMC_CLKOUT0;
inout 		     [3:0]		HSMC_D;
input 		     [3:0]		HSMC_GXB_RX_P;
output		     [3:0]		HSMC_GXB_TX_P;
inout 		    [16:0]		HSMC_RX_N;
inout 		    [16:0]		HSMC_RX_P;
inout 		    [16:0]		HSMC_TX_N;
inout 		    [16:0]		HSMC_TX_P;


//=======================================================
//  REG/WIRE declarations
//=======================================================




//=======================================================
//  Structural coding
//=======================================================



endmodule
