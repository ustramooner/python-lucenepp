%{
  #include "QueryParserCharStream.h"
  #include "QueryParserToken.h"
  #include "QueryParserTokenManager.h"
  #include "FastCharStream.h"
%}

//TODO: naming is wrong here..
//%ignore Lucene::QueryParserCharStream;
//%ignore Lucene::QueryParserToken;

%ignore Lucene::QueryParser::analyzer;
%ignore Lucene::QueryParser::field;
%ignore Lucene::QueryParser::fuzzyMinSim;
%ignore Lucene::QueryParser::fuzzyPrefixLength;
%ignore Lucene::QueryParser::phraseSlop;
%ignore Lucene::QueryParser::allowLeadingWildcard;
%ignore Lucene::QueryParser::enablePositionIncrements;
%ignore Lucene::QueryParser::lowercaseExpandedTerms;
%ignore Lucene::QueryParser::multiTermRewriteMethod;
%ignore Lucene::QueryParser::locale;
%ignore Lucene::QueryParser::dateResolution;
%ignore Lucene::QueryParser::rangeCollator;
%ignore Lucene::QueryParser::fieldToDateResolution;
%ignore Lucene::QueryParserTokenManager::debugStream;
%ignore Lucene::QueryParser::getBooleanQuery(Collection<BooleanClausePtr> clauses); //use the disableCoord overload...
//TODO: problem with compiling this...
//%ignore Lucene::MultiFieldQueryParser::MultiFieldQueryParser(Lucene::LuceneVersion::Version matchVersion, Lucene::Collection<String> fields, Lucene::AnalyzerPtr analyzer, MapStringDouble boosts);

%include "QueryParserCharStream.h";
%include "FastCharStream.h";
%include "QueryParserConstants.h";
%include "QueryParser.h";
%include "QueryParserToken.h";
%include "QueryParserTokenManager.h";
%include "MultiFieldQueryParser.h";

