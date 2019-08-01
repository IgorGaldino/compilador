%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int yylex();
void yyerror (char *s){
	printf("%s\n", s);
}

typedef struct var {
	char nome[50];
	float valor;
	struct var *next;
} Var;

int isNotVar = 1;
Var *variaveis = NULL;

Var *buscaVar(Var *vars, char nome[]) {
	Var *list;
	for(list = vars; list != NULL; list=list->next)
		if(!strcmp(list->nome, nome))
			return list;
	return NULL;
}

Var *insereVar(Var *vars, char nome[]) {
	Var *nova = (Var*)malloc(sizeof(Var));
	strcpy(nova->nome, nome);
	nova->valor = 0;
	nova->next = vars;
	return nova;
}

%}

%union{
	float flo;
	int inte;
	char str[50];
	}

%token <flo>REAL
%token <str>VAR
%token <str>TIPO
%token START
%token END
%token OUTPUT
%token INPUT
%left '+' '-'
%left '*' '/'
%right '^' '#'
%right NEG
%type <flo> exp
%type <flo> valor

%%

prog: START cod END
	;

cod: cod cmdos
	|
	;

cmdos: OUTPUT '(' exp ')' {
	if(!isNotVar)
		printf("%.2f \n", $3);
	}
	| TIPO VAR {
		Var *aux = buscaVar(variaveis, $2);
		if(aux == NULL)
			variaveis = insereVar(variaveis, $2);
		else
			puts("Váriavel já declarada!!!");
	}
	| TIPO VAR '=' exp {
		Var *aux = buscaVar(variaveis, $2);
		if(aux == NULL) {
			aux = insereVar(variaveis, $2);
			aux->valor = $4;
			variaveis = aux;
		}
		else
			puts("Váriavel já declarada!!!");
	}
	| VAR '=' exp {
		Var *aux = buscaVar(variaveis, $1);
		if(aux == NULL)
			puts("Váriavel não declarada!!!");
		else
			aux->valor = $3;
	}
	| INPUT '(' VAR ')' {
		Var *aux = buscaVar(variaveis, $3);
		if(aux == NULL)
			puts("Váriavel não declarada!!!");
		else
			scanf("%f", &aux->valor);
	}
	;

exp: exp '+' exp {$$ = $1 + $3;}
	|exp '-' exp {$$ = $1 - $3;}
	|exp '*' exp {$$ = $1 * $3;}
	|exp '/' exp {$$ = $1 / $3;}
	|'(' exp ')' {$$ = $2;}
	|exp '^' exp {$$ = pow($1,$3);}
	|'#' exp {$$ = sqrt($2);}
	|'-' exp %prec NEG {$$ = -$2;}
	|valor {$$ = $1;}
	| VAR {
		Var *aux = buscaVar(variaveis, $1);

        if(aux == NULL) {
            puts("Variável não existe!!");
			isNotVar = 1;
		}
        else {
			isNotVar = 0;
	        $$ = aux->valor;
		}
        
	}
	;

valor: REAL {$$ = $1;}
	;

%%

#include "lex.yy.c"
int main(){
	yyin=fopen("cod.ig", "r");
	yyparse();
    yylex();
    fclose(yyin);
// 	|'raiz(' exp ')' {$$ = sqrt($2);}
    return 0;
}