%{
  #include "y.tab.h"
  #include <string>
  #include <string.h>
  #include <stdlib.h>
  #include <iostream>
  
  void yyerror(std::string S);
  void setOperationValue(std::string oper, size_t);
%}

%option yylineno

comment ;[^\n]*
label  [a-zA-Z_][a-zA-Z0-9_]*
immedec   \#(0|-?[1-9][0-9]*)
zeroX     0x
Hex       [0-9A-Fa-f]

numero [0-9]+

ADD  (A|a)(D|d)(D|d)
SUB  (S|s)(U|u)(B|b)
MOV  (M|m)(O|o)(V|v)
CMP  (C|c)(M|m)(P|p)



B  (B|b)
BEQ  (BEQ|beq)

LDR  (LDR|ldr)
STR  (STR|str)

KRN  (KRN|krn)
LKN  (LKN|lkn)
LDK  (LDK|ldk)
SHK  (SHK|shk)


blur @blur
sharpen @sharpen
oversharpen @oversharpen



endline \n


%%


  /*Operation Keywords*/
{ADD}                         {yylval.id=strdup(yytext); return addition;}
{SUB}                         {yylval.id=strdup(yytext); return subtra;}
{MOV}                         {yylval.id=strdup(yytext); return mv;}
{CMP}                         {yylval.id=strdup(yytext); return cmp;}

{B}                           {yylval.id=strdup(yytext); return branch;}
{BEQ}                         {yylval.id=strdup(yytext); return brancheq;}

{LDR}                         {yylval.id=strdup(yytext); return ldr;}
{STR}                         {yylval.id=strdup(yytext); return str;}

{KRN}                         {yylval.id=strdup(yytext); return krn;}
{LKN}                         {yylval.id=strdup(yytext); return lkn;}
{LDK}                         {yylval.id=strdup(yytext); return ldk;}
{SHK}                         {yylval.id=strdup(yytext); return shk;}



(r|R)([0-9]|1[0-5])           {yylval.id=strdup(yytext); return reg;}

{immedec}                     {yylval.id=strdup(yytext); return immedec;}

{label}:                      {yylval.id=strdup(yytext); return memory_direction_tag;}
{label}                       {yylval.id=strdup(yytext); return label;}

{comment}                     {return commentary;}

{blur}                        {yylval.id=strdup(yytext);return blur;}
{sharpen}                     {yylval.id=strdup(yytext);return sharpen;}
{oversharpen}                 {yylval.id=strdup(yytext);return oversharpen;}


\[                            {yylval.id=strdup(yytext);return lsqrtb;}
\]                            {yylval.id=strdup(yytext);return rsqrtb;}


[,\[\]\n\=\!]                 {return yytext[0];}
[\t ]+                        {;}
.                             {yylval.id=strdup(yytext); /*yyerror(yytext);*/}
<<EOF>>                       { yyterminate(); return END; }

%%

int yywrap(void){
  return 1;
}
