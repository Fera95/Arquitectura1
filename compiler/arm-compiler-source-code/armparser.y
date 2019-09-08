%{

#include <stdio.h>
#include <iostream>
#include <string.h>
#include <bitset>
#include <vector>
#include <map>
#include <stdlib.h>
#include <algorithm>
#include <cstdlib>
#include <fstream>

std::string DEFAULT_INSTRUCTION = "00000000000000000000000000000000";
std::string current_instruction = "00000000000000000000000000000000";

std::map<int,std::string> instruction_list; //all found labels will be added here
std::map<std::string,int> tag_position; //all found labels will be added here
std::map<int,std::string> branch_calling; //All Labels which are call using b, bmi or beq will be added here
std::fstream fs;
std::string final_message="Compiler success";


/*Binary part of data instructions type. This part is called "cmd" part.*/

std::string OP_ADD  = "0000";
std::string OP_SUB  = "0001";
std::string OP_MOV  = "0010";
std::string OP_CMP  = "0011";


std::string OP_LDR  = "0100";
std::string OP_STR  = "0101";
std::string OP_BXX  = "1000";
std::string OP_BEQ  = "1001";


std::string OP_KRN  = "1100";
std::string OP_LKN  = "1101";
std::string OP_LDK  = "1110";
std::string OP_SHK  = "1111";

std::string RK_BLUR  = "0000";
std::string RK_SHRP  = "0001";
std::string RK_OSHP  = "0010";



int memCount=0;
int error_count = 0;
int yylex();
extern int yylineno;


int text_memory_initial_value=0x00000000;
int text_memory=0x00000000;

void yyerror(std::string S);
void printt(std::string s);


/*Helper functions*/
std::string RegisterToBinary(std::string r);
void addTag(std::string);
void addTagCalling(std::string);
void insertIntOnInstruction(int);
int  immToInt(std::string);


/*Setting instruction*/
void setOp(std::string);

/*Setting params*/
void setRK(std::string RK);
void setRs(std::string);
void setRd(std::string);
void setRx(std::string);

void setImmDecLdr(std::string);
void setImmDec(std::string);
void setImmHex(std::string);

void setInstructionI();


/*Related instruction operations*/
void resetInstruction();
void writeInstruction();
void verifyBranchCalls();
void setBranchReference(int current_pos, int target_pos);

typedef enum context{
READING_INSTRUCTION,
READING_TAG,
READING_OPERATION,
READING_OPERAND,
READING_COMMA,
READING_DOCUMENTATION,
READING_COLOR,
READING_IMMEDIATE,
READING_OPERAND_IMMEDIATE
} context;

context current_context;

%}

%union{ char* id; int num;char* first;}

//lex tokens

%token END 0 "end of file"
%token <id> addition subtra mv cmp branch brancheq endline memory_direction_tag 
%token <id> reg immedec immehex label commentary
%token <id> blur sharpen oversharpen krn lkn ldk shk ldr str lsqrtb rsqrtb
%token <num> number
%type  <id> data_params_sr2 branch_operation reg_operand
%start body




%%

body: {current_context=READING_INSTRUCTION; } line nextline;
nextline: '\n' body | END;

line:  
  jump_tag 
  {current_context=READING_OPERATION;} tag_instruction 
  {current_context=READING_DOCUMENTATION;} documentation
| error;

jump_tag: 
    {current_context=READING_TAG; } 
    memory_direction_tag {addTag($2);} 
  |  /*epsilon*/;

tag_instruction: 
    instruction {writeInstruction(); resetInstruction();text_memory+=0x4;} 
  | /*epsilon*/;
documentation: 
  commentary | /*epsilon*/;

instruction: 
  branch_operation label {addTagCalling($2);}
| data_operation data_params
| mov_operation mov_params
| cmp_operation mov_params
| kernel_operation
| memory_operation mem_params
;

/*Operations*/
branch_operation: 
    branch {setOp(OP_BXX);} 
  | brancheq {setOp(OP_BEQ);};
data_operation: 
    addition {setOp(OP_ADD);} 
  | subtra {setOp(OP_SUB);};
mov_operation: 
    mv {setOp(OP_MOV);};
cmp_operation: 
    cmp {setOp(OP_CMP);};
kernel_operation: 
    krn reg_operand {setOp(OP_KRN);setRd($2);} 
  | lkn {setOp(OP_LKN);} rkval
  | ldk {setOp(OP_LDK);} ldk_params
  | shk {setOp(OP_SHK);}
;

rkval:
  blur {setRK(RK_BLUR);}
  |sharpen {setRK(RK_SHRP);}
  |oversharpen {setRK(RK_OSHP);}
;

memory_operation: 
    ldr {setOp(OP_LDR);} 
  | str {setOp(OP_STR);};


/*Params*/ 

data_params: 
  reg_operand comma 
  reg_operand comma {setRd($1);setRs($3);current_context=READING_OPERAND_IMMEDIATE;} 
  data_params_sr2;

data_params_sr2: 
    {current_context=READING_IMMEDIATE;} 
    immediate {setInstructionI();} 
  | reg_operand {setRx($1);};

/*Mov parameters*/ 

mov_params:
  reg_operand comma {setRd($1);} mov_params_src2; 

mov_params_src2:
    reg_operand {setRs($1);};
  | {current_context=READING_IMMEDIATE;} immediate {setInstructionI();} 
  ; 

reg_operand: 
  {current_context=READING_OPERAND;} 
  reg {$$=yylval.id;};


mem_params:
  reg_operand {setRd($1);} comma  lsqrtb mem_src_dst rsqrtb; 
;

mem_src_dst:
  reg_operand comma reg_operand {setRs($1);setRx($3);}
;

ldk_params:
  reg_operand comma immedec {setRd($1);setImmDecLdr($3);}
;


comma: {current_context=READING_COMMA;} ',';
immediate: 
    immedec {setImmDec($1);}
;


%%

extern int yyparse();
extern FILE *yyin;
std::string ruta="";



int immToInt(std::string imm_dec){
  imm_dec.erase(0,1);
  int imm_int = atoi(imm_dec.c_str());
  return imm_int;
}


void setInstructionI(){ 
  current_instruction.replace(31,1,"1");

}
void setOp(std::string cmd){
  current_instruction.replace(0,4,cmd);
}


void setRK(std::string RK){
  current_instruction.replace( 4, 4,RK);
}



void setRd(std::string Register){
  current_instruction.replace( 4, 4,RegisterToBinary(Register));
}
void setRs(std::string Register){
  current_instruction.replace( 8, 4,RegisterToBinary(Register)); 
}
void setRx(std::string Register){
  current_instruction.replace(12, 4,RegisterToBinary(Register)); 
}

void resetInstruction(){ current_instruction = DEFAULT_INSTRUCTION;}

void writeInstruction(){ 
  instruction_list.insert(std::pair<int,std::string>(text_memory,current_instruction));
  //fs<<current_instruction<<'\n';
}


void insertIntOnInstruction(int imm_int){
  std::string imm_str = std::bitset<19>(imm_int).to_string();
  current_instruction.replace( 12, 19, imm_str);
}

void setImmDec(std::string imm_dec){
  imm_dec.erase(0,1);
  int imm_int = atoi(imm_dec.c_str());
  if (-32768 <= imm_int && imm_int <= 32767){
    short is_negative = imm_int < 0;
    imm_int = is_negative?-1*imm_int:imm_int;
    insertIntOnInstruction(imm_int);
    if(is_negative)current_instruction.replace( 12, 1, "1");
  }
  else {
    error_count++;
    printt("Error: Immediate value outbounds \"" + imm_dec + "\".");
  }
  
}


void setImmDecLdr(std::string imm_dec){
  imm_dec.erase(0,1);
  int imm_int = atoi(imm_dec.c_str());
  if (0 <= imm_int && imm_int <= 6){
    std::string imm_str = std::bitset<4>(imm_int).to_string();
    current_instruction.replace( 8, 4, imm_str);
  }
  else {
    error_count++;
    printt("Error: Immediate value outbounds \"" + imm_dec + "\".");
  }
  
}


std::string RegisterToBinary(std::string r){ 
  r.erase(0,1); return std::bitset<4>(atoi(r.c_str())).to_string();
}



void addTag(std::string tag_name){
  tag_name.erase(tag_name.size()-1,1);
  auto found  = tag_position.find(tag_name);
  if (found != tag_position.end()){
    error_count++;
    std::cout  << "Error at line " << yylineno << ": tag \"" << tag_name << "\" is actually defined at line " << tag_position[tag_name]/4+1 << std::endl;
  }
  else tag_position.insert(std::pair<std::string,int>(tag_name,text_memory));
}


void addTagCalling(std::string tag_calling_name){
  branch_calling.insert(std::pair<int,std::string>(text_memory,tag_calling_name));
}



void verifyBranchCalls(){
  std::string branch_reference = "";
  for (int mempos = text_memory_initial_value; mempos < text_memory; mempos+=4){
    current_instruction = instruction_list[mempos];
    auto found  = branch_calling.find(mempos);
    if (found != branch_calling.end()){
      branch_reference = branch_calling[mempos];
      auto found_reference  = tag_position.find(branch_reference);
      if (found_reference != tag_position.end()){
        if(mempos > 0xFFFFFFF || mempos <0){
          std::cout  << "Error at line " << mempos/4+1 << ": tag \"" << branch_reference << "\" jump out of bound of architecture" << std::endl;
          error_count++;
        }
        else setBranchReference(mempos,tag_position[branch_reference]);
      }
      else{
        std::cout  << "Error at line " << mempos/4+1 << ": tag \"" << branch_reference << "\" reference does not exist" << std::endl;
        error_count++;
      }
    }

    if(error_count==0){
      fs<<current_instruction<<'\n';
      //fs<<current_instruction.substr(0,8)<<'\n';
      //fs<<current_instruction.substr(8,8)<<'\n';
      //fs<<current_instruction.substr(16,8)<<'\n';
      //fs<<current_instruction.substr(24,8)<<'\n';
    }

  }
}

void setBranchReference(int current_pos, int target_pos){
  std::string branch_target = std::bitset<28>(target_pos).to_string();
  current_instruction.replace( 4, 28, branch_target);
}


void printt(std::string s){ std::cout << s << std::endl; }

void print_error(std::string S, std::string expected_value){ std::cout << S << ": Found \"" << yylval.id  << "\", but expected was \"" << expected_value << "\" at line " << yylineno << "." << std::endl;}


void yyerror(std::string S){
  error_count++;
  final_message="Compiler failed";
  if (current_context == READING_INSTRUCTION) print_error(S,"instruction or tag");
  else if (current_context == READING_TAG)print_error(S, "tag:");
  else if (current_context == READING_OPERATION)print_error(S, "operation as add or sub");
  else if (current_context == READING_OPERAND)print_error(S, "R0-R15");
  else if (current_context == READING_DOCUMENTATION)print_error(S, "Documentation");
  else if (current_context == READING_COMMA)print_error(S, ",");
  else if (current_context == READING_IMMEDIATE)print_error(S, "Decimal value from #-32768 to #32767 or Hexdecimal value from 0x0000 to 0xFFFF");
  else if (current_context == READING_COLOR)print_error(S, "@000-@111 or @BLACK, @BLUE, @GREEN, @CYAN, @RED, @MAGENTA, @YELLOW, @WHITE");
  else if (current_context == READING_OPERAND_IMMEDIATE)print_error(S, "R0-R15 or Immediate value");
  else print_error(S, "common error");
}




int main(int argc, char ** argv) {
  if (argc != 3){
    std::cout << "Debe ingresar el nombre del codigo fuente en ensamblador y luego el archivo de destino " << std::endl;
    std::cout << "Ejemplo: ./arm-compiler source.s dest.txt" << std::endl;
    return -1;
  }
  FILE *myfile = fopen(argv[1], "r");
	//se verifica si es valido
	if (!myfile) {
		std::cout << "No es posible abrir el archivo" << std::endl;
		return -1;
	}
	yyin = myfile;
	do {
		yyparse();
	} while (!feof(yyin));
  fs.open (argv[2], std::ios::out | std::ios::trunc);
  verifyBranchCalls();
  fs.close();
  if (error_count>0){
    remove(argv[2]);
    final_message="Compiler failed";
  }
  std::cout<<final_message<<'\n';
  for(int i=0;i<100;++i);
}
