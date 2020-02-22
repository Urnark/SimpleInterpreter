%top{
#include "sample.tab.h"
#include "location.hh"
#define YY_DECL yy::parser::symbol_type yylex()
}
%option noyywrap nounput batch noinput yylineno

WORD [a-zA-Z][a-zA-Z0-9]*
NUM ([0-9]*)|([0-9]*\.[0-9]+)

BLANK [ \t]
NL [\n\r]

TEXT [^"\\\n]*
%%
{WORD}+                                  { return yy::parser::make_IDENTIFIER(yytext, yy::location()); }
{NUM}+                                   { return yy::parser::make_NUM(std::stod(yytext), yy::location()); }
{NL}                                     { return yy::parser::make_NEWLINE(yytext, yy::location()); }
{BLANK}+                                 { }

<<EOF>>                                  { return yy::parser::make_ENDOF(yy::location()); }
%%