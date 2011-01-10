%{
  #include "StringReader.h"
  #include "CycleCheck.h"
%}

#if 0
  //director
  %include "Collector.h";
  
  void collect(Lucene::CollectorPtr coll);
  %{
  void collect(Lucene::CollectorPtr coll){
    printf("coll=%p\n", coll.get());
    printf("str=%S\n", coll->toString().c_str());
  
    coll->collect(1);
  }
  %}

#endif

#if 1
  %include "Reader.h";
  %include "StringReader.h";
  
  %inline{
    void cast2(Lucene::LuceneObjectPtr obj){
      printf("%p\n", obj.get());
    }
    void cast1(PyObject* obj){
      LuceneObjectPtr from = ToLuceneObjectPtr(obj);
      if ( !from ){
        PyErr_SetString(PyExc_RuntimeError, "argument is not a LuceneObject");
        return;
      }
      
      printf("%p\n", from.get());
    }
  }
#endif

#if 0

void test(std::locale l);
void test2(const std::locale& l);

%{
  void test(std::locale l){
    printf("locale=%s\n", l.name().c_str());
  }
  void test2(const std::locale& l){
    printf("locale2=%s\n", l.name().c_str());
  }
%}

#endif


#if 0
  %include LuceneCollections.i
  %include LuceneSets.i

  #TODO: implement more of these...
  COLLECTION_BI_IN_TYPEMAP(String, PyString_Check, SWIG_AsPtr_Lucene_String, AsStringCollection)
  COLLECTION_IN_TYPEMAP(std::locale, AsLocaleCollection)
  
  Lucene::String test1();
  Lucene::String& test2();
  const Lucene::String& test3();
  void test4(Lucene::Collection<String>& ss);
  void test5(Lucene::Collection<std::locale >& ss);
  
  %{
    void test4(Lucene::Collection<String>& ss){
      for ( Lucene::Collection<String>::iterator itr = ss.begin();
            itr != ss.end(); itr++ ){
        printf("%S\n", (*itr).c_str());
      }
    }
    void test5(Lucene::Collection<std::locale >& ss){
      for ( Lucene::Collection<std::locale >::iterator itr = ss.begin();
            itr != ss.end(); itr++ ){
        printf("locale: %s\n", (*itr).name().c_str());
      }
    }
    
    Lucene::String test1(){
      return Lucene::String(L"test1");
    }
    Lucene::String& test2(){
      static Lucene::String r = Lucene::String(L"test2");
      return r;
    }
    const Lucene::String& test3(){
      static Lucene::String r = Lucene::String(L"test3");
      return r;
    }
  %}
#endif


#if 0

  //director
  %include "StringReader.h";
  %include "TokenStream.h";
  %include "Analyzer.h";
  %include "WhitespaceAnalyzer.h";
  
  void setAnalyzer(Lucene::AnalyzerPtr ana);
  void tokenise();
  void close(Lucene::AnalyzerPtr ana);
  

  %{
  static AnalyzerPtr ana;
  void setAnalyzer(Lucene::AnalyzerPtr an){
    ana = an;
  }
  void tokenise(){
    printf("analyzer.count=%d\n", ana.use_count());
    TokenStreamPtr ts = ana->reusableTokenStream(L"", newLucene<StringReader>(L"some words for you"));
    printf("%p\n", ts.get());
    while ( ts->incrementToken() ){
      printf("next..\n");    
    }
  }
  void close(Lucene::AnalyzerPtr a){
    printf("close: a=%d\n", a ? a.use_count() : -1);
    printf("close: anacount=%d\n", ana ? ana.use_count() : -1);
    ana.reset();
    CycleCheck::dumpRefs();
    /*if ( director_PyObject_Map.size() > 0 ){
      printf("%d un-reclaimed director objects!\n", director_PyObject_Map.size() );
      for ( std::map<void*, PyObject*>::iterator itr = director_PyObject_Map.begin(); itr != director_PyObject_Map.end(); itr++ ){
        printf("%S: %ld\n", ((LuceneObject*)itr->first)->toString().c_str(), itr->second->ob_refcnt);
      }
    }*/
  }
  %}

#endif
