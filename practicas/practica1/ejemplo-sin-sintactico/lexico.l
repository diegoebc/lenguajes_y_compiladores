%{
  // includes de C prototipos de c y declaracion de variables globales
  #include <stdio.h>
  #include <stdlib.h>
  FILE* yyin;

  void tokenInvalido(char* yytext);
  void validarCteInt(char* yytext);
  int yyerror(void);
%}


%option noyywrap
%option yylineno


DIG_CON_CERO    [0-9]    
DIG_SIN_CERO    [1-9]
LETRA           [a-zA-Z]



DECVAR          "DECVAR"
ENDDEC          "ENDDEC"
WRITE           "write"
IF              "if"
ELSE            "else"
WHILE           "while"
PUNTO           "."
DOS_P           ":"
COMA            ","
PYC             ";"
OP_MAS          "+"
OP_MENOS        "-"
OP_MULT         "*"
OP_DIV          "/"
OP_IGUAL        "=="
OP_DISTINTO     "!="
OP_MAYOR        ">"
OP_MAYOR_IGUAL  ">="|"=>"
OP_MENOR        "<"
OP_MENOR_IGUAL   "<="|"=<"
PAR_A           "("
PAR_C           ")"
LLAVE_A         "{"
LLAVE_C         "}"
COMILLA_DOBLE   ["]

TYPE_INT        "Integer"
TYPE_FLOAT      "Float"


CTE_STRING      {COMILLA_DOBLE}.*{COMILLA_DOBLE}
CTE_INT         -?{DIG_CON_CERO}({DIG_SIN_CERO})*
CTE_FLOAT       -?{DIG_CON_CERO}{PUNTO}{DIG_CON_CERO}
ID              {LETRA}({LETRA}|{DIG_CON_CERO})*



%%

{ID}               {printf("\nToken ID: %s\n",yytext);}
{DECVAR}           {printf("\nToken DECVAR: %s\n",yytext);}
{ENDDEC}           {printf("\nToken ENDDEC: %s\n",yytext);}
{WRITE}            {printf("\nToken WRITE: %s\n",yytext);}
{IF}               {printf("\nToken IF: %s\n",yytext);}
{ELSE}             {printf("\nToken ELSE: %s\n",yytext);}
{WHILE}            {printf("\nToken WHILE: %s\n",yytext);}
{PUNTO}            {printf("\nToken PUNTO: %s\n",yytext);}
{DOS_P}            {printf("\nToken DOS_P: %s\n",yytext);}
{COMA}             {printf("\nToken COMA: %s\n",yytext);}
{PYC}              {printf("\nToken PYC: %s\n",yytext);}
{OP_MAS}           {printf("\nToken OP_MAS: %s\n",yytext);}
{OP_MENOS}         {printf("\nToken OP_MENOS: %s\n",yytext);}
{OP_MULT}          {printf("\nToken OP_MULT: %s\n",yytext);}
{OP_DIV}           {printf("\nToken OP_DIV: %s\n",yytext);}
{OP_IGUAL}         {printf("\nToken OP_IGUAL: %s\n",yytext);}
{OP_DISTINTO}      {printf("\nToken OP_DISTINTO: %s\n",yytext);}
{OP_MAYOR}         {printf("\nToken OP_MAYOR: %s\n",yytext);}
{OP_MAYOR_IGUAL}   {printf("\nToken OP_MAYOR_IGUAL: %s\n",yytext);}
{OP_MENOR}         {printf("\nToken OP_MENOR: %s\n",yytext);}
{OP_MENOR_IGUAL}   {printf("\nToken OP_MENOR_IGUAL: %s\n",yytext);}
{PAR_A}            {printf("\nToken PAR_A: %s\n",yytext);}
{PAR_C}            {printf("\nToken PAR_C: %s\n",yytext);}
{LLAVE_A}          {printf("\nToken LLAVE_A: %s\n",yytext);}
{LLAVE_C}          {printf("\nToken LLAVE_C: %s\n",yytext);}

{TYPE_INT}         {printf("\nToken TYPE_INT: %s\n",yytext);}
{TYPE_FLOAT}       {printf("\nToken TYPE_FLOAT: %s\n",yytext);}


{CTE_STRING}       {printf("\nToken CTE_STRING: %s\n",yytext);}
{CTE_INT}          { validarCteInt(yytext); printf("\nToken CTE_INT: %s\n",yytext);}
{CTE_FLOAT}        {printf("\nToken CTE_FLOAT: %s\n",yytext);}

"\n"
"\t"
" "
.                 tokenInvalido(yytext);

%%


void tokenInvalido(char* yytext){
  printf("\nToken invalido: %s\n",yytext);
  yyerror();
}

void validarCteInt(char* yytext){
    int num = atoi(yytext);
    if(num < -65536 || num>65535){
      printf("\nCte fuera de rango: %s\n",yytext);
      yyerror();
    }
}

int yyerror(void){
  printf("\nLinea %d: Error Sintactico\n",yylineno);
  printf("\nSe termino el proceso de compilacion de manera fallida");
  exit(1);
}

int main(int argc, char* argv[]){
  ++argv; --argc; //ignoro el nombre del ejecutable
  yyin = fopen(argv[0],"r");
  if(yyin == NULL){
    printf("\nNo se pudo abrir el archivo %s\n",argv[0]);
    return 1;
  }
  yylex();
  fclose(yyin);
  return 0;
}
