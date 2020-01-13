/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    CHARACTER = 258,
    STRING = 259,
    LP = 260,
    RP = 261,
    LB = 262,
    RB = 263,
    LC = 264,
    RC = 265,
    ABS = 266,
    COLON = 267,
    SEMI = 268,
    COMMA = 269,
    DOT = 270,
    S_QUOTE = 271,
    D_QUOTE = 272,
    ADDRESS = 273,
    DEREFERENCE = 274,
    ASSIGN = 275,
    PLUS_OP = 276,
    MINUS_OP = 277,
    MULTIPLY_OP = 278,
    DIV_OP = 279,
    MOD_OP = 280,
    NOT_OP = 281,
    LT_OP = 282,
    GT_OP = 283,
    LE_OP = 284,
    GE_OP = 285,
    EQ_OP = 286,
    NE_OP = 287,
    AND_OP = 288,
    OR_OP = 289,
    IF = 290,
    ELSE = 291,
    WHILE = 292,
    BOOL_TRUE = 293,
    BOOL_FALSE = 294,
    VAR = 295,
    FUNCTION = 296,
    RETURN = 297,
    NULL_PTR = 298,
    TYPE = 299,
    TYPE_STRING = 300,
    INTEGER = 301,
    IDENTIFIER = 302,
    NEG = 303
  };
#endif
/* Tokens.  */
#define CHARACTER 258
#define STRING 259
#define LP 260
#define RP 261
#define LB 262
#define RB 263
#define LC 264
#define RC 265
#define ABS 266
#define COLON 267
#define SEMI 268
#define COMMA 269
#define DOT 270
#define S_QUOTE 271
#define D_QUOTE 272
#define ADDRESS 273
#define DEREFERENCE 274
#define ASSIGN 275
#define PLUS_OP 276
#define MINUS_OP 277
#define MULTIPLY_OP 278
#define DIV_OP 279
#define MOD_OP 280
#define NOT_OP 281
#define LT_OP 282
#define GT_OP 283
#define LE_OP 284
#define GE_OP 285
#define EQ_OP 286
#define NE_OP 287
#define AND_OP 288
#define OR_OP 289
#define IF 290
#define ELSE 291
#define WHILE 292
#define BOOL_TRUE 293
#define BOOL_FALSE 294
#define VAR 295
#define FUNCTION 296
#define RETURN 297
#define NULL_PTR 298
#define TYPE 299
#define TYPE_STRING 300
#define INTEGER 301
#define IDENTIFIER 302
#define NEG 303

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 26 "parser.y" /* yacc.c:1909  */

  char* string;
  struct TreeNode* TreeNode;

#line 155 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
