%{
	// index
	#include "Term.h"
	#include "TermEnum.h"
	#include "TermDocs.h"
	#include "TermFreqVector.h"
	#include "TermPositions.h"
	#include "TermPositionVector.h"
	#include "TermVectorEntry.h"
	#include "TermVectorEntryFreqSortedComparator.h"
	#include "TermVectorMapper.h"
	#include "IndexCommit.h"
	#include "IndexReader.h"
	#include "FilterIndexReader.h"
	#include "SegmentInfo.h"
	#include "SegmentInfos.h"
	#include "SegmentReader.h"
	#include "ParallelReader.h"
	#include "TermVectorOffsetInfo.h"
	#include "AbstractAllTermDocs.h"
	#include "FieldInvertState.h"
	#include "FieldSortedTermVectorMapper.h"
	#include "IndexDeletionPolicy.h"
	#include "IndexFileNameFilter.h"
	#include "IndexWriter.h"
	#include "KeepOnlyLastCommitDeletionPolicy.h"
	#include "LogByteSizeMergePolicy.h"
	#include "LogDocMergePolicy.h"
	#include "LogMergePolicy.h"
	#include "MergePolicy.h"
	#include "MergeScheduler.h"
	#include "MultipleTermPositions.h"
	#include "MultiReader.h"
	#include "Payload.h"
	#include "PositionBasedTermVectorMapper.h"
	#include "SerialMergeScheduler.h"
	#include "ConcurrentMergeScheduler.h"
	#include "SnapshotDeletionPolicy.h"
	#include "SortedTermVectorMapper.h"

	#include "CheckIndex.h"

%}

%feature("notabstract") Lucene::SegmentReader;

//TODO: this is actually needed...
%ignore Lucene::TermVectorsPositionInfo;
%ignore Lucene::PositionBasedTermVectorMapper::getFieldToTerms();
%ignore Lucene::MergePolicy::findMergesForOptimize;
%ignore Lucene::Query::extractTerms;
%ignore Lucene::SortedTermVectorMapper::ALL;

//not going to expose:
%ignore Lucene::FindSegmentsFile;
%ignore Lucene::FilterTermDocs;
%ignore Lucene::FilterTermEnum;
%ignore Lucene::FilterTermPositions;
%ignore Lucene::FilterIndexReader;
%ignore Lucene::SegmentInfo::SegmentInfo;
%ignore Lucene::SegmentInfo::write;
%ignore Lucene::TopDocs::TopDocs;

//these are abstract:
%ignore Lucene::TermFreqVector::TermFreqVector;
%ignore Lucene::TermPositionVector::TermPositionVector;

//these are sumo options:
%ignore Lucene::MergeScheduler::close;
%ignore Lucene::MergeScheduler::merge;

// index
%include "Term.h";
%include "TermEnum.h";
%include "TermDocs.h";
%include "TermFreqVector.h";
%include "TermPositions.h";
%include "TermPositionVector.h";
%include "TermVectorEntry.h";
%include "TermVectorEntryFreqSortedComparator.h";
%include "TermVectorMapper.h";
%include "IndexCommit.h";
%include "IndexReader.h";
%include "FilterIndexReader.h";
%include "ParallelReader.h";
%include "SegmentInfo.h";
%include "SegmentInfoCollection.h";
%include "SegmentInfos.h";
%include "SegmentReader.h";
%include "MultipleTermPositions.h";
%include "TermVectorOffsetInfo.h";
%include "AbstractAllTermDocs.h";
%include "FieldInvertState.h";
%include "FieldSortedTermVectorMapper.h";
%include "IndexDeletionPolicy.h";
%include "IndexFileNameFilter.h";
%include "IndexWriter.h";
%include "KeepOnlyLastCommitDeletionPolicy.h";
%include "MergePolicy.h";
%include "LogMergePolicy.h";
%include "LogByteSizeMergePolicy.h";
%include "LogDocMergePolicy.h";
%include "MergeScheduler.h";
%include "MultiReader.h";
%include "Payload.h";
%include "PositionBasedTermVectorMapper.h";
%include "SerialMergeScheduler.h";
%include "ConcurrentMergeScheduler.h";
%include "SnapshotDeletionPolicy.h";
%include "SortedTermVectorMapper.h";
%include "CheckIndex.h";

