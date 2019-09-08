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
std::string OP_MOV  = "0000";
std::string OP_SUB  = "0001";

std::string OP_BMI  = "0010";
std::string OP_EOR  = "0011";
std::string OP_ADD  = "0100";

std::string OP_BXX  = "0101";
std::string OP_BEQ  = "0110";
std::string OP_PLOT = "0111";
std::string OP_COL  = "1000";
std::string OP_PLOTI= "1001";

std::string bin_debug = " ";
int dbg = 1;
int index_debug = 0;


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
void buildPlotInstruction(int,int);

void bresenham(int x0, int y0, int x1, int y1);
void drawRect(int x, int y, int w, int h);
void fillRect(int x, int y, int w, int h);



/*Setting instruction*/
void setOp(std::string);

/*Setting params*/
void setRn(std::string);
void setRd(std::string);
void setRs(std::string);
void setImmDec(std::string);
void setImmHex(std::string);
void setInstructionI();
void setImmHexPlot(std::string,bool);
void setImmDecPlot(std::string,bool);

void setColor(std::string);

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
%token <id> addition subtra mv plot branch brancheq branchmi col eor endline memory_direction_tag reg immedec immehex label commentary
%token <id> black blue green cyan red magenta yellow white immehexplot drawline immehex_plot drawrect fillrect
%token <num> number
%type  <id> data_params_sr2 branch_operation reg_operand immediate_plot_x immediate_plot_y routine_immediate
%start body

%%

body: {current_context=READING_INSTRUCTION; index_debug = 0; } line nextline;
nextline: '\n' body | END;

line:  
  jump_tag 
  {current_context=READING_OPERATION;} tag_instruction 
  {current_context=READING_DOCUMENTATION;} documentation
| error
  ;
jump_tag: {current_context=READING_TAG; } memory_direction_tag {addTag($2);} |  /*epsilon*/;
tag_instruction: 
  instruction {writeInstruction(); resetInstruction();text_memory+=0x4;} 
| routine
| /*epsilon*/;
documentation: commentary | /*epsilon*/;

instruction: 
  branch_operation label {addTagCalling($2);}
| data_operation data_params
| col_operation col_params
| plot_operation plot_params
| mov_operation mov_params
| eor_operation eor_params
;

/*Operations*/
branch_operation: branch {setOp(OP_BXX);} | brancheq {setOp(OP_BEQ);} | branchmi {setOp(OP_BMI);};
data_operation: addition {setOp(OP_ADD);} | subtra {setOp(OP_SUB);};
col_operation: col {setOp(OP_COL);};
mov_operation: mv {setOp(OP_MOV);};
plot_operation: plot {setOp(OP_PLOT);};
eor_operation: eor {setOp(OP_EOR);};

/*Params*/

data_params: reg_operand comma reg_operand comma {setRd($1);setRn($3);current_context=READING_OPERAND_IMMEDIATE;} data_params_sr2;
col_params:  {current_context=READING_COLOR;} color;
mov_params:  reg_operand comma reg_operand {setRd($1);setRn($3);};
plot_params:  
  reg_operand comma reg_operand {setRd($1);setRn($3);}
| {current_context=READING_IMMEDIATE;} immediate_plot_x comma {current_context=READING_IMMEDIATE;} immediate_plot_y {setOp(OP_PLOTI);}
;
eor_params: reg_operand comma reg_operand comma reg_operand {setRd($1);setRn($3);setRs($5);};
data_params_sr2: {current_context=READING_IMMEDIATE;} immediate {setInstructionI();} | reg_operand {setRs($1);};


immediate_plot_x: immehex_plot {setImmHexPlot($1,false);$$=$1;} | immedec {setImmDecPlot($1,false);$$=$1;};
immediate_plot_y: immehex_plot {setImmHexPlot($1,true);$$=$1;}  | immedec {setImmDecPlot($1,true);$$=$1;};

reg_operand: {current_context=READING_OPERAND;} reg {$$=yylval.id;};

comma: {current_context=READING_COMMA;} ',';

immediate: immedec {setImmDec($1);} | immehex {setImmHex($1);};

color:
  black {setColor("000");}
| blue {setColor("001");}
| green {setColor("010");}
| cyan {setColor("011");}
| red {setColor("100");}
| magenta {setColor("101");}
| yellow {setColor("110");}
| white {setColor("111");}
;

/*Routines*/

routine:
  drawline draw_line_params
|  drawrect draw_rect_params
|  fillrect fill_rect_params
;

draw_line_params:
  routine_immediate comma routine_immediate comma routine_immediate comma routine_immediate
  {bresenham(immToInt($1),immToInt($3),immToInt($5), immToInt($7));}
;

draw_rect_params:
  routine_immediate comma routine_immediate comma routine_immediate comma routine_immediate
  {drawRect(immToInt($1),immToInt($3),immToInt($5), immToInt($7));}
;

fill_rect_params:
  routine_immediate comma routine_immediate comma routine_immediate comma routine_immediate
  {fillRect(immToInt($1),immToInt($3),immToInt($5), immToInt($7));}
;

routine_immediate:
  {current_context=READING_IMMEDIATE;} immedec {$$=$2;}
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


void drawRect(int x, int y, int w, int h){
  for (int i = x; i < x+w;i++){
    buildPlotInstruction(i,y);
    index_debug = 0;
    buildPlotInstruction(i,y+h);
    index_debug = 0;
  }
  for (int i = y; i < y+h;i++){
    buildPlotInstruction(x,i);
    index_debug = 0;
    buildPlotInstruction(x+w,i);
    index_debug = 0;
  }

}
void fillRect(int x, int y, int w, int h){
  for (int i = x; i < x+w;i++){
    for (int j = y; j < y+h;j++){
      buildPlotInstruction(i,j);
      index_debug = 0;
    }
  }
}



void bresenham(int x1,int y1, int x2, int y2){

    int x = x1;
    int y = y1;

    int dx = x2 - x1;
    int sx = 1;
    if (dx < 0)
    {
        sx = -1;
        dx = x1-x2;
    }
    int dy = y2 - y1;
    int sy = 1;
    if (dy < 0)
    {
        sy = -1;
        dy = y1-y2;
    }

    int swap = 0;

    if(dy>dx){
        swap = dx;
        dx = dy;
        dy = swap;
        swap = 1;
    }

    int e = 2*dy-dx;
    int a = 2*dy;
    int b = 2*dy-2*dx;

    //printf("%d , %d\n", x, y);
    buildPlotInstruction(x,y);
    index_debug = 0;
    int i = 1;

    while(i <= dx){
        if (e<0){
            if(swap){
                y = y+sy;
            }else{
                x=x+sx;
            }
            e = e+a;
        }else{
            y = y+sy;
            x = x+sx;
            e = e+b;
        }
        buildPlotInstruction(x,y);
        index_debug = 0;
        i+=1;
    }

}


void buildPlotInstruction(int x, int y){
  setOp(OP_PLOTI);
  
  setImmDecPlot("#" + std::to_string(x),false);
  setImmDecPlot("#" + std::to_string(y),true);
  writeInstruction();
  resetInstruction();
  text_memory+=0x4;
}


void setInstructionI(){ current_instruction.replace(31 + (++index_debug),1,"1");}
void setOp(std::string cmd){current_instruction.replace(0,4,cmd + bin_debug);}

void setRd(std::string Register){ current_instruction.replace( 4 + (dbg? ++index_debug: 0), 4,RegisterToBinary(Register) + bin_debug); }
void setRn(std::string Register){ current_instruction.replace( 8 + (dbg? ++index_debug: 0), 4,RegisterToBinary(Register) + bin_debug); }
void setRs(std::string Register){ current_instruction.replace(12 + (dbg? ++index_debug: 0), 4,RegisterToBinary(Register) + bin_debug); }

void resetInstruction(){ current_instruction = DEFAULT_INSTRUCTION;}

void writeInstruction(){ 
  instruction_list.insert(std::pair<int,std::string>(text_memory,current_instruction));
  //fs<<current_instruction<<'\n';
}


void insertIntOnInstruction(int imm_int){
  std::string imm_str = std::bitset<16>(imm_int).to_string();
  current_instruction.replace( 12+ (dbg? ++index_debug: 0), 16, imm_str + bin_debug);
}

void setImmDec(std::string imm_dec){
  imm_dec.erase(0,1);
  int imm_int = atoi(imm_dec.c_str());
  if (-32768 <= imm_int && imm_int <= 32767){
    short is_negative = imm_int < 0;
    imm_int = is_negative?-1*imm_int:imm_int;
    insertIntOnInstruction(imm_int);
    if(is_negative)current_instruction.replace( 12+ (dbg? ++index_debug: 0), 1, "1");
  }
  else {
    error_count++;
    printt("Error: Immediate value outbounds \"" + imm_dec + "\".");
  }
  
}
void setImmHex(std::string imm_hex){
  int imm_int = (int)strtol(imm_hex.c_str(), 0, 16);
  insertIntOnInstruction(imm_int);
}

void setImmHexPlot(std::string imm_hex,bool isSecondOperand){
  int imm_int = (int)strtol(imm_hex.c_str(), 0, isSecondOperand?8:9);
  std::string imm_str = isSecondOperand? std::bitset<8>(imm_int).to_string():std::bitset<9>(imm_int).to_string();
  current_instruction.replace( 4 + (isSecondOperand?9:0) + (dbg? ++index_debug: 0) , isSecondOperand?8:9, imm_str + bin_debug);
}
void setImmDecPlot(std::string imm_dec,bool isSecondOperand){
  imm_dec.erase(0,1);
  int imm_int = atoi(imm_dec.c_str());
  if (0 <= imm_int && imm_int <= 511 && !isSecondOperand || isSecondOperand && 0 <= imm_int && imm_int <= 255){
    imm_int = imm_int;
    std::string imm_str = isSecondOperand? std::bitset<8>(imm_int).to_string():std::bitset<9>(imm_int).to_string();
    current_instruction.replace( 4 + (isSecondOperand?9:0) + (dbg? ++index_debug: 0), (isSecondOperand?8:9), imm_str + bin_debug);
  }
  else {
    error_count++;
    printt("Error: Immediate value outbounds \"" + imm_dec + "\".");
  }

}


void setColor(std::string rgb_color){current_instruction.replace( 4 + (dbg? ++index_debug: 0), 3, rgb_color + bin_debug);}

std::string RegisterToBinary(std::string r){ r.erase(0,1); return std::bitset<4>(atoi(r.c_str())).to_string();}



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
        if(mempos > 0xFF || mempos <0){
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
  std::string branch_target = std::bitset<8>(target_pos).to_string();
  current_instruction.replace( 4 + (dbg? ++index_debug: 0), 8, branch_target + bin_debug);
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
