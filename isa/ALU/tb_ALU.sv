module tb_ALU();
	logic [3:0] A, B;
	logic [3:0] ALUControl;
	logic [3:0] flags;
	logic [3:0] RESULT;
	ALU_N_bits#(4) dut(A, B,ALUControl,flags,RESULT);
	
	initial 
		begin  
			A <= 0;
			B <= 0;
			ALUControl <= 0;
			# 10;
		end
	always
		begin
			A <= 4'b0011;
			B <= 4'b1010;
			ALUControl <= 4'b0000; //ADD
			# 10;
			A <= 4'b1011;
			B <= 4'b1010;
			ALUControl <= 4'b0000; //ADD with OF
			# 10;
			A <= 4'b1010;
			B <= 4'b0011;
			ALUControl <= 4'b0001; // SUB
			# 10;
			A <= 4'b0011;
			B <= 4'b1010;
			ALUControl <= 4'b0001; // SUB with C
			# 10;
			A <= 4'b0011;
			B <= 4'b1010;
			ALUControl <= 4'b0010; //AND
			# 10;
			A <= 4'b0011;
			B <= 4'b1010;
			ALUControl <= 4'b0011; //OR
			# 10;
			A <= 4'b0011;
			B <= 4'b1010;
			ALUControl <= 4'b0100; //XOR
			# 10;
			A <= 4'b0011;
			B <= 4'b1010;
			ALUControl <= 4'b0101; //NOT
			# 10;
			A <= 4'b0011;
			B <= 4'b0001;;
			ALUControl <= 4'b0110; //LSA
			# 10;
			A <= 4'b0011;
			B <= 4'b0001;
			ALUControl <= 4'b0111; //RSA
			# 10;			
			A <= 4'b0011;
			B <= 4'b0001;
			ALUControl <= 4'b1000; //LSL
			# 10;
			A <= 4'b0011;
			B <= 4'b0001;
			ALUControl <= 4'b1001; //RSL
			# 10;			
			A <= 4'b0011;
			B <= 4'b0001;
			ALUControl <= 4'b1010; //MOV
			# 10;
		end

endmodule

