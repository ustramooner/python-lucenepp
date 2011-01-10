%include <std_map.i>

%rename (at) Lucene::Collection::operator[](int32_t pos) const;

namespace Lucene
{
	template < class TYPE, class HASH = boost::hash<TYPE>, class EQUAL = std::equal_to<TYPE> >
	class HashSet
	{
	public:
		virtual ~HashSet();
		void reset();
		int32_t size() const;
		bool empty() const;
		void clear();
		virtual int32_t hashCode();
		bool add(const TYPE& type);
		bool remove(const TYPE& type);
		bool contains(const TYPE& type) const;
  };
}

%{
  namespace Lucene {
	  typedef HashSet< Lucene::String > SetString; //SetString isn't defined in Lucene.h
  }
%}

%include "localSets.i"
LUCENE_HASHSET(SetSegmentInfo, Lucene::SegmentInfoPtr)
LUCENE_HASHSET(SetTerm, Lucene::TermPtr)
LUCENE_HASHSET(SetString, Lucene::String)

