#include <iostream>
#include "../flex_bison/sample.tab.h"
#include "../flex_bison/location.hh"

extern FILE* yyin;
extern yy::location location;

void yy::parser::error(const yy::location&loc, std::string const& err)
{
	std::cout << loc.begin.filename->c_str() << "(" << loc.begin.line << "," << loc.begin.column << "): " << "ERROR: " << err << std::endl;
}

int main()
{
	std::string filename = "test.twi";
	std::string scriptsFolder = "scripts/";
	if (fopen_s(&yyin, (scriptsFolder + filename).c_str(), "r") != 0)
	{
		std::cout << "could not open file [" << scriptsFolder + filename << "]" << std::endl;
	}
	location.initialize(&filename);

	yy::parser parser;
	parser.parse();

	if (yyin)
		fclose(yyin);

	return 0;
}