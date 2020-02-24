#include <iostream>
#include "../flex_bison/sample.tab.h"
#include "helper.h"

extern FILE* yyin;
extern twice::Loc* curLoc;

extern int yylex_destroy(void);

void yy::parser::error(const yy::location&loc, std::string const& err)
{
	std::cout << loc.begin.filename->c_str() << "(" << loc.begin.line << "," << loc.begin.column << "): " << "ERROR: " << err << std::endl;
}

int main(int argc, char** argv)
{
	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);

	std::string filename = "test.twi";
	std::string scriptsFolder = "scripts/";
	if (fopen_s(&yyin, (scriptsFolder + filename).c_str(), "r") != 0)
	{
		std::cout << "could not open file [" << scriptsFolder + filename << "]" << std::endl;
	}
	curLoc = new twice::Loc(&filename, scriptsFolder);

	yy::parser parser;
	parser.parse();

	if (yyin)
		fclose(yyin);
	delete curLoc;

	yylex_destroy();
	return 0;
}