/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

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
    PROGRAM = 258,
    PBEGIN = 259,
    VAR = 260,
    ARRAY = 261,
    OF = 262,
    ASSIGNMENT = 263,
    END = 264,
    AND = 265,
    OR = 266,
    NOT = 267,
    COLON = 268,
    WHILE = 269,
    DO = 270,
    IF = 271,
    THEN = 272,
    ELSE = 273,
    INTEGER = 274,
    BOOLEAN = 275,
    NEW = 276,
    EQUAL = 277,
    NOTEQUAL = 278,
    GE = 279,
    GT = 280,
    LE = 281,
    LT = 282,
    LBRAC = 283,
    RBRAC = 284,
    LPAREN = 285,
    RPAREN = 286,
    FUNCTION = 287,
    PROCEDURE = 288,
    DIGSEQ = 289,
    REALNUMBER = 290,
    PLUS = 291,
    MINUS = 292,
    MUL = 293,
    DIV = 294,
    IDENTIFIER = 295,
    SEMICOLON = 296,
    DOT = 297,
    COMMA = 298
  };
#endif
/* Tokens.  */
#define PROGRAM 258
#define PBEGIN 259
#define VAR 260
#define ARRAY 261
#define OF 262
#define ASSIGNMENT 263
#define END 264
#define AND 265
#define OR 266
#define NOT 267
#define COLON 268
#define WHILE 269
#define DO 270
#define IF 271
#define THEN 272
#define ELSE 273
#define INTEGER 274
#define BOOLEAN 275
#define NEW 276
#define EQUAL 277
#define NOTEQUAL 278
#define GE 279
#define GT 280
#define LE 281
#define LT 282
#define LBRAC 283
#define RBRAC 284
#define LPAREN 285
#define RPAREN 286
#define FUNCTION 287
#define PROCEDURE 288
#define DIGSEQ 289
#define REALNUMBER 290
#define PLUS 291
#define MINUS 292
#define MUL 293
#define DIV 294
#define IDENTIFIER 295
#define SEMICOLON 296
#define DOT 297
#define COMMA 298

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 28 "src/yacc.y" /* yacc.c:1909  */

    char* str;

#line 144 "y.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
