%{
#include <stdio.h>
#include "imageprocessing.h"
#include <FreeImage.h>

void yyerror(char *c);
int yylex(void);

%}
%union {
  char    strval[50];
  int     ival;
}
%token <strval> STRING
%token <ival> VAR IGUAL EOL ASPA SYMBOL MULT
%left SOMA

%%

PROGRAMA:
        PROGRAMA EXPRESSAO EOL
        |
        ;

EXPRESSAO:
    | STRING IGUAL STRING {
        printf("Copiando %s para %s\n", $3, $1);
        imagem I = abrir_imagem($3);
        printf("Li imagem %d por %d\n", I.width, I.height);
        salvar_imagem($1, &I);
                          }

    ;
BRIGTH: 
    | STRING IGUAL STRING SYMBOL MULT  {
         printf("Aplicando %s em %s\n", $5, $3);
         brilho($3, $5, $4);
         salvar_imagem($1, &I);

                                  }  
                           

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
  FreeImage_Initialise(0);
  yyparse();
  return 0;

}
