// ============================================================================
// Copyright (c) 2012 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//
// Major Functions:	DE2 TOP LEVEL
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Chen       :| 05/08/19  :|      Initial Revision
//   V1.1 :| Johnny Chen       :| 05/11/16  :|      Added FLASH Address FL_ADDR[21:20]
//   V1.2 :| Johnny Chen       :| 05/11/16  :|		Fixed ISP1362 INT/DREQ Pin Direction.   
//   V1.3 :| Johnny Chen       :| 06/11/16  :|		Added the Dedicated TV Decoder Line-Locked-Clock Input
//													            for DE2 v2.X PCB.
//   V1.5 :| Eko    Yan        :| 12/01/30  :|      Update to version 11.1 sp1.
// ============================================================================

module ARM
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		//UART_TXD,						//	UART Transmitter
		//UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		//IRDA_TXD,						//	IRDA Transmitter
		//IRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask 
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 0
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask 
		SRAM_LB_N,						//	SRAM Low-byte Data Mask 
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_DATA,						//	ISP1362 Data bus 16 Bits
		OTG_ADDR,						//	ISP1362 Address 2 Bits
		OTG_CS_N,						//	ISP1362 Chip Select
		OTG_RD_N,						//	ISP1362 Write
		OTG_WR_N,						//	ISP1362 Read
		OTG_RST_N,						//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		OTG_INT0,						//	ISP1362 Interrupt 0
		OTG_INT1,						//	ISP1362 Interrupt 1
		OTG_DREQ0,						//	ISP1362 DMA Request 0
		OTG_DREQ1,						//	ISP1362 DMA Request 1
		OTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		OTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		//SD_DAT,							//	SD Card Data
		//SD_WP_N,						   //	SD Write protect 
		//SD_CMD,							//	SD Card Command Signal
		//SD_CLK,							//	SD Card Clock
		////////////////////	USB JTAG link	////////////////////
		TDI,  							// CPLD -> FPGA (data in)
		TCK,  							// CPLD -> FPGA (clk)
		TCS,  							// CPLD -> FPGA (CS)
	   TDO,  							// FPGA -> CPLD (data out)
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_DAT,						//	PS2 Data
		PS2_CLK,						//	PS2 Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_DATA,						//	DM9000A DATA bus 16Bits
		ENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		ENET_CS_N,						//	DM9000A Chip Select
		ENET_WR_N,						//	DM9000A Write
		ENET_RD_N,						//	DM9000A Read
		ENET_RST_N,						//	DM9000A Reset
		ENET_INT,						//	DM9000A Interrupt
		ENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,						//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		AUD_DACDAT,						//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		AUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		TD_DATA,    					//	TV Decoder Data bus 8 bits
		TD_HS,							//	TV Decoder H_SYNC
		TD_VS,							//	TV Decoder V_SYNC
		TD_RESET,						//	TV Decoder Reset
		TD_CLK27,                  //	TV Decoder 27MHz CLK
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0
		GPIO_1							//	GPIO Connection 1
	);

////////////////////////	Clock Input	 	////////////////////////
input		   	CLOCK_27;				//	27 MHz
input		   	CLOCK_50;				//	50 MHz
input			   EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	   [3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	  [17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output  [17:0]	LEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
//output			UART_TXD;				//	UART Transmitter
//input			   UART_RXD;				//	UART Receiver
////////////////////////////	IRDA	////////////////////////////
//output			IRDA_TXD;				//	IRDA Transmitter
//input			   IRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	  [15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output  [11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask 
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 0
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	  [7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
output [21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	 [15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
output [17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
output			SRAM_UB_N;				//	SRAM High-byte Data Mask 
output			SRAM_LB_N;				//	SRAM Low-byte Data Mask 
output			SRAM_WE_N;				//	SRAM Write Enable
output			SRAM_CE_N;				//	SRAM Chip Enable
output			SRAM_OE_N;				//	SRAM Output Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	 [15:0]	OTG_DATA;				//	ISP1362 Data bus 16 Bits
output  [1:0]	OTG_ADDR;				//	ISP1362 Address 2 Bits
output			OTG_CS_N;				//	ISP1362 Chip Select
output			OTG_RD_N;				//	ISP1362 Write
output			OTG_WR_N;				//	ISP1362 Read
output			OTG_RST_N;				//	ISP1362 Reset
output			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
output			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			   OTG_INT0;				//	ISP1362 Interrupt 0
input			   OTG_INT1;				//	ISP1362 Interrupt 1
input			   OTG_DREQ0;				//	ISP1362 DMA Request 0
input			   OTG_DREQ1;				//	ISP1362 DMA Request 1
output			OTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			OTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	  [7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
//inout	 [3:0]	SD_DAT;					//	SD Card Data
//input			   SD_WP_N;				   //	SD write protect
//inout			   SD_CMD;					//	SD Card Command Signal
//output			SD_CLK;					//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			   I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
input		 	   PS2_DAT;				//	PS2 Data
input			   PS2_CLK;				//	PS2 Clock
////////////////////	USB JTAG link	////////////////////////////
input  			TDI;					// CPLD -> FPGA (data in)
input  			TCK;					// CPLD -> FPGA (clk)
input  			TCS;					// CPLD -> FPGA (CS)
output 			TDO;					// FPGA -> CPLD (data out)
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_DATA;				//	DM9000A DATA bus 16Bits
output			ENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			ENET_CS_N;				//	DM9000A Chip Select
output			ENET_WR_N;				//	DM9000A Write
output			ENET_RD_N;				//	DM9000A Read
output			ENET_RST_N;				//	DM9000A Reset
input			   ENET_INT;				//	DM9000A Interrupt
output			ENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			   AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			   AUD_ADCDAT;				//	Audio CODEC ADC Data
inout			   AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			AUD_DACDAT;				//	Audio CODEC DAC Data
inout			   AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			AUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input	 [7:0]	TD_DATA;    			//	TV Decoder Data bus 8 bits
input			   TD_HS;					//	TV Decoder H_SYNC
input			   TD_VS;					//	TV Decoder V_SYNC
output			TD_RESET;				//	TV Decoder Reset
input          TD_CLK27;            //	TV Decoder 27MHz CLK
////////////////////////	GPIO	////////////////////////////////
inout	[35:0]	GPIO_0;					//	GPIO Connection 0
inout	[35:0]	GPIO_1;					//	GPIO Connection 1

wire [32-1 :0] inst, PC;
wire [32-1 :0] inst_reg, PC_reg;
wire cache_hit;
wire flush, hazard, freeze, sram_freeze, sram_ready;
wire WB_EN_reg_2_mux;
/////////////////////ID
wire WB_EN, MEM_R_EN, MEM_W_EN,B,S;
wire [3:0] EXE_CMD;
wire [31:0] Val_Rn, Val_Rm;
wire imm;
wire [11:0] Shift_operand;
wire [23:0] Signed_imm_24;
wire [3:0] Dest;
wire [3:0] src1, src2;
wire Two_src;
//////////////////////IDREG
wire WB_EN_reg, MEM_R_EN_reg, MEM_W_EN_reg,B_reg,S_reg;
wire [31:0] PC_reg_2;
wire [3:0] EXE_CMD_reg;
wire [31:0] Val_Rn_reg, Val_Rm_reg;
wire imm_reg;
wire [11:0] Shift_operand_reg;
wire [23:0] Signed_imm_24_reg;
wire [3:0] Dest_reg;
wire C_ID_out;
wire [3:0] src1_reg, src2_reg;
///////////////////// 	EXE
wire [31:0] ALU_result, Br_addr, Val_Rm_EXE;
wire [3:0] status;
wire EXE_MEM_R;
/////////////////////  EXE_REG
wire WB_EN_reg_2, MEM_R_EN_reg_2, MEM_W_EN_reg_2;
wire [31:0] ALU_result_reg, Val_RM_reg2;
wire [3:0] Dest_reg_2,  ST_val_reg;
///////////////////// MEM
wire [31:0] MEM_out;
/////////////////////////////MEM REG
wire WB_en_MEMREG, MEM_R_en_MEMREG;
wire [31 : 0] ALU_result_MEMREG, Mem_read_value_MEMREG;
wire [3 : 0] Dest_MEMREG;
/////////////////////////////WRITE BACK
wire [31:0] WB_VALUE;
////////////////////////////FW
wire [1:0] sel_src1, sel_src2;
/////////////////////////////////CACHE
wire [63:0] sram_rdata;
wire cacheReady;
////////////////////////////////
assign flush = B_reg;
assign hazard = freeze;
////////////////////////////


IF #(32) IF1(CLOCK_50, SW[0],flush,freeze|sram_freeze,Br_addr, inst, PC);
IFReg IFR(
     CLOCK_50, SW[0], freeze|sram_freeze, flush,
PC, inst,
    PC_reg, inst_reg
);
ID ID1(
     .clk(CLOCK_50), .rst(SW[0]), 
     .Instruction(inst_reg),
    .Result_WB(WB_VALUE),
    .writeBackEn(WB_en_MEMREG),
    .Dest_wb(Dest_MEMREG),
    .hazard(hazard),
    .SR(status),
	.freeze(freeze|sram_freeze),

    .WB_EN(WB_EN), .MEM_R_EN(MEM_R_EN), .MEM_W_EN(MEM_W_EN),.B(B),.S(S),
    .EXE_CMD(EXE_CMD),
    .Val_Rn(Val_Rn), .Val_Rm(Val_Rm),
    .imm(imm),
    .Shift_operand(Shift_operand),
    .Signed_imm_24(Signed_imm_24),
    .Dest(Dest),
    .src1(src1), .src2(src2),
    .Two_src(Two_src));

ID_STAGE_REG IDR(
    .clk(CLOCK_50), .rst(SW[0]), .flush(flush),.freeze(sram_freeze),
    .WB_EN_IN(WB_EN), .MEM_R_EN_IN(MEM_R_EN), .MEM_W_EN_IN(MEM_W_EN),.B_IN(B),.S_IN(S),
    .PC_IN(PC_reg),
    .EXE_CMD_IN(EXE_CMD),
    .Val_Rn_IN(Val_Rn), .Val_Rm_IN(Val_Rm),
    .imm_IN(imm),
    .Shift_operand_IN(Shift_operand),
    .Signed_imm_24_IN(Signed_imm_24),
    .Dest_IN(Dest),
	.C_ID_in(status[1]),
	.src1(src1), .src2(src2),


    .WB_EN(WB_EN_reg), .MEM_R_EN(MEM_R_EN_reg), .MEM_W_EN(MEM_W_EN_reg),.B(B_reg),.S(S_reg),
    .PC(PC_reg_2),
    .EXE_CMD(EXE_CMD_reg),
    .Val_Rn(Val_Rn_reg), .Val_Rm(Val_Rm_reg),
    .imm(imm_reg),
    .Shift_operand(Shift_operand_reg),
    .Signed_imm_24(Signed_imm_24_reg),
    .Dest(Dest_reg),
	.C_ID_out(C_ID_out),
	.src1_out(src1_reg), .src2_out(src2_reg)
  );


EXE EX1(
    .clk(CLOCK_50),
    .EXE_CMD(EXE_CMD_reg),
    .MEM_R_EN(MEM_R_EN_reg), .MEM_W_EN(MEM_W_EN_reg),
    .PC(PC_reg_2),
    .Val_Rn(Val_Rn_reg), .Val_Rm(Val_Rm_reg),
    .imm(imm_reg),
    .Shift_operand(Shift_operand_reg),
    .Signed_imm_24(Signed_imm_24_reg),
	.C_in(C_ID_out),
    .S_ID(S_reg),
	.sel_src1(sel_src1),
	.sel_src2(sel_src2),
	.Val_in_MEM(ALU_result_reg),
	.Val_in_WB(WB_VALUE),
    
    .ALU_result(ALU_result), .Br_addr(Br_addr),
    .status(status),
	.Val_Rm_Out(Val_Rm_EXE)
    );

EXE_STAGE_REG EXE_REG(
    .clk(CLOCK_50),.rst(SW[0]),
    .WB_EN_in(WB_EN_reg), .MEM_R_EN_in(MEM_R_EN_reg), .MEM_W_EN_in(MEM_W_EN_reg), 
    .ALU_result_in(ALU_result), .ST_val_in(status),
    .Dest_in(Dest_reg),.Val_RM_in(Val_Rm_EXE),.flush(flush),.freeze(sram_freeze),

    .WB_EN(WB_EN_reg_2), .MEM_R_EN(MEM_R_EN_reg_2), .MEM_W_EN(MEM_W_EN_reg_2),
    .ALU_result(ALU_result_reg), .ST_val(ST_val_reg), .Val_RM(Val_RM_reg2),
    .Dest(Dest_reg_2)
);

CacheController CC1(
	.clk(CLOCK_50), .rst(SW[0]),
    .address(ALU_result_reg),
    .wdata(Val_RM_reg2),
    .MEM_R_EN(MEM_R_EN_reg_2),
    .MEM_W_EN(MEM_W_EN_reg_2),
    .rdata(MEM_out),
    .ready(cacheReady),

    .sram_address(),
    .sram_wdata(),
    .hit(cache_hit),
    .sram_rdata(sram_rdata),
    .sram_ready(sram_ready)
    );
Sram_Controller SC1(
     .clk(CLOCK_50),
     .rst(SW[0]),
     .wr_en(MEM_W_EN_reg_2),
     .rd_en(MEM_R_EN_reg_2),
     .address(ALU_result_reg),
     .writeData(Val_RM_reg2),
    
     .readData(sram_rdata),

     .ready(sram_ready),
	 .cache_hit(cache_hit),
	.SRAM_DQ(SRAM_DQ),
	.SRAM_ADDR(SRAM_ADDR),
	.SRAM_UB_N(SRAM_UB_N),
	.SRAM_LB_N(SRAM_LB_N),
	.SRAM_WE_N(SRAM_WE_N),
	.SRAM_CE_N(SRAM_CE_N),
	.SRAM_OE_N(SRAM_OE_N)
);
	assign sram_freeze = ~cacheReady;
// Memory MEM_STAGE(
//     .clk(CLOCK_50), .MEMread(MEM_R_EN_reg_2), .MEMwrite(MEM_W_EN_reg_2),
//     .address(ALU_result_reg), .data(Val_RM_reg2), 
//     .MEM_result(MEM_out)
// );
assign WB_EN_reg_2_mux = (sram_freeze) ? 1'b0 : WB_EN_reg_2;

MemReg MEM_REG(
    .clk(CLOCK_50), .rst(SW[0]), .WB_en_in(WB_EN_reg_2_mux), .MEM_R_en_in(MEM_R_EN_reg_2), 
    .ALU_result_in(ALU_result_reg), .Mem_read_value_in(MEM_out),
    .Dest_in(Dest_reg_2), .freeze(sram_freeze),

    .WB_en(WB_en_MEMREG), .MEM_R_en(MEM_R_en_MEMREG), 
    .ALU_result(ALU_result_MEMREG), .Mem_read_value(Mem_read_value_MEMREG),
    .Dest(Dest_MEMREG)
);

WB_stage WB1(.MEM_result(Mem_read_value_MEMREG), .ALU_result(ALU_result_MEMREG), 
.MEM_R_en(MEM_R_en_MEMREG),.out(WB_VALUE));

hazard_detection_unit HDU(
	.FW_en(SW[3]),
    .src1(src2),
    .src2(src1),
    .Exe_Dest(Dest_reg),
    .Exe_WB_En(WB_EN_reg),
    .Mem_Dest(Dest_reg_2),
    .Mem_WB_En(WB_EN_reg_2),
    .Two_Src(Two_src),
    .hazard_Detected(freeze),
	.EXE_MEM_R(MEM_R_EN_reg)
);

FW FWUnit(
	.src1(src1_reg), .src2(src2_reg), .Dest_WB(Dest_MEMREG), .Dest_MEM(Dest_reg_2),
    .WB_EN_WB(WB_en_MEMREG), .WB_EN_MEM(WB_EN_reg_2),
    .FW_en(SW[3]),
    .sel_src1(sel_src1), .sel_src2(sel_src2)
    );


endmodule
