%include <std_map.i>

namespace Lucene
{
	template < class KEY, class VALUE, class LESS = std::less<KEY> >
	class Map
	{
	public:
		virtual ~Map();
		void reset();
		int32_t size() const;
		bool empty() const;
		void clear();
		virtual int32_t hashCode();
		void put(const KEY& key, const VALUE& value);
		bool remove(const KEY& key);
		VALUE get(const KEY& key) const;
		bool contains(const KEY& key) const;
  };

template < class KEY, class VALUE, class HASH = boost::hash<KEY>, class EQUAL = std::equal_to<KEY> >
	class HashMap
	{
	public:
		virtual ~HashMap();
		void reset();
		int32_t size() const;
		bool empty() const;
		void clear();
		virtual int32_t hashCode();
		void put(const KEY& key, const VALUE& value);
		bool remove(const KEY& key);
		VALUE get(const KEY& key) const;
		bool contains(const KEY& key) const;
  };
}

%{
  #include "FieldSelector.h"
%}

namespace Lucene {
	typedef Lucene::HashMap< String, double, boost::hash<String>, std::equal_to<String> > MapStringDouble;
	typedef Lucene::HashMap< String, AnalyzerPtr > MapStringAnalyzer;
	typedef Lucene::HashMap< String, TermVectorEntryCollection > MapStringCollectionTermVectorEntry;
	typedef Lucene::HashMap< String, String > MapStringString;
	//typedef Lucene::HashMap< String, FieldSelector > MapStringFieldSelectorResult;
}

%include "localMaps.i"

LUCENE_HASHMAP(MapStringDouble, Lucene::String, double)
LUCENE_HASHMAP(MapStringAnalyzer, Lucene::String, Lucene::AnalyzerPtr)
LUCENE_HASHMAP(MapStringCollectionTermVectorEntry, Lucene::String, Lucene::Collection<Lucene::TermVectorEntryPtr>)
LUCENE_HASHMAP(MapStringString, Lucene::String, Lucene::String)
LUCENE_HASHMAP(MapStringFieldSelectorResult, Lucene::String, Lucene::FieldSelector::FieldSelectorResult)

