// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
// CREATED		"Mon Feb 12 00:01:55 2024"

module read_data(
	Addr,
	LoadType,
	ReadData,
	ReadDataOut
);


input wire	[31:0] Addr;
input wire	[2:0] LoadType;
input wire	[31:0] ReadData;
output wire	[31:0] ReadDataOut;

wire	[7:0] ByteOut;
wire	[15:0] HalfOut;
wire	[31:0] sign_ext;
wire	[31:0] zero_ext;
wire	[31:0] SYNTHESIZED_WIRE_0;
wire	[31:0] SYNTHESIZED_WIRE_1;
wire	[31:0] SYNTHESIZED_WIRE_2;
wire	[31:0] SYNTHESIZED_WIRE_3;





mux4	b2v_ByteSelectMux(
	.d0(ReadData[7:0]),
	.d1(ReadData[15:8]),
	.d2(ReadData[23:16]),
	.d3(ReadData[31:24]),
	.sel(Addr[1:0]),
	.y(ByteOut));
	defparam	b2v_ByteSelectMux.WIDTH = 8;


mux2	b2v_HalfWordSelect(
	.sel(Addr[1]),
	.d0(ReadData[15:0]),
	.d1(ReadData[31:16]),
	.y(HalfOut));
	defparam	b2v_HalfWordSelect.WIDTH = 16;


mux2	b2v_ReadDataMux(
	.sel(LoadType[2]),
	.d0(SYNTHESIZED_WIRE_0),
	.d1(SYNTHESIZED_WIRE_1),
	.y(ReadDataOut));
	defparam	b2v_ReadDataMux.WIDTH = 32;


mux3	b2v_ReadDataMuxByte(
	.d0(ReadData),
	.d1(zero_ext),
	.d2(sign_ext),
	.sel(LoadType[1:0]),
	.y(SYNTHESIZED_WIRE_0));
	defparam	b2v_ReadDataMuxByte.WIDTH = 32;


mux2	b2v_ReadDataMuxHalf(
	.sel(LoadType[0]),
	.d0(SYNTHESIZED_WIRE_2),
	.d1(SYNTHESIZED_WIRE_3),
	.y(SYNTHESIZED_WIRE_1));
	defparam	b2v_ReadDataMuxHalf.WIDTH = 32;


sign_extend	b2v_SignExtend_Byte(
	.a(ByteOut),
	.SignExt(sign_ext));
	defparam	b2v_SignExtend_Byte.SIGNS = 24;
	defparam	b2v_SignExtend_Byte.WIDTH = 8;


sign_extend	b2v_SignExtend_Half(
	.a(HalfOut),
	.SignExt(SYNTHESIZED_WIRE_3));
	defparam	b2v_SignExtend_Half.SIGNS = 16;
	defparam	b2v_SignExtend_Half.WIDTH = 16;


zero_extend	b2v_ZeroExtend_Byte(
	.a(ByteOut),
	.ZeroExt(zero_ext));
	defparam	b2v_ZeroExtend_Byte.WIDTH = 8;
	defparam	b2v_ZeroExtend_Byte.ZEROS = 24;


zero_extend	b2v_ZeroExtend_Half(
	.a(HalfOut),
	.ZeroExt(SYNTHESIZED_WIRE_2));
	defparam	b2v_ZeroExtend_Half.WIDTH = 16;
	defparam	b2v_ZeroExtend_Half.ZEROS = 16;


endmodule
