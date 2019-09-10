module Top_unit_tb();
  
  /*
  
  SE DEBE CREAR UNA UNIDAD DE CONTROL
  
  
  ControlUnit (input logic clk, reset,
						  input logic [31:12] Instr,
						  input logic [3:0] ALUFlags,
						  output logic [1:0] RegSrc,
						  output logic RegWrite,
						  output logic [1:0] ImmSrc,
						  output logic ALUSrc,
						  output logic [1:0] ALUControl,
						  output logic MemWrite, //Escritura a memoria STR 0 -> NO STR 1 -> STR
              MemtoReg, //Escritura a reg desde mem 0 -> NO LDR 1 -> LDR
						  output logic PCSrc	
						  );*/
/*
Op Funct5 Funct0 Type Branch MemtoReg MemW ALUSrc ImmSrc RegW RegSrc ALUOp
00 		0 		X 	DP Reg 	0 		0 				0 		0 		XX 		1 		00 			1
00 		1 		X 	DP Imm 	0 		0 				0 		1 		00 		1		  X0 			1
01 		X 		0 		STR 	0 		X 				1 		1		  01 		0 		10		  0
01 		X 		1 		LDR 	0 		1 				0		  1 		01 		1 		X0		  0
10 		X 		X 		B 		1 		0 				0 		1 		10 		0 		X1 			0
ALUOp		Funct4:1(cmd)		Funct0(S) Type ALUControl1:0 FlagW1:0
0 					X 							X 	Not DP 		00 (Add) 			00
1 				0100 							0 		ADD 		00 (Add) 			00
														1 													11
1					0010 							0 		SUB 		01 (Sub) 			00
														1 													11
1					0000 							0 		AND 		10 (And) 			00
														1 													10
1					1100 							0 		ORR 		11 (Or) 			00
														1 													10 
PCSrc**: se~nal fuente de PC, saltos y escrituras a PC
0: caso no saltos (ni escrituras a PC)
1: caso salto (op = 10) o escritura a PC (rd = 15 y
RegWrite). Afectado por ejecucion condicional
*/
  //inputs
  logic clk,reset;
  logic [31:0] Instru; //Instrucción
  logic [3:0] ALUFlags;
  
  //Outputs
  logic [1:0]RegSrc;// controla si es 15 o R1 (bit 0) controla si es Instrc[3:0] o Instruc[15:12]
  logic RegWrite;
  logic [1:0] ImmSrc;
  logic ALUSrc;
  logic [1:0] ALUControl;
  logic MemWrite,MemtoReg;
  logic PCSrc;
  
    ControlUnit dut(
              clk,
              reset,
    			Instru[31:12],
              ALUFlags,
              RegSrc,
              RegWrite,
              ImmSrc,
              ALUSrc,
              ALUControl,
              MemWrite,MemtoReg,
              PCSrc	);
  
  initial begin
	//assign ALUFlags = 4'b0000;
     reset = 0; 
    #10
      reset = 1;
    #10
      reset = 0;
    //ADD R0, R0, #42
    //Instrucciones a probar
    
    //poner instruccion en HEXA y desplegarla , aquí se prueba que la
	 // unidad de control de las banderas deseadas
      Instru =32'b1110_000_0010_0_1111_0000_0000_0000_1111; #100;
    $display("Valindando: E04F000F");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b0) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b01) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");


    
    //E2802005
     Instru =32'b1110_001_0100_0_0000_0010_0000_0000_0101; #100;  
	 $display("Valindando: E2802005");
    
	assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
	assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
	assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
	assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
	assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
	assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
	assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
	assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
  
   //E280300C
	
    Instru =32'b1110_001_0100_0_0000_0011_0000_0000_1100; #100;
	$display("Valindando: E280300C");
	assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
   assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
   assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
   assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
   assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
   assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
   assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
   assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
    
  
      
  //E2437009
    Instru =32'b1110_001_0010_0_0011_0111_0000_0000_1001; #100;  
   $display("Valindando: E2437009");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b01) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
     
  //E1874002
    Instru =32'b1110_000_1100_0_0111_0100_0000_0000_0010; #100;  
    $display("Valindando: E1874002");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b0) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b11) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
     
  //E0035004
    Instru =32'b1110_000_0000_0_0011_01010000_0000_0100; #100;  
    $display("Valindando: E0035004");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b0) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b10) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");

  //E0855004
     Instru =32'b1110_000_0100_0_0101_0101_0000_0000_0100; #100;  
    $display("Valindando: E0855004");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b0) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
    
     //E0558007
	  Instru =32'b1110_000_0010_1_0101_1000_0000_0000_0111; #100;  
    $display("Valindando: E0558007");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b0) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b01) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
    
  //0A00000C
    Instru =32'b0000_1010_0000_0000_0000_0000_0000_1100; #100;  
   $display("Valindando: 0A00000C Posiblemente tenga errores");
    
    assert(RegSrc == 2'b01) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b0) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b10) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
  
  //E0538004
    Instru =32'b1110_000_0010_1_0011_1000_0000_0000_0100; #100;  
    $display("Valindando: E0538004");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b0) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b01) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");

  //AA000000
    Instru =32'b1010_1010_0000_0000_0000_0000_0000_0000; #100;  
    $display("Valindando: AA000000");
    
    assert(RegSrc == 2'b01) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b0) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b10) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b1) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
    
  //E2805000
    Instru =32'b1110_001_0100_0_0000_0101_0000_0000_0000; #100;  
     $display("Valindando: E2805000");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
    
  //E0578002
    Instru =32'b1110_000_0010_1_0111_1000_0000_0000_0010; #100;  
    $display("Valindando: E0578002");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b0) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b01) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");    
   
  //B2857001
		
//	 Instru =32'b0000_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
//	 Instru =32'b0001_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
//	 Instru =32'b0010_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
//	 Instru =32'b0011_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
//	 Instru =32'b0100_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
//	 Instru =32'b0101_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
//	 Instru =32'b0110_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
//	 Instru =32'b0111_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
//	 Instru =32'b1000_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
//	 Instru =32'b1001_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
//	 Instru =32'b1010_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
	 Instru =32'b1011_001_0100_0_0101_0111_0000_0000_0001;
	 ALUFlags = 4'b1000;
	 		#100
//	 Instru =32'b1100_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
//	 Instru =32'b1101_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
//	 Instru =32'b1110_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 		#10
//	 Instru =32'b1111_001_0100_0_0101_0111_0000_0000_0001;
//	 ALUFlags = 4'b1000;
//	 #10
//	 ALUFlags = 4'b0000;
//		#10;
//	 ALUFlags = 4'b0001;
//		#10;
//	 ALUFlags = 4'b0010;
//		#10;
//	 ALUFlags = 4'b0011;
//		#10;
//	 ALUFlags = 4'b0100;
//		#10;
//	 ALUFlags = 4'b0101;
//		#10;
//	 ALUFlags = 4'b0110;
//		#10;
//	 ALUFlags = 4'b0111;
//		#10;
//	 ALUFlags = 4'b1000;
//		#10;
//	 ALUFlags = 4'b1001;
//		#10;
//	 ALUFlags = 4'b1010;
//		#10;
//	 ALUFlags = 4'b1011;
//		#10;
//	 ALUFlags = 4'b1100;
//		#10;
//	 ALUFlags = 4'b1101;
//		#10;
//	 ALUFlags = 4'b1110;
//		#10;
//	 ALUFlags = 4'b1111;
//		#10;

    $display("Valindando: B2857001");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
    
  //E0477002
    Instru =32'b1110_000_0010_0_0111_0111_0000_0000_0010;
    ALUFlags = 4'b0000;	#100;  
   $display("Valindando: E0477002");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b0) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b01) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
    
  //E5837054
    Instru =32'b1110_010_1100_0_0011_0111_0000_0101_0100; #100; 
$display("Valindando: E5837054");
    
    assert(RegSrc == 2'b10) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b0) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b01) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b1) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b1) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");	
   
    
  //E5902060
    Instru =32'b1110_010_1100_1_0000_0010_0000_0110_0000; #100;  
    $display("Valindando: E5902060");
    
       
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b01) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b1) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
    
      //E08FF000
    Instru =32'b1110_000_0100_0_1111_1111_0000_0000_0000; #100;  
       $display("Valindando: E08FF000");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b0) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b1) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
    
  //E280200E
    Instru =32'b1110_001_0100_0_0000_0010_0000_0000_0001; #100;  
       $display("Valindando: E280200E");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
    
  //EA000001
    Instru =32'b1110_1010_0000_0000_0000_0000_0000_0001; #100;  
       $display("Valindando: EA000001");
    
    assert(RegSrc == 2'b01) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b0) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b10) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b1) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
    
    
  //E280200D
    Instru =32'b1110_001_0100_0_0000_0010_0000_0000_0001; #100;  
	  $display("Valindando: E280200D");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
   
    
  //E280200A
    Instru =32'b1110_001_0100_0_0000_0010_0000_0000_0001; #100;  
    $display("Valindando: E280200A");
    
    assert(RegSrc == 2'b00) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b1) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b00) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b0) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b0) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
    
  //E5802064
    Instru =32'b1110_010_1100_0_0000_0010_0000_0101_0100; #100;  
     $display("Valindando: E5802064");
    
    assert(RegSrc == 2'b10) $display("	Instruction/RegSrc"); else $error("	ERROR Instruction/RegSrc");
    assert(RegWrite == 1'b0) $display("	Instruction/RegWrite"); else $error("	ERROR Instruction/RegWrite");
    assert(ImmSrc == 2'b01) $display("	Instruction/ImmSrc"); else $error("	ERROR Instruction/ImmSrc");
    assert(ALUSrc == 1'b1) $display("	Instruction/ALUSrc"); else $error("	ERROR Instruction/ALUSrc");
    assert(ALUControl == 2'b00) $display("	Instruction/ALUControl"); else $error("	ERROR Instruction/ALUControl");
    assert(MemWrite == 1'b1) $display("	Instruction/MemWrite"); else $error("	ERROR Instruction/MemWrite");
    assert(MemtoReg == 1'b1) $display("	Instruction/MemtoReg"); else $error("	ERROR Instruction/MemtoReg");
    assert(PCSrc == 1'b0) $display("	Instruction/PCSrc"); else $error("	ERROR Instruction/PCSrc");
	 
	
	// 
    
  end
  
  
  

  
  
endmodule