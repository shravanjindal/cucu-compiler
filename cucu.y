%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define YYSTYPE char*
    extern int yylex();
	extern FILE* yyin;
	extern FILE* yyout;
	extern void yyerror(char* msg);
%}
%token ID NUM DATATYPE RO IF ELSE WHILE RET

%%
    LANG:   VAR_DEC
    |       FUNC_DEC
    |       FUNC_DEF
    |       LANG VAR_DEC
    |       LANG FUNC_DEC
    |       LANG FUNC_DEF
    ;
    
    VAR_DEC:    DATATYPE ID ';'  {fprintf(stdout,"DATATYPE : %s \nVARIABLE : %s\n\n",$1,$2);}
    |           DATATYPE ID '=' EXPR ';' {fprintf(stdout,"DATATYPE : %s \nVARIABLE : %s \n\n",$1,$2);}
    |           DATATYPE ID '=' FUNC_S  {fprintf(stdout,"DATATYPE : %s \nVARIABLE : %s \n\n",$1,$2);}
    ;

    FUNC_DEC:   DATATYPE ID '(' ARGLIST ')' ';' {fprintf(stdout,"FUNCTION DEFINITION \n\tDATATYPE : %s\nIDENTIFIER : %s\n",$1,$2);}
    |           DATATYPE ID '(' ')' ';'         {fprintf(stdout,"FUNCTION DEFINITION \n\tDATATYPE : %s\nIDENTIFIER : %s\n",$1,$2);}
    ;

    FUNC_DEF:   DATATYPE ID '(' ARGLIST ')' STMT {fprintf(stdout,"FUNCTION DEFINITION \n\tDATATYPE : %s\n\tIDENTIFIER : %s\n\n",$1,$2);}
    |           DATATYPE ID '(' ')' STMT         {fprintf(stdout,"FUNCTION DEFINITION \n\tDATATYPE : %s\nIDENTIFIER : %s\n",$1,$2);}
    ;

    ARGLIST:    DATATYPE ID {fprintf(stdout,"\t\tFUNCTION ARGUMENT :%s DATATYPE : %s\n",$2,$1);}
    |           ARGLIST ',' DATATYPE ID {fprintf(stdout,"\t\tFUNCTION ARGUMENT :%s DATATYPE : %s\n",$4,$3);}
    ;

    STMT:   VAR_DEC
    |       ARTH_S 
    |       RTN_S
    |       IF_S
    |       WHILE_S
    |       FUNC_S
    |       BLOCK_S
    ;

    ARTH_S: ID '=' EXPR ';' {fprintf(stdout,"IDENTIFIER : %s\nASSIGNMENT : %s\n",$1,$2);}
    ;

    EXPR:   EXPR '-' TERM   {fprintf(stdout,"\tSUBTRACTION : %s\n",$2);}
    |       EXPR '+' TERM   {fprintf(stdout,"\tADDITION : %s\n",$2);}
    |       TERM            
    ;

    TERM:   TERM '*' FAC    {fprintf(stdout,"\t\tMULTIPLICATION : %s\n",$2);}
    |       TERM '/' FAC    {fprintf(stdout,"\t\tDIVISION : %s\n",$2);}
    |       FAC
    ;

    FAC:    ID              {fprintf(stdout,"VARIABLE : %s\n",$1);}
    |       NUM             {fprintf(stdout,"CONST : %s\n",$1);}
    |       FUNC_S
    |       '(' EXPR ')'    {fprintf(stdout,"PARANTHESIS : ()\n");}
    ;

    RTN_S:  RET EXPR ';'    {fprintf(stdout,"RETURN STATEMENT\n");}
    |       RET FUNC_S      {fprintf(stdout,"RETURN STATEMENT AS FUNC_CALL\n");}
    ;

    FUNC_S: ID '(' IDLIST ')' ';'   {fprintf(stdout,"FUNCTION CALLING :\n\tIDENTIFIER : %s\n",$1);}
    |       ID '(' ')' ';'          {fprintf(stdout,"FUNCTION CALLING :\n\tIDENTIFIER : %s\n",$1);}
    ;

    IF_S:   IF '(' BOOL ')' BLOCK_S ELSE BLOCK_S    {fprintf(stdout,"\t CONDITIONAL STATEMENT :\n\t\tIF()\n\t\tELSE\n");}
    |       IF '(' BOOL ')' BLOCK_S                 {fprintf(stdout,"\t CONDITIONAL STATEMENT :\n\t\tIf()\n");}
    ;

    WHILE_S:WHILE '(' BOOL ')' STMT     {fprintf(stdout,"\t CONDITIONAL STATEMENT :\n\t\t%s()\n",$1);}
    ;

    BLOCK_S: '{' STMT_LIST '}'          
    |          '{''}'
    ;

    STMT_LIST: STMT
    |          STMT_LIST STMT
    ;

    BOOL:   EXPR RO EXPR                {fprintf(stdout,"\t\t\tBOOL OPERATOR OF CONDITIONAL STATEMENT : %s\n",$2);}
    ;

    IDLIST: ID      {fprintf(stdout,"\tFUNCTION ARGUMENTS OF FUNC CALL :\n\tIDENTIFIER : %s\n",$1);}
    |       NUM     {fprintf(stdout,"\tFUNCTION ARGUMENTS OF FUNC CALL :\n\tNUM : %s\n",$1);}
    |       IDLIST ',' ID    {fprintf(stdout,"\tFUNCTION ARGUMENTS OF FUNC CALL :\n\tIDENTIFIER : %s\n",$3);}
    |       IDLIST ',' NUM   {fprintf(stdout,"\tFUNCTION ARGUMENTS OF FUNC CALL :\n\tNUM : %s\n",$3);}
    ;
    
%%
int main(int argc , char** argv){
    if(argc < 2){
		printf("Syntax is %s <filename>\n", argv[0]);
		return 0;
	}
	yyin = fopen(argv[1], "r");
	yyout = fopen("Lexer.txt", "w");
	stdout = fopen("Parser.txt", "w");
    fprintf(stdout,"\n*****************************************\n\t\tPARSING STARTS\n*****************************************\n\n");
	yyparse();
    fprintf(stdout,"\n\n\n*****************************************\n\t\tPARSING ENDS\n*****************************************\n\n");
}

void yyerror(char* msg){
	printf("\n%s\n", msg);
}