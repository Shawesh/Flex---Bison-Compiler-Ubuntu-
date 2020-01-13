%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h" // generated via yacc -d

extern int yyval, yylineno;

char ch[2];
char* buffer;
%}

printable [\x20-\x7E]

%%

[ \t\f\v]          { /* Ignore Whitespace */ }
"/%"{printable}*"%/"   { /* Ignore Comments */ }
[\n] 			         { yylineno = yylineno + 1; }

\'{printable}\'    { memcpy(ch, &yytext[1], 1); ch[1] = '\0'; yylval.string = strdup(ch); return CHARACTER;};
\"([^"\\]*(?:\\[\x20-\x7E][^"\\]*)*)\"   { buffer = (char*)malloc(sizeof(char) * (yyleng - 1)); memcpy(buffer, &yytext[1], yyleng - 2); buffer[yyleng - 2] = '\0'; yylval.string = strdup(buffer); free(buffer); return STRING; }

"("                { return LP; }
")"                { return RP; }
"[" 			         { return LB;}
"]" 			         { return RB;}
"{"                { return LC; }
"}"                { return RC; }
"|"                { return ABS; }

":"                { return COLON; }
";" 			         { return SEMI; }
"," 			         { return COMMA; }
"." 			         { return DOT; }
"'"                { return S_QUOTE; }
"\""               { return D_QUOTE; }
"&"                { return ADDRESS; }
"^"                { return DEREFERENCE; }

"="                { return ASSIGN; }
"+"                { return PLUS_OP; }
"-"                { return MINUS_OP; }
"*"                { return MULTIPLY_OP; }
"/"                { return DIV_OP; }
"%"                { return MOD_OP; }

"!"                { return NOT_OP; }
"<"                { return LT_OP;}
">"                { return GT_OP; }
"<="               { return LE_OP; }
">="               { return GE_OP; }
"=="               { return EQ_OP; }
"!="               { return NE_OP; }
"&&"               { return AND_OP; }
"||"               { return OR_OP; }

"if"               { return IF; }
"else"             { return ELSE; }
"while"            { return WHILE; }
"true"             { return BOOL_TRUE; }
"false"            { return BOOL_FALSE; }

"var"              { return VAR; }
"function"        { return FUNCTION; }
"return"           { return RETURN; }
"null"             { return NULL_PTR; }

"boolean"|"char"|"integer"|"intptr"|"charptr"  { yylval.string = strdup(yytext); return TYPE; }
"string" { return TYPE_STRING; }
(0|[1-9][0-9]*|0[xX][0-9a-fA-F]+|0[0-7]+|[01]+b)        { yylval.string = strdup(yytext); return INTEGER; }
[a-zA-Z][0-9_a-zA-Z]*                                   { yylval.string = strdup(yytext); return IDENTIFIER; }

.                  {yyerror("scanner error"); exit(1);}
%%
