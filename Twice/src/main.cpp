#include <iostream>
#include "../flex_bison/sample.tab.h"
#include "helper.h"

extern FILE* yyin;
extern twice::Loc* curLoc;

void yy::parser::error(const yy::location&loc, std::string const& err)
{
	std::cout << loc.begin.filename->c_str() << "(" << loc.begin.line << "," << loc.begin.column << "): " << "ERROR: " << err << std::endl;
}

int main(int argc, char** argv)
{
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

	return 0;
}