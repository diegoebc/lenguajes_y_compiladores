%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
FILE* yyin;

int validarCteInteger(char *str);
void tokenInvalido(char *str);
int yyerror(void);
%}

%option noyywrap
%option yylineno

LETTER  [a-zA-Z]


ID      _?{LETTER}({LETTER}|[0-9])*
PYC     ";"
COMA    ","
PAR_A   "("
PAR_C   ")"
LLAVE_A   "{"
LLAVE_C   "}"


CTE_INT   (-?[0-9]+)
CTE_STR    \".*\"
CTE_FLOAT     (-?[0-9]*"."[0-9]+)


TYPE_INT      "Integer"
TYPE_FLOAT    "Float"

DECVAR  "DECVAR"
ENDDEC  "ENDDEC"
WRITE   "write"
IF      "if"
ELSE    "else"
WHILE   "while"


OP_ASIG       ":="
OP_MAS        "+"
OP_MENOS      "-"
OP_DIV        "/"
OP_IGUAL      "=="
OP_DISTINTO   "!="
OP_MULT       "*"
OP_MENOR      "<"
OP_MAYOR      ">"
OP_MENORIGUAL "<="
OP_MAYORIGUAL ">="  

AVG           "AVG"


%%


{PYC}           {printf("\nToken PYC: %s\n",yytext); return PYC;}
{COMA}          {printf("\nToken COMA: %s\n",yytext); return COMA;}
{PAR_A}         {printf("\nToken PAR_A: %s\n",yytext); return PAR_A;}
{PAR_C}         {printf("\nToken PAR_C: %s\n",yytext); return PAR_C;}
{LLAVE_A}       {printf("\nToken LLAVE_A: %s\n",yytext); return LLAVE_A;}
{LLAVE_C}       {printf("\nToken LLAVE_C: %s\n",yytext); return LLAVE_C;}


{CTE_INT}   {validarCteInteger(yytext); printf("\nToken CTE_INT: %s\n",yytext); return CTE_INT;} 
{CTE_STR}    {printf("\nToken CTE_STR: %s\n",yytext); return CTE_STR;}
{CTE_FLOAT}     {printf("\nToken CTE_FLOAT: %s\n",yytext); return CTE_FLOAT;}


{TYPE_INT}  {printf("\nToken TYPE_INT: %s\n",yytext); return TYPE_INT;}
{TYPE_FLOAT}    {printf("\nToken TYPE_FLOAT: %s\n",yytext); return TYPE_FLOAT;}

{DECVAR}        {printf("\nToken DECVAR: %s\n",yytext); return DECVAR;}
{ENDDEC}        {printf("\nToken ENDDEC: %s\n",yytext); return ENDDEC;}
{WRITE}         {printf("\nToken WRITE: %s\n",yytext); return WRITE;}
{IF}            {printf("\nToken IF: %s\n",yytext); return IF;}
{ELSE}          {printf("\nToken ELSE: %s\n",yytext); return ELSE;}
{WHILE}         {printf("\nToken WHILE: %s\n",yytext); return WHILE;}

{OP_ASIG}       {printf("\nToken OP_ASIG: %s\n",yytext); return OP_ASIG;}
{OP_MAS}        {printf("\nToken OP_MAS: %s\n",yytext); return OP_MAS;}
{OP_MENOS}      {printf("\nToken OP_MENOS: %s\n",yytext); return OP_MENOS;}
{OP_DIV}        {printf("\nToken OP_DIV: %s\n",yytext); return OP_DIV;}
{OP_MULT}       {printf("\nToken OP_MULT: %s\n",yytext); return OP_MULT;}
{OP_IGUAL}      {printf("\nToken OP_IGUAL: %s\n",yytext); return OP_IGUAL;}
{OP_DISTINTO}   {printf("\nToken OP_DISTINTO: %s\n",yytext); return OP_DISTINTO;}
{OP_MENOR}      {printf("\nToken OP_MENOR: %s\n",yytext); return OP_MENOR;}
{OP_MAYOR}      {printf("\nToken OP_MAYOR: %s\n",yytext); return OP_MAYOR;}
{OP_MENORIGUAL} {printf("\nToken OP_MENORIGUAL: %s\n",yytext); return OP_MENORIGUAL;}
{OP_MAYORIGUAL} {printf("\nToken OP_MAYORIGUAL: %s\n",yytext); return OP_MAYORIGUAL;}
{AVG}           {printf("\nToken AVG: %s\n",yytext); return AVG;}
{ID}            {printf("\nToken ID: %s\n",yytext); return ID;}


"\n"
"\t"
" "
.     tokenInvalido(yytext);

%%

int validarCteInteger(char *str){
  int cte = atoi(str);
  return 0;
}


int main(int argc, char* argv[]){
  if((yyin = fopen("prueba.txt","rt")) == NULL){
    printf("\nNo se pudo abrir el archivo prueba.txt");
    return 1;
  }
  yyparse();
  fclose(yyin);
  return 0;
}

void tokenInvalido(char* str){
  printf("\nToken invalido: %s\n",str);
  yyerror();
}

int yyerror(void){
  printf("\nLinea %d: Error Sintactico\n",yylineno);
  exit(1);
}

