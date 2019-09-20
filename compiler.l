%{
    #include <string.h>
%}

COMMENT "**".*
TIPO {SPACE}?("inteiro"|"quebrado"|"letras")
START "comecou"
END "acabou"
INT [0-9]+
CHAR [a-zA-Z]
NUM {INT}+\.?{INT}*
INPUT "imputi"
OUTPUT "altiputi"
VAR "$"({CHAR}|{INT})*","?
IF "ifi"
ELSE "euzi"
WHILE "uaile"
SPACE [\ ]
INVALID (.)

%%

{NUM} {
    yylval.flo = atof(yytext);
    return NUM;
}
{OUTPUT} {
    return OUTPUT;
    }
{INPUT} {
    return INPUT;
    }

[-+()=/*^#{}] {
    return *yytext;
    }
    
{START} {
    return START;
}
{END} {
    return END;
    }
{VAR} {
    strcpy(yylval.str, yytext); 
	return VAR;
}

">" {yylval.fn = 1; return CMP; }
"<" {yylval.fn = 2; return CMP; }
"!=" {yylval.fn = 3; return CMP; }
"==" {yylval.fn = 4; return CMP; }
">=" {yylval.fn = 5; return CMP; }
"<=" {yylval.fn = 6; return CMP; }

{IF} {return IF;}
{ELSE} {return ELSE;}
{WHILE} {return WHILE;}

{COMMENT} {;}
"\n" {;}
{INVALID} {;}
%%

