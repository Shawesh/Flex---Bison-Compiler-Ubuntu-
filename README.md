# Flex---Bison-Compiler-Ubuntu-
This is a compiler created using  Flex and Bison in Ubuntu environment. see Readme.pdf for specs and instructions. 
Flex-Bison Compiler Features
  ▪ Arithmetic expressions
  ▪ Boolean expressions (if, else, while, true, false)
  ▪ Relational operations
  ▪ Functions and function calls, multi functions.
  ▪ type declaration of variables (Boolean, char, integer, int pointer, char pointer, string)
  ▪ Comments 
Pre-conditions:
  ▪ Bison 3.0.2
  ▪ Cc 4.8.4
  ▪ Flex 2.5.3 
Compile (in order)
  ▪ Create(lex) “lex.yy.c” by running: lex scanner.l
  ▪ Create(bison) “y.tab.c” and “y.tab.h”, run: yacc parser.y -d
  ▪ To compile scanner and parser into a “compiler” run file, run: cc lex.yy.c y.tab.c -o compiler -ll 
Run a Program
  ▪ To compile a program file, run: ./compiler < myProgramFile.c
