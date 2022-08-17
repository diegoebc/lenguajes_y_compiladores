%{
#include <stdio.h>
%}
  
%token ID
%token PYC    
%token COMA    
%token PAR_A   
%token PAR_C   
%token LLAVE_A
%token LLAVE_C
%token CTE_INT
%token CTE_STR
%token CTE_FLOAT
%token TYPE_INT
%token TYPE_FLOAT
%token DECVAR
%token ENDDEC
%token WRITE
%token IF
%token ELSE
%token WHILE
%token OP_ASIG
%token OP_MAS 
%token OP_MENOS
%token OP_DIV  
%token OP_IGUAL
%token OP_DISTINTO
%token OP_MULT    
%token OP_MENOR   
%token OP_MAYOR   
%token OP_MENORIGUAL
%token OP_MAYORIGUAL
%token AVG
%%

progra: asig
programa: main  {printf("\nRegla 1: <programa> -> <main>\n");}

main: declaraciones cuerpo_programa {printf("\nRegla 2: <main> -> <declaraciones> <cuerpo_programa>\n");}
          |cuerpo_programa {printf("\nRegla 3: <main> -> <cuerpo_programa>\n");}

declaraciones: DECVAR lista_variables ENDDEC {printf("\nRegla 4: <declaraciones> -> DECVAR <listat_variables> ENDDEC\n");}

lista_variables: lista_variables declaracion {printf("\nRegla 5: <lista_variables> -> <lista_variables> <declaracion>\n");} 
                  |declaracion               {printf("\nRegla 6: <lista_variables> -> <declaracion>\n");}

declaracion: lista_de_id OP_ASIG tipo_de_dato PYC {printf("\nRegla 7: <declaracion> -> <lista_de_id> OP_ASIG tipo_de_dato PYC \n");}

lista_de_id: ID COMA lista_de_id {printf("\nRegla 8: <lista_de_id> -> ID COMA <lista_de_id>\n");}
              |ID                {printf("\nRegla 9: <lista_de_id> -> ID\n");}

tipo_de_dato: TYPE_INT      {printf("\nRegla 10: <tipo_de_dato> -> TYPE_INT\n");} 
              |TYPE_FLOAT   {printf("\nRegla 11: <tipo_de_dato> -> TYPE_FLOAT\n");}

cuerpo_programa: cuerpo_programa sentencia {printf("\nRegla 12: <cuerpo_programa> -> <cuerpo_programa> <sentencia>\n");}
                |sentencia {printf("\nRegla 13: <cuerpo_programa> -> <sentencia>\n");}

sentencia: asignacion {printf("\nRegla 14: <sentencia> -> <asignacion>\n");}
          |escritura {printf("\nRegla 15: <sentencia> -> <escritura>\n");}
          |seleccion {printf("\nRegla 16: <sentencia> -> <seleccion>\n");}
          |iteracion {printf("\nRegla 17: <sentencia> -> <iteracion>\n");}

asignacion: ID OP_ASIG expresion PYC {printf("\nRegla 18: <asignacion> -> ID OP_ASIG <expresion> PYC\n");}

expresion: expresion OP_MAS termino {printf("\nRegla 19: <expresion> -> <expresion> OP_MAS <termino>\n");}
          |expresion OP_MENOS termino {printf("\nRegla 20: <expresion> -> <expresion> OP_MENOS <termino>\n");}
          |termino {printf("\nRegla 21: <expresion> -> <termino>\n");}

termino: termino OP_MULT factor {printf("\nRegla 22: <termino> -> <termino> OP_MULT <factor>\n");}
        |termino OP_DIV factor {printf("\nRegla 23: <termino> -> <termino> OP_DIV <factor>\n");}
        |factor {printf("\nRegla 24: <termino> -> <factor>\n");}

factor: PAR_A expresion PAR_C {printf("\nRegla 25: <factor> -> PAR_A <expresion> PAR_C\n");} 
        |ID                   {printf("\nRegla 26: <factor> -> ID\n");}
        |CTE_INT              {printf("\nRegla 27: <factor> -> CTE_INT\n");}
        |CTE_FLOAT            {printf("\nRegla 28: <factor> -> CTE_FLOAT\n");}

escritura: WRITE CTE_STR PYC    {printf("\nRegla 29: <escritura> -> WRITE CTE_STR PYC\n");}
          |WRITE ID PYC         {printf("\nRegla 30: <escritura> -> WRITE ID PYC\n");}
          |WRITE CTE_INT PYC    {printf("\nRegla 31: <escritura> -> WRITE CTE_INT PYC\n");}
          |WRITE CTE_FLOAT PYC  {printf("\nRegla 32: <escritura> -> WRITE CTE_FLOAT PYC\n");}

seleccion: IF PAR_A condicion PAR_C LLAVE_A cuerpo_programa LLAVE_C {printf("\nRegla 33: <seleccion> -> IF PAR_A <condicion> PAR_C LLAVE_A <cuerpo_programa> LLAVE_C\n");}
          |IF PAR_A condicion PAR_C LLAVE_A cuerpo_programa LLAVE_C ELSE LLAVE_A cuerpo_programa LLAVE_C {printf("\nRegla 34: <seleccion> -> IF PAR_A <condicion> PAR_C LLAVE_A <cuerpo_programa> LLAVE_C ELSE LLAVE_A <cuerpo_programa> LLAVE_C\n");}

condicion: ID comparador CTE_INT {printf("\nRegla 35: <condicion> -> ID <comparador> CTE_INT\n");}

comparador: OP_IGUAL      {printf("\nRegla 36: <comparador> -> OP_IGUAL\n");}
          |OP_DISTINTO    {printf("\nRegla 37: <comparador> -> OP_DISTINTO\n");}
          |OP_MAYOR       {printf("\nRegla 38: <comparador> -> OP_MAYOR\n");}
          |OP_MAYORIGUAL  {printf("\nRegla 39: <comparador> -> OP_MAYORIGUAL\n");}
          |OP_MENOR       {printf("\nRegla 40: <comparador> -> OP_MENOR\n");}
          |OP_MENORIGUAL  {printf("\nRegla 41: <comparador> -> OP_MENORIGUAL\n");}

iteracion: WHILE PAR_A condicion PAR_C LLAVE_A cuerpo_programa LLAVE_C {printf("\nRegla 42: <iteracion> -> WHILE PAR_A condicion PAR_C LLAVE_A <cuerpo_programa> LLAVE_C\n");}

asig: ID OP_ASIG promedio               {printf("\nRegla 1: <asig> -> ID OP_ASIG <promedio>\n");}
promedio: AVG PAR_A lista PAR_C         {printf("\nRegla 2: <promedio> -> AVG PAR_A <lista> PAR_C\n");}
lista: lista COMA ID                    {printf("\nRegla 3: <lista> -> <lista> COMA ID\n");}
        |lista COMA CTE_INT             {printf("\nRegla 4: <lista> -> <lista> COMA CTE_INT\n");}
        |CTE_INT                        {printf("\nRegla 5: <lista> -> CTE_INT\n");}
        |ID                             {printf("\nRegla 6: <lista> -> ID\n");}

%%

