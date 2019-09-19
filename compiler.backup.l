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
IF "ifi"
ELSE "eus"
WHILE
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

">" {yylval.fn = 1; return CMP; }
"<" {yylval.fn = 2; return CMP; }
"<>" {yylval.fn = 3; return CMP; }
"==" {yylval.fn = 4; return CMP; }
">=" {yylval.fn = 5; return CMP; }
"<=" {yylval.fn = 6; return CMP; }

{IF} {return IF;}
{ELSE} {return ELSE;}
{WHILE} {return WHILE;}

{COMMENT} {;}
{INVALID} {;}

%%

