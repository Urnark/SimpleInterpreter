#include "helper.h"

twice::Loc::Loc()
{
}

twice::Loc::Loc(std::string* filename, const std::string& filepath)
{
	initialize(filename);
	this->_filepath = filepath;
}

int twice::Loc::bline() const
{
	return this->begin.line;
}

int twice::Loc::bcolumn() const
{
	return this->begin.line;
}

int twice::Loc::eline() const
{
	return this->end.line;
}

int twice::Loc::ecolumn() const
{
	return this->end.line;
}

std::string twice::Loc::filename() const
{
	return *this->begin.filename;
}

std::string twice::Loc::filepath() const
{
	return _filepath;
}

std::ostream& twice::operator<<(std::ostream& stream, const twice::Loc& loc)
{
	stream << loc.filepath() + loc.filename() << "(" << loc.bline() << ", " << loc.bcolumn() << ")";
	return stream;
}
