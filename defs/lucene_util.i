%include "local_util.i"

%{
	#include "BitVector.h"
	#include "Collator.h"
  #include "NumericUtils.h"
  #include "CycleCheck.h"
  #include "StringReader.h"
  #include "FieldCacheSanityChecker.h"
%}

%ignore Lucene::DefaultAttributeFactory;
%ignore Lucene::BitSet;
%ignore Lucene::DocIdBitSet;
%ignore Lucene::MiscUtils;
%ignore Lucene::ReaderUtil;
%ignore Lucene::StringUtils;
%ignore Lucene::CycleCheck;
%ignore Lucene::VariantUtils;
%ignore Lucene::UnicodeUtil;
%ignore Lucene::SyncLock;
%ignore Lucene::TestScope;
%ignore Lucene::ThreadId;
%ignore Lucene::UnicodeResult;
%ignore Lucene::UTF8Result;
%ignore Lucene::BitUtil;
%ignore Lucene::FileReader;
%ignore Lucene::BufferedReader;
%ignore Lucene::Cache;
%ignore Lucene::OpenBitSetDISI;
%ignore Lucene::OpenBitSetIterator;
%ignore Lucene::OpenBitSet;
%ignore Lucene::ScorerDocQueue;
%ignore Lucene::Random;
%ignore Lucene::SortedVIntList;
%ignore Lucene::DocIdBitSetIterator;

%ignore Lucene::InfoStream::operator<< (const Lucene::String& t);
%feature("notabstract") Lucene::InfoStreamOut;
%feature("notabstract") Lucene::CharReader;


//implement these functions in the extends... these are templates...
%ignore Lucene::AttributeSource::getAttribute();
%ignore Lucene::AttributeSource::hasAttribute();
%ignore Lucene::AttributeSource::addAttribute();
%extend Lucene::AttributeSource {
  AttributePtr _getAttribute(const String& className){
    if ( className.compare(L"FlagsAttribute") == 0 ){
      return boost::dynamic_pointer_cast<Attribute>($self->getAttribute<FlagsAttribute>());
    }else if ( className.compare(L"OffsetAttribute") == 0 ){
      return boost::dynamic_pointer_cast<Attribute>($self->getAttribute<OffsetAttribute>());
    }else if ( className.compare(L"PayloadAttribute") == 0 ){
      return boost::dynamic_pointer_cast<Attribute>($self->getAttribute<PayloadAttribute>());
    }else if ( className.compare(L"PositionIncrementAttribute") == 0 ){
      return boost::dynamic_pointer_cast<Attribute>($self->getAttribute<PositionIncrementAttribute>());
    }else if ( className.compare(L"TermAttribute") == 0 ){
      return boost::dynamic_pointer_cast<Attribute>($self->getAttribute<TermAttribute>());
    }else if ( className.compare(L"TypeAttribute") == 0 ){ 
      return boost::dynamic_pointer_cast<Attribute>($self->getAttribute<TypeAttribute>());
    }else{
      boost::throw_exception(IllegalArgumentException( (className + Lucene::String(L" not supported")).c_str() ));
    }
  }
  bool _hasAttribute(const String& className){
    if ( className.compare(L"FlagsAttribute") == 0 ){
      return $self->hasAttribute<FlagsAttribute>();
    }else if ( className.compare(L"OffsetAttribute") == 0 ){
      return $self->hasAttribute<OffsetAttribute>();
    }else if ( className.compare(L"PayloadAttribute") == 0 ){
      return $self->hasAttribute<PayloadAttribute>();
    }else if ( className.compare(L"PositionIncrementAttribute") == 0 ){
      return $self->hasAttribute<PositionIncrementAttribute>();
    }else if ( className.compare(L"TermAttribute") == 0 ){
      return $self->hasAttribute<TermAttribute>();
    }else if ( className.compare(L"TypeAttribute") == 0 ){ 
      return $self->hasAttribute<TypeAttribute>();
    }else{
      boost::throw_exception(IllegalArgumentException( (className + Lucene::String(L" not supported")).c_str() ));
    }
  }
  AttributePtr _addAttribute(const String& className){
    if ( className.compare(L"FlagsAttribute") == 0 ){
      return boost::dynamic_pointer_cast<Attribute>($self->addAttribute<FlagsAttribute>());
    }else if ( className.compare(L"OffsetAttribute") == 0 ){
      return boost::dynamic_pointer_cast<Attribute>($self->addAttribute<OffsetAttribute>());
    }else if ( className.compare(L"PayloadAttribute") == 0 ){
      return boost::dynamic_pointer_cast<Attribute>($self->addAttribute<PayloadAttribute>());
    }else if ( className.compare(L"PositionIncrementAttribute") == 0 ){
      return boost::dynamic_pointer_cast<Attribute>($self->addAttribute<PositionIncrementAttribute>());
    }else if ( className.compare(L"TermAttribute") == 0 ){
      return boost::dynamic_pointer_cast<Attribute>($self->addAttribute<TermAttribute>());
    }else if ( className.compare(L"TypeAttribute") == 0 ){ 
      return boost::dynamic_pointer_cast<Attribute>($self->addAttribute<TypeAttribute>());
    }else{
      boost::throw_exception(IllegalArgumentException( (className + Lucene::String(L" not supported")).c_str() ));
    }
  }
  %insert("python") %{
    def _getAttributeName(self, classType):
      name = str(classType)
      if not name.startswith("<class 'lucene."): raise Exception("Invalid Attribute")
      if not name.endswith("Attribute'>"): raise Exception("Invalid Attribute")
      name = name[len("<class 'lucene."):-2]
      return name
    def getAttribute(self, classType): return classType.cast_(self._getAttribute(self._getAttributeName(classType)))
    def hasAttribute(self, classType): return self._hasAttribute(self._getAttributeName(classType))
    def addAttribute(self, classType): return classType.cast_(self._addAttribute(self._getAttributeName(classType)))
  %}
}


//director'd reader
%include "AbstractReader.i"

%include "Attribute.h";
%include "AttributeSource.h";
%include "BitVector.h";
%include "BitSet.h";
%include "NumericUtils.h";
%include "Collator.h";
%include "Constants.h";
%include "InfoStream.h";
%include "FieldCacheSanityChecker.h";

%inline {
  void DumpCycleCheckRefs() {
    CycleCheck::dumpRefs();
  }
}

