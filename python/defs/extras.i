%pythoncode %{

##########################
# extra compatibility code to make things more familiar...
##########################
import datetime, time

def IndexWriterMaxFieldLength(val):
  return val
IndexWriterMaxFieldLength.LIMITED = IndexWriter.MaxFieldLengthLIMITED
IndexWriterMaxFieldLength.UNLIMITED = IndexWriter.MaxFieldLengthUNLIMITED
IndexWriter.MaxFieldLength = staticmethod(IndexWriterMaxFieldLength)

class AbstractFieldStore():
  YES = AbstractField.STORE_YES
  NO = AbstractField.STORE_NO
AbstractField.Store = AbstractFieldStore
  
class AbstractFieldIndex():
  NO = AbstractField.INDEX_NO
  ANALYZED = AbstractField.INDEX_ANALYZED
  NOT_ANALYZED = AbstractField.INDEX_NOT_ANALYZED
  NOT_ANALYZED_NO_NORMS = AbstractField.INDEX_NOT_ANALYZED_NO_NORMS
  ANALYZED_NO_NORMS = AbstractField.INDEX_ANALYZED_NO_NORMS
AbstractField.Index = AbstractFieldIndex
    
class AbstractFieldTermVector():
  NO = AbstractField.TERM_VECTOR_NO
  YES = AbstractField.TERM_VECTOR_YES
  WITH_POSITIONS = AbstractField.TERM_VECTOR_WITH_POSITIONS
  WITH_OFFSETS = AbstractField.TERM_VECTOR_WITH_OFFSETS
  WITH_POSITIONS_OFFSETS = AbstractField.TERM_VECTOR_WITH_POSITIONS_OFFSETS
AbstractField.TermVector = AbstractFieldTermVector

class BooleanClauseOccur():
  MUST = BooleanClause.MUST
  SHOULD =BooleanClause.SHOULD
  MUST_NOT = BooleanClause.MUST_NOT
BooleanClause.Occur = BooleanClauseOccur

class IndexReaderFieldOption():
  ALL = IndexReader.FIELD_OPTION_ALL
  INDEXED = IndexReader.FIELD_OPTION_INDEXED
  STORES_PAYLOADS = IndexReader.FIELD_OPTION_STORES_PAYLOADS
  OMIT_TERM_FREQ_AND_POSITIONS = IndexReader.FIELD_OPTION_OMIT_TERM_FREQ_AND_POSITIONS
  UNINDEXED = IndexReader.FIELD_OPTION_UNINDEXED
  INDEXED_WITH_TERMVECTOR = IndexReader.FIELD_OPTION_INDEXED_WITH_TERMVECTOR
  INDEXED_NO_TERMVECTOR = IndexReader.FIELD_OPTION_INDEXED_NO_TERMVECTOR
  TERMVECTOR = IndexReader.FIELD_OPTION_TERMVECTOR
  TERMVECTOR_WITH_POSITION = IndexReader.FIELD_OPTION_TERMVECTOR_WITH_POSITION
  TERMVECTOR_WITH_OFFSET = IndexReader.FIELD_OPTION_TERMVECTOR_WITH_OFFSET
  TERMVECTOR_WITH_POSITION_OFFSET = IndexReader.FIELD_OPTION_TERMVECTOR_WITH_POSITION_OFFSET
IndexReader.FieldOption = IndexReaderFieldOption

class QueryParserOperator():
  OR = QueryParser.OR_OPERATOR
  AND = QueryParser.AND_OPERATOR
QueryParser.Operator = QueryParserOperator
def DateTools_dateToString(date, resolution):
  return DateTools.timeToString(int(time.mktime(date.timetuple())), resolution)
DateTools.dateToString = staticmethod(DateTools_dateToString)
def DateTools_stringToDate(string, resolution):
  return datetime.datetime.fromtimestamp(DateTools.stringToTime(string, resolution) / 1000)
DateTools.stringToDate = staticmethod(DateTools_stringToDate)

def DateField_dateToString(date):
  return DateField.timeToString(int(time.mktime(date.timetuple())))
DateField.dateToString = staticmethod(DateField_dateToString)
def DateField_stringToDate(string):
  return datetime.datetime.fromtimestamp(DateField.stringToTime(string) / 1000)
DateField.stringToDate = staticmethod(DateField_stringToDate)

#convert property accessors into real properties
class MakeStaticProperty (property):
    def __get__(self, *args):
      return self.fget()
AttributeFactory.DEFAULT_ATTRIBUTE_FACTORY = MakeStaticProperty(_lucenepp.AttributeFactory_DEFAULT_ATTRIBUTE_FACTORY)
DateField.MIN_DATE_STRING = MakeStaticProperty(_lucenepp.DateField_MIN_DATE_STRING)
DateField.MAX_DATE_STRING = MakeStaticProperty(_lucenepp.DateField_MAX_DATE_STRING)
Token.DEFAULT_TYPE = MakeStaticProperty(_lucenepp.Token_DEFAULT_TYPE)
Token.TOKEN_ATTRIBUTE_FACTORY = MakeStaticProperty(_lucenepp.Token_TOKEN_ATTRIBUTE_FACTORY)
StandardTokenizer.TOKEN_TYPES = MakeStaticProperty(_lucenepp.StandardTokenizer_TOKEN_TYPES)
StopAnalyzer.ENGLISH_STOP_WORDS_SET = MakeStaticProperty(_lucenepp.StopAnalyzer_ENGLISH_STOP_WORDS_SET)
TermVectorOffsetInfo.EMPTY_OFFSET_INFO = MakeStaticProperty(_lucenepp.TermVectorOffsetInfo_EMPTY_OFFSET_INFO)
IndexWriter.MAX_TERM_LENGTH = MakeStaticProperty(_lucenepp.IndexWriter_MAX_TERM_LENGTH)
MultiTermQuery.CONSTANT_SCORE_FILTER_REWRITE = MakeStaticProperty(_lucenepp.MultiTermQuery_CONSTANT_SCORE_FILTER_REWRITE)
MultiTermQuery.SCORING_BOOLEAN_QUERY_REWRITE = MakeStaticProperty(_lucenepp.MultiTermQuery_SCORING_BOOLEAN_QUERY_REWRITE)
MultiTermQuery.CONSTANT_SCORE_BOOLEAN_QUERY_REWRITE = MakeStaticProperty(_lucenepp.MultiTermQuery_CONSTANT_SCORE_BOOLEAN_QUERY_REWRITE)
MultiTermQuery.CONSTANT_SCORE_AUTO_REWRITE_DEFAULT = MakeStaticProperty(_lucenepp.MultiTermQuery_CONSTANT_SCORE_AUTO_REWRITE_DEFAULT)
DocIdSet.EMPTY_DOCIDSET = MakeStaticProperty(_lucenepp.DocIdSet_EMPTY_DOCIDSET)
FieldCache.DEFAULT = MakeStaticProperty(_lucenepp.FieldCache_DEFAULT)
FieldCache.DEFAULT_BYTE_PARSER = MakeStaticProperty(_lucenepp.FieldCache_DEFAULT_BYTE_PARSER)
FieldCache.DEFAULT_INT_PARSER = MakeStaticProperty(_lucenepp.FieldCache_DEFAULT_INT_PARSER)
FieldCache.DEFAULT_LONG_PARSER = MakeStaticProperty(_lucenepp.FieldCache_DEFAULT_LONG_PARSER)
FieldCache.DEFAULT_DOUBLE_PARSER = MakeStaticProperty(_lucenepp.FieldCache_DEFAULT_DOUBLE_PARSER)
FieldCache.NUMERIC_UTILS_INT_PARSER = MakeStaticProperty(_lucenepp.FieldCache_NUMERIC_UTILS_INT_PARSER)
FieldCache.NUMERIC_UTILS_LONG_PARSER = MakeStaticProperty(_lucenepp.FieldCache_NUMERIC_UTILS_LONG_PARSER)
FieldCache.NUMERIC_UTILS_DOUBLE_PARSER = MakeStaticProperty(_lucenepp.FieldCache_NUMERIC_UTILS_DOUBLE_PARSER)
Sort.RELEVANCE = MakeStaticProperty(_lucenepp.Sort_RELEVANCE)
Sort.INDEXORDER = MakeStaticProperty(_lucenepp.Sort_INDEXORDER)
SortField.FIELD_SCORE = MakeStaticProperty(_lucenepp.SortField_FIELD_SCORE)
SortField.FIELD_DOC = MakeStaticProperty(_lucenepp.SortField_FIELD_DOC)

#dummy code to help PyLucene coders
def initVM():
  pass

def File(path):
  return path
%}


