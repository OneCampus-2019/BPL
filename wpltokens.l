%{
	#include<stdio.h>
	#include<string.h>
    #include "wplparser.tab.h"
    extern FILE *yyin;
%}
%option noyywrap
ident [_a-zA-Z][a-zA-Z0-9]*
intnum   [+-]?[0-9]+.?[0-9]*
stringvalue   [a-zA-Z0-9]
sdelim   [|]
%%
onyesha {return onyesha;}
true    {yylval.string=strdup(yytext); return true;}
false   {yylval.string=strdup(yytext);return false;}
{sdelim}+ {return delim;}
{ident} {yylval.id=strdup(yytext); return identifier;}
{intnum}  {yylval.number=atof(yytext);return number;}
"+"     {return plus;}
"-"     {return minus;}
"/"     {return divide;}
"*"     {return multi;}
"%"     {return mod;}
"#"     {return hash;}
"="      {return eko;}
"\n"     {return endline;}
" "      {return space;}
.        {printf("invalid input found\n %s",yytext);}





