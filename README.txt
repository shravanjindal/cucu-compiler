# Cucu-Compiler
A simple and small toy C-compiler

## How to run ?
Enter following 4 commands into terminal :

    lex cucu.l

    yacc -d cucu.y 

    cc lex.yy.c y.tab.c -o cucu

    ./cucu Sample1.cu

 Where cucu.l is lex file , cucu.y is yacc file , Sample1.cu is our program file 
 
After execution of these commands , Linux terminal will create 2 more files, one is Lexer.txt and Parser.txt

Lexer.txt will contains tokens of our program, where as 
Parser.txt contains structual breakdown/errors of our program.
    
## Assumptions while entering the program file;

    1)Negative numbers are not allowed 
    2)Increment (a++) and decrement(a--) operators are not allowed 
    3)Only (int) and (char type pointers) datatypes are allowed 
    4)Use of bitwise operators are not allowed
    5)Only Conditional Statements followed by curly brackets are allowed
    6)Parser will stop printing after it encounters syntax errors
    7)Modulo operator is not supported in arithmetic 
    8)Double slash(single line comments) are not allowed 
    9)Boolean operations in functional calls are not allowed 
    10)Tokens like ID NUM DATATYPE RO IF ELSE WHILE RET are allowed 

### Point to be noted:
    Output In Parser.txt is Recursive in nature,

    As for a command in .cu program the last (terminal) will print first than others. In simple words the statements
    which are lower in parse tree will print first than the statements which are on upper side in parse tree .