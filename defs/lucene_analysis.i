%nspace analysis;

//problem with swig...
%ignore Lucene::AcceptAllSinkFilter;

%{
	#include "ASCIIFoldingFilter.h"
	#include "CharArraySet.h"
	#include "TokenStream.h"
	#include "Token.h"
	#include "TokenFilter.h"
	#include "Tokenizer.h"
	#include "Analyzer.h"
	#include "CharStream.h"
	#include "CharFilter.h"
	#include "CharReader.h"
	#include "CharTokenizer.h"
	#include "BaseCharFilter.h"
	#include "FlagsAttribute.h"
	#include "ISOLatin1AccentFilter.h"
	#include "KeywordAnalyzer.h"
	#include "KeywordTokenizer.h"
	#include "LengthFilter.h"
	#include "LetterTokenizer.h"
	#include "LowerCaseFilter.h"
	#include "LowerCaseTokenizer.h"
	#include "MappingCharFilter.h"
	#include "NormalizeCharMap.h"
	#include "NumericTokenStream.h"
	#include "OffsetAttribute.h"
	#include "PayloadAttribute.h"
	#include "CachingTokenFilter.h"
	#include "PerFieldAnalyzerWrapper.h"
	#include "PositionIncrementAttribute.h"	
	#include "SimpleAnalyzer.h"
	#include "StandardAnalyzer.h"
	#include "StandardFilter.h"
	#include "StandardTokenizer.h"
	#include "StopAnalyzer.h"
	#include "StopFilter.h"
	#include "TeeSinkTokenFilter.h"
	#include "TermAttribute.h"
	#include "TypeAttribute.h"
	#include "WhitespaceAnalyzer.h"
	#include "WhitespaceTokenizer.h"
	#include "WordlistLoader.h"
%}

%ignore Lucene::Token::termBufferArray;

//now include the headers
%include "TokenStream.h";
%include "Token.h";
%include "TokenFilter.h";
%include "Tokenizer.h";
%include "Analyzer.h";
%include "ASCIIFoldingFilter.h";
%include "CharStream.h";
%include "CharArraySet.h";
%include "CharFilter.h";
%include "CharReader.h";
%include "CharTokenizer.h";
%include "BaseCharFilter.h";
%include "FlagsAttribute.h";
%include "CachingTokenFilter.h";
%include "ISOLatin1AccentFilter.h";
%include "KeywordAnalyzer.h";
%include "KeywordTokenizer.h";
%include "LengthFilter.h";
%include "LetterTokenizer.h";
%include "LowerCaseFilter.h";
%include "LowerCaseTokenizer.h";
%include "MappingCharFilter.h";
%include "NormalizeCharMap.h";
%include "NumericTokenStream.h";
%include "OffsetAttribute.h";
%include "PayloadAttribute.h";
%include "PerFieldAnalyzerWrapper.h";
%include "PositionIncrementAttribute.h";	
%include "SimpleAnalyzer.h";	
%include "StandardAnalyzer.h";
%include "StandardFilter.h";
%include "StandardTokenizer.h";
%include "StopAnalyzer.h";
%include "StopFilter.h";
%include "TeeSinkTokenFilter.h";
%include "TermAttribute.h";
%include "TypeAttribute.h";
%include "WhitespaceAnalyzer.h";
%include "WhitespaceTokenizer.h";
%include "WordlistLoader.h";

