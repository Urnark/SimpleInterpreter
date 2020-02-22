%top{
#include "sample.tab.h"
#define YY_DECL yy::parser::symbol_type yylex()
}
%option noyywrap nounput batch noinput

WORD [a-zA-Z][a-zA-Z0-9]*
NUM ([0-9]*)|([0-9]*\.[0-9]+)

BLANK [ \t]
NL [\n\r]

TEXT [^"\\\n]*
%%
{WORD}+                                  { return yy::parser::make_IDENTIFIER(yytext); }
{NUM}+                                   { return yy::parser::make_NUM(std::stod(yytext)); }
{NL}                                     { return yy::parser::make_NEWLINE(yytext); }
{BLANK}+                                 { }

<<EOF>>                                  { return yy::parser::make_ENDOF(); }
%%