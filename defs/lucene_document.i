%nspace document;

//use int64_t for ptime instead...
%ignore Lucene::DateTools::round(const boost::posix_time::ptime& date, Resolution resolution);
%ignore Lucene::DateTools::dateToString;
%ignore Lucene::DateTools::stringToDate;
%ignore Lucene::DateTools::parseDate;
%ignore Lucene::DateField::dateToString;

//not necessary?
%ignore Lucene::CompressionTools;
%ignore Lucene::DateField::DateField;
%ignore Lucene::DateTools::DateTools;

%include "local_document.i"

%{
	#include "FieldSelector.h"
	#include "MapFieldSelector.h"
	#include "SetBasedFieldSelector.h"
	#include "LoadFirstFieldSelector.h"
%}

//now include the headers
%include "Fieldable.h";
%include "AbstractField.h";
%include "Field.h";
%include "DateField.h";
%include "DateTools.h";
%include "Document.h";
%include "FieldSelector.h";
%include "LoadFirstFieldSelector.h";
%include "MapFieldSelector.h";
%include "NumberTools.h";
%include "NumericField.h";
%include "SetBasedFieldSelector.h";

