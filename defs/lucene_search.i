
%{
#include "Query.h"
#include "Filter.h"
#include "Weight.h"
#include "Similarity.h"
#include "SimilarityDelegator.h"
#include "Scorer.h"
#include "Searchable.h"
#include "Searcher.h"

#include "BooleanClause.h"
#include "BooleanQuery.h"
#include "CachingWrapperFilter.h"
#include "Collector.h"
#include "ComplexExplanation.h"
#include "ConstantScoreQuery.h"
#include "DefaultSimilarity.h"
#include "DisjunctionMaxQuery.h"
#include "DocIdSet.h"
#include "DocIdSetIterator.h"
#include "Explanation.h"
#include "FieldCache.h"
#include "FieldCacheRangeFilter.h"
#include "FieldCacheTermsFilter.h"
#include "FieldComparator.h"
#include "FieldComparatorSource.h"
#include "FieldDoc.h"
#include "FilteredDocIdSet.h"
#include "FilteredDocIdSetIterator.h"
#include "FilteredQuery.h"
#include "FilteredTermEnum.h"
#include "FilterManager.h"
#include "ByteFieldSource.h"
#include "CustomScoreProvider.h"
#include "CustomScoreQuery.h"
#include "DocValues.h"
#include "FieldScoreQuery.h"
#include "IntFieldSource.h"
#include "OrdFieldSource.h"
#include "ReverseOrdFieldSource.h"
#include "ValueSource.h"
#include "ValueSourceQuery.h"
#include "FieldCacheSource.h"
#include "FieldValueHitQueue.h"
#include "FuzzyQuery.h"
#include "FuzzyTermEnum.h"
#include "IndexSearcher.h"
#include "MatchAllDocsQuery.h"
#include "MultiPhraseQuery.h"
#include "MultiSearcher.h"
#include "MultiTermQuery.h"
#include "MultiTermQueryWrapperFilter.h"
#include "NumericRangeFilter.h"
#include "NumericRangeQuery.h"
#include "ParallelMultiSearcher.h"
#include "Payload.h"
#include "PayloadNearQuery.h"
#include "PayloadSpanUtil.h"
#include "PayloadTermQuery.h"
#include "PhraseQuery.h"
#include "PositiveScoresOnlyCollector.h"
#include "PrefixFilter.h"
#include "PrefixQuery.h"
#include "PrefixTermEnum.h"
#include "QueryTermVector.h"
#include "QueryWrapperFilter.h"
#include "ScoreCachingWrappingScorer.h"
#include "ScoreDoc.h"
#include "SingleTermEnum.h"
#include "Sort.h"
#include "SortField.h"
#include "SpanFilter.h"
#include "SpanFilterResult.h"
#include "CachingSpanFilter.h"
#include "SpanQueryFilter.h"
#include "FieldMaskingSpanQuery.h"
#include "NearSpansOrdered.h"
#include "NearSpansUnordered.h"
#include "SpanQuery.h"
#include "SpanFirstQuery.h"
#include "SpanNearQuery.h"
#include "SpanNotQuery.h"
#include "SpanOrQuery.h"
#include "SpanScorer.h"
#include "SpanTermQuery.h"
#include "SpanWeight.h"
#include "TermQuery.h"
#include "TermRangeFilter.h"
#include "TermRangeQuery.h"
#include "TermRangeTermEnum.h"
#include "TimeLimitingCollector.h"
#include "TopDocs.h"
#include "TopDocsCollector.h"
#include "TopFieldCollector.h"
#include "TopFieldDocs.h"
#include "TopScoreDocCollector.h"
#include "WildcardQuery.h"
#include "WildcardTermEnum.h"
#include "PayloadFunction.h"
#include "TermSpans.h"

#include "AveragePayloadFunction.h"
#include "MaxPayloadFunction.h"
#include "MinPayloadFunction.h"

#include "VariantUtils.h"

%}

//not needed
%ignore Lucene::CreationPlaceholder;

//director returning object... needs testing..
%ignore Lucene::Similarity::idfExplain;

//TODO: not sure why these are here?
%ignore Lucene::FieldCache::getBytes;
%ignore Lucene::FieldCache::getLongs;

%feature("notabstract") Lucene::IndexSearcher;
%feature("notabstract") Lucene::MultiSearcher;
%feature("notabstract") Lucene::ParallelMultiSearcher;

//simple FieldComparator declaration
namespace Lucene {
  class FieldComparator {
  protected:
    FieldComparator();
  public:
    ~FieldComparator();
  };
}


%ignore Lucene::TermRangeQuery::TermRangeQuery(const String& fieldName, StringValue lowerTerm, StringValue upperTerm, bool includeLower, bool includeUpper, CollatorPtr collator = CollatorPtr());
%ignore Lucene::TermRangeFilter::TermRangeFilter(const String& fieldName, StringValue lowerTerm, StringValue upperTerm, bool includeLower, bool includeUpper, CollatorPtr collator = CollatorPtr());
%extend Lucene::TermRangeFilter {
  TermRangeFilter(const String& fieldName, const wchar_t* lowerTerm, const wchar_t* upperTerm, bool includeLower, bool includeUpper, CollatorPtr collator = CollatorPtr()){
    StringValue lt;
    StringValue ut;
    if ( lowerTerm == NULL )
      lt = VariantUtils::null();
    else
      lt = String(lowerTerm);
    if ( upperTerm == NULL )
      ut = VariantUtils::null();
    else
      ut = String(upperTerm);
    return new TermRangeFilter(fieldName, lt, ut, includeLower, includeUpper, collator);
  }
}
%extend Lucene::TermRangeQuery {
  TermRangeQuery(const String& fieldName, const wchar_t* lowerTerm, const wchar_t* upperTerm, bool includeLower, bool includeUpper, CollatorPtr collator = CollatorPtr()){
    StringValue lt;
    StringValue ut;
    if ( lowerTerm == NULL )
      lt = VariantUtils::null();
    else
      lt = String(lowerTerm);
    if ( upperTerm == NULL )
      ut = VariantUtils::null();
    else
      ut = String(upperTerm);
    return new TermRangeQuery(fieldName, lt, ut, includeLower, includeUpper, collator);
  }
}

%include "Query.h";
%include "Filter.h";
%include "Weight.h";
%include "Explanation.h";
%include "Similarity.h";
%include "SimilarityDelegator.h";
%include "DocIdSetIterator.h";
%include "Scorer.h";
%include "Searchable.h";
%include "Searcher.h";
%include "SpanWeight.h";
%include "TermQuery.h";
%include "ScoreDoc.h";
%include "MultiTermQuery.h";
%include "ValueSource.h";

%include "BooleanClause.h";
%include "BooleanQuery.h";
%include "CachingWrapperFilter.h";
%include "Collector.h";
%include "ConstantScoreQuery.h";
%include "DefaultSimilarity.h";
%include "DisjunctionMaxQuery.h";
%include "DocIdSet.h";
%include "ComplexExplanation.h";
%include "FieldCacheSource.h";
%include "FieldCache.h";
%include "FieldCacheRangeFilter.h";
%include "FieldCacheTermsFilter.h";
%include "FieldComparatorSource.h";
%include "FieldDoc.h";
%include "FieldValueHitQueue.h";
%include "FilteredDocIdSet.h";
%include "FilteredDocIdSetIterator.h";
%include "FilteredQuery.h";
%include "FilteredTermEnum.h";
%include "FilterManager.h";
%include "ByteFieldSource.h";
%include "CustomScoreProvider.h";
%include "CustomScoreQuery.h";
%include "DocValues.h";
%include "ValueSourceQuery.h";
%include "FieldScoreQuery.h";
%include "IntFieldSource.h";
%include "OrdFieldSource.h";
%include "ReverseOrdFieldSource.h";
%include "FuzzyQuery.h";
%include "FuzzyTermEnum.h";
%include "IndexSearcher.h";
%include "MatchAllDocsQuery.h";
%include "MultiPhraseQuery.h";
%include "MultiSearcher.h";
%include "MultiTermQueryWrapperFilter.h";
%include "NumericRangeFilter.h";
%include "NumericRangeQuery.h";
%include "ParallelMultiSearcher.h";
%include "PhraseQuery.h";
%include "PositiveScoresOnlyCollector.h";
%include "PrefixFilter.h";
%include "PrefixQuery.h";
%include "PrefixTermEnum.h";
%include "QueryTermVector.h";
%include "QueryWrapperFilter.h";
%include "ScoreCachingWrappingScorer.h";
%include "SingleTermEnum.h";
%include "Sort.h";
%include "SortField.h";
%include "Spans.h";
%include "PayloadSpanUtil.h";
%include "SpanFilter.h";
%include "SpanFilterResult.h";
%include "CachingSpanFilter.h";
%include "SpanQueryFilter.h";
%include "SpanQuery.h";
%include "SpanFirstQuery.h";
%include "SpanNearQuery.h";
%include "SpanNotQuery.h";
%include "SpanOrQuery.h";
%include "SpanScorer.h";
%include "SpanTermQuery.h";
%include "FieldMaskingSpanQuery.h";
%include "NearSpansOrdered.h";
%include "NearSpansUnordered.h";
%include "PayloadNearQuery.h";
%include "PayloadTermQuery.h";
%include "PayloadFunction.h";
%include "AveragePayloadFunction.h";
%include "MinPayloadFunction.h";
%include "MaxPayloadFunction.h";
%include "TermRangeFilter.h";
%include "TermRangeQuery.h";
%include "TermRangeTermEnum.h";
%include "TermSpans.h";
%include "TimeLimitingCollector.h";
%include "TopDocs.h";
%include "TopDocsCollector.h";
%include "TopFieldCollector.h";
%include "TopFieldDocs.h";
%include "TopScoreDocCollector.h";
%include "WildcardQuery.h";
%include "WildcardTermEnum.h";

