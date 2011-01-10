#define LPPAPI


//locale support...
%rename ( Locale ) std::locale;
%extend std::locale {
  std::string __str__(){
    return $self->name();
  }
}

namespace std {
  class locale {
  public:
    locale(const char* name);
    ~locale();
  };
}

%ignore boost::enable_shared_from_this< Lucene::LuceneObject >;
%ignore *::_getClassName();
%ignore *::clone;
%ignore *::testPoint;
%ignore *::shared_from_this();
%ignore *::hashCode();
%ignore *::equals;
%ignore Lucene::LuceneSignal;
%ignore LuceneSignalPtr;
%ignore SynchronizePtr;
%ignore Lucene::LuceneThread;
%ignore Lucene::Synchronize;
%ignore Lucene::LuceneObject::initialize();
%ignore Lucene::LuceneObject::compareTo(LuceneObjectPtr other);
%ignore Lucene::LuceneObject::getSync();
%ignore Lucene::LuceneObject::getSignal();
%ignore Lucene::LuceneObject::lock;
%ignore Lucene::LuceneObject::unlock();
%ignore Lucene::LuceneObject::holdsLock();
%ignore Lucene::LuceneObject::wait;
%ignore Lucene::LuceneObject::notifyAll();

%ignore Lucene::CharArraySet::begin();
%ignore Lucene::CharArraySet::end();
%ignore Lucene::BooleanQuery::begin();
%ignore Lucene::BooleanQuery::end();
%ignore Lucene::DisjunctionMaxQuery::begin();
%ignore Lucene::DisjunctionMaxQuery::end();

%include "LuceneObject.h"

//all char buffers are INOUT... (??)
%apply wchar_t* INOUT {wchar_t* buffer};

