/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

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
    ID = 258,
    TYPE = 259,
    INTEGER = 260,
    FLOAT = 261,
    VOID = 262,
    COMMENT = 263,
    STRING = 264,
    STATIC = 265,
    NEW = 266,
    FINAL = 267,
    PUBLIC = 268,
    PROTECTED = 269,
    PRIVATE = 270,
    CLASS = 271,
    RETURN = 272,
    WHILE = 273,
    FOR = 274,
    IF = 275,
    ELSE = 276,
    PRINT = 277,
    READ = 278,
    PLUS = 279,
    MINUS = 280,
    MUL = 281,
    DIV = 282,
    LP = 283,
    RP = 284,
    LB = 285,
    RB = 286,
    LC = 287,
    RC = 288,
    EQ = 289,
    COMMA = 290,
    SMALL = 291,
    BIG = 292,
    SMALLEQ = 293,
    BIGEQ = 294,
    EE = 295,
    NE = 296,
    PP = 297,
    MM = 298,
    POINT = 299,
    NEWLINE = 300,
    END = 301
  };
#endif
/* Tokens.  */
#define ID 258
#define TYPE 259
#define INTEGER 260
#define FLOAT 261
#define VOID 262
#define COMMENT 263
#define STRING 264
#define STATIC 265
#define NEW 266
#define FINAL 267
#define PUBLIC 268
#define PROTECTED 269
#define PRIVATE 270
#define CLASS 271
#define RETURN 272
#define WHILE 273
#define FOR 274
#define IF 275
#define ELSE 276
#define PRINT 277
#define READ 278
#define PLUS 279
#define MINUS 280
#define MUL 281
#define DIV 282
#define LP 283
#define RP 284
#define LB 285
#define RB 286
#define LC 287
#define RC 288
#define EQ 289
#define COMMA 290
#define SMALL 291
#define BIG 292
#define SMALLEQ 293
#define BIGEQ 294
#define EE 295
#define NE 296
#define PP 297
#define MM 298
#define POINT 299
#define NEWLINE 300
#define END 301

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 29 "B062040027.y"

    char* stringVal;

#line 153 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
