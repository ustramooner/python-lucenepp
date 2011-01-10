%include <std_vector.i>

%rename (get) Lucene::Collection::operator[](int32_t pos) const;

namespace Lucene
{
	/// Utility template class to handle collections that can be safely copied and shared
	template <class TYPE>
	class Collection
	{
	public:
		typedef Collection<TYPE> this_type;
		typedef boost::shared_ptr<this_type> shared_ptr;
		typedef std::vector< TYPE, Allocator<TYPE> > collection_type;
		
		virtual ~Collection();

		void clear();
		bool contains(const TYPE& type) const;
		bool equals(const this_type& other) const;
		virtual int32_t hashCode();
		bool empty() const;
		void remove(const TYPE& type);
		int32_t size() const;
  };
}

%include "localCollections.i"


LUCENE_COLLECTION(DoubleCollection, Double, double)
LUCENE_COLLECTION(ByteCollection, Byte,  uint8_t )
LUCENE_COLLECTION(IntCollection, Integer,  int32_t )
LUCENE_COLLECTION(LongCollection, Long,  int64_t )
LUCENE_COLLECTION(StringCollection, String, Lucene::String)

LUCENE_COLLECTION(InsanityCollection, Insanity, Lucene::InsanityPtr)
LUCENE_COLLECTION(FieldCollection, Field, Lucene::FieldPtr)
LUCENE_COLLECTION(FieldableCollection, Fieldable, Lucene::FieldablePtr)
LUCENE_COLLECTION(AttributeCollection, Attribute, Lucene::AttributePtr)
LUCENE_COLLECTION(BooleanClauseCollection, BooleanClause, Lucene::BooleanClausePtr)
LUCENE_COLLECTION(BooleanQueryCollection, BooleanQuery, Lucene::BooleanQueryPtr)
LUCENE_COLLECTION(DirectoryCollection, Directory, Lucene::DirectoryPtr)
LUCENE_COLLECTION(ExplanationCollection, Explanation, Lucene::ExplanationPtr)
LUCENE_COLLECTION(FieldCacheEntryCollection, FieldCacheEntry, Lucene::FieldCacheEntryPtr)
LUCENE_COLLECTION(FieldComparatorCollection, FieldComparator, Lucene::FieldComparatorPtr)
LUCENE_COLLECTION(IndexCommitCollection, IndexCommit, Lucene::IndexCommitPtr)
LUCENE_COLLECTION(IndexReaderCollection, IndexReader, Lucene::IndexReaderPtr)
LUCENE_COLLECTION(OneMergeCollection, OneMerge, Lucene::OneMergePtr)
LUCENE_COLLECTION(PositionInfoCollection, PositionInfo, Lucene::PositionInfoPtr)
LUCENE_COLLECTION(QueryCollection, Query, Lucene::QueryPtr)
LUCENE_COLLECTION(ScoreDocCollection, ScoreDoc, Lucene::ScoreDocPtr)
LUCENE_COLLECTION(SearchableCollection, Searchable, Lucene::SearchablePtr)
LUCENE_COLLECTION(SegmentInfoStatusCollection, SegmentInfoStatus, Lucene::SegmentInfoStatusPtr)
LUCENE_COLLECTION(SegmentReaderCollection, SegmentReader, Lucene::SegmentReaderPtr)
LUCENE_COLLECTION(SortFieldCollection, SortField, Lucene::SortFieldPtr)
LUCENE_COLLECTION(SpanQueryCollection, SpanQuery, Lucene::SpanQueryPtr)
LUCENE_COLLECTION(SpansCollection, Spans, Lucene::SpansPtr)
LUCENE_COLLECTION(StartEndCollection, StartEnd, Lucene::StartEndPtr)
LUCENE_COLLECTION(TermFreqVectorCollection, TermFreqVector, Lucene::TermFreqVectorPtr)
LUCENE_COLLECTION(TermVectorEntryCollection, TermVectorEntry, Lucene::TermVectorEntryPtr)
LUCENE_COLLECTION(TermVectorOffsetInfoCollection, TermVectorOffsetInfo, Lucene::TermVectorOffsetInfoPtr)
LUCENE_COLLECTION(ValueSourceQueryCollection, ValueSourceQuery, Lucene::ValueSourceQueryPtr)
LUCENE_COLLECTION(BooleanClauseOccurCollection, BooleanClause.Occur, Lucene::BooleanClause::Occur)
LUCENE_COLLECTION(TermCollection, Term,  Lucene::TermPtr )


