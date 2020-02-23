%top{
#include "sample.tab.h"
#include "location.hh"
#include <string>
#define YY_DECL yy::parser::symbol_type yylex()

yy::location location;

const yy::location& next_column(int count = 1);
const yy::location& next_line(int count = 1);

void flex_error(const yy::location& loc, const std::string& text);
}

%option noyywrap nounput batch noinput

WORD [a-zA-Z][a-zA-Z0-9]*
NUM ([0-9]*)|([0-9]*\.[0-9]+)

BLANK [ \t]
NL [\n\r]

TEXT [^"\\\n]*
%%

{WORD}+                                  { return yy::parser::make_IDENTIFIER(yytext, next_column(yyleng)); }
{NUM}+                                   { return yy::parser::make_NUM(std::stod(yytext), next_column(yyleng)); }
{NL}                                     { return yy::parser::make_NEWLINE(yytext, next_line()); }
{BLANK}+                                 { next_column(yyleng); }

.                                        { next_column(yyleng); flex_error(location, yytext); }
<<EOF>>                                  { return yy::parser::make_ENDOF(next_line()); }
%%

const yy::location& next_column(int count)
{
    location.step();
    location.columns(count);
    return location;
}

const yy::location& next_line(int count)
{
    location.step();
    location.lines(count);
    return location;
}

void flex_error(const yy::location& loc, const std::string& text)
{
	std::cout << loc.begin.filename->c_str() << "(" << loc.begin.line << "," << loc.begin.column << "): " << "ERROR: Unrecognized character '" << text << "'" << std::endl;
}