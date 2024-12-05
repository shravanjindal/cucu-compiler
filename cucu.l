%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#define YYSTYPE char*

#include "y.tab.h"
%}

%%
([ ]+) {}

(\/\*(.|\n)*\*\/) {}

(if) {fprintf(yyout,"CONTROL STATEMENT: IF_Statement\n");return IF;}

(else) {fprintf(yyout,"CONTROL STATEMENT: ELSE_Statement\n");return ELSE;}

(while) {fprintf(yyout,"CONTROL STATEMENT: WHILE_Statement\n");return WHILE;}

([\{]) {fprintf(yyout,"PARANTHESIS : {\n");return yytext[0];}

([\}]) {fprintf(yyout,"PARANTHESIS : }\n");return yytext[0];}

([\(]) {fprintf(yyout,"PARANTHESIS : (\n");return yytext[0];}

([\)]) {fprintf(yyout,"PARANTHESIS : )\n");return yytext[0];}

([\[]) {fprintf(yyout,"PARANTHESIS : [\n");return yytext[0];}

([\]]) {fprintf(yyout,"PARANTHESIS : ]\n");return yytext[0];}

(char[ \t\n]*[\*]*) { yylval=strdup(yytext); fprintf(yyout,"TYPE: %s\n",yytext);return DATATYPE;}

(int) { yylval=strdup(yytext); fprintf(yyout,"TYPE: %s\n",yytext);return DATATYPE;}

(return) { yylval=strdup(yytext); fprintf(yyout,"TYPE: %s\n",yytext);return RET;}

([A-Za-z][A-Za-z0-9_]*) { yylval=strdup(yytext); fprintf(yyout,"ID: %s\n",yytext);return ID;}

(;) { yylval=strdup(yytext); fprintf(yyout,"SEMI : ;\n");return yytext[0];}

([0-9]*) { yylval=strdup(yytext); fprintf(yyout,"NUM : %s\n",yytext);return NUM;}

([<>=!]=|>|<) { yylval=strdup(yytext); fprintf(yyout,"RELATIONAL OPERATOR: %s\n",yytext);yylval=malloc(strlen(yytext));strcpy(yylval,yytext);return RO;}

([\%]) { yylval=strdup(yytext); fprintf(yyout,"MODULO : %%\n");return yytext[0];}

([\*]) { yylval=strdup(yytext); fprintf(yyout,"PRODUCT : *\n");return yytext[0];}

([\/]) { yylval=strdup(yytext); fprintf(yyout,"DIVIDE : /\n");return yytext[0];}

([\+]) { yylval=strdup(yytext); fprintf(yyout,"PLUS : +\n");return yytext[0];}

([\-]) { yylval=strdup(yytext); fprintf(yyout,"SUBTRACT : -\n");return yytext[0];}

([=]) { yylval=strdup(yytext); fprintf(yyout,"ASSIGN : =\n");return yytext[0];}

([,]*) { yylval=strdup(yytext); fprintf(yyout,"COMMA : ,\n");return yytext[0];}

%%
int yywrap() {
    return 1;  // Indicate that there are no more input files
}
