%{
    #include <string.h>
%}

COMMENT "**".*
TIPO {SPACE}?("inteiro"|"quebrado"|"letras")
START "comecou"
END "acabou"
INT [0-9]+
CHAR [a-zA-Z]
REAL {INT}+\.?{INT}*
INPUT "imputi"
OUTPUT "altiputi"
VAR "$"({CHAR}|{INT})*","?
SPACE [\ ]
INVALID (.)

%%

{REAL} {
    yylval.flo = atof(yytext);
    return REAL;
}
{OUTPUT} {
    return OUTPUT;
    }
{INPUT} {
    return INPUT;
    }

[-+()=/*^#] {
    return *yytext;
    }
{START} {
    return START;
}
{END} {
    return END;
    }
{TIPO} {
    strcpy(yylval.str, yytext);  
    return TIPO;
}
{VAR} {
    strcpy(yylval.str, yytext);  
	return VAR;
}
{COMMENT} {;}
{INVALID} {;}

%%

