#include <Collection.h>
#include <stdexcept>
%include "generator.i"

%define LUCENE_COLLECTION(Name, JType, Type)

SWIG_DECLARE_FINAL(Lucene::Collection<Type>)
%{
  typedef Lucene::Collection<Type> Name;
%}

%extend Lucene::Collection<Type> {
	void append(const Type& type) {
	  try{
	    $self->add(type);
	  }_CLCATCH();
	}
  inline void __setitem__(int32_t i, const Type& v) { 
	  try{
      if ( i < 0 || i >= $self->size() )
        std::__throw_out_of_range("__setitem__");
      (*$self)[i] = v; 
	  }_CLCATCH();
  }
  inline const Type& __getitem__(int32_t i) { 
	  try{
      if ( i < 0 || i >= $self->size() )
        std::__throw_out_of_range("__setitem__");
      return (*$self)[i]; 
	  }_CLCATCH();
  }
  inline void __delitem__(int32_t p) {
	  try{
      if ( p < 0 || p >= $self->size() )
        std::__throw_out_of_range("__delitem__");
      Lucene::Collection<Type>::iterator itr = $self->begin();
      itr += p;
      if ( itr != $self->end() )
        $self->remove(itr); 
	  }_CLCATCH();
  }
  inline bool __ne__(const Lucene::Collection<Type>& other) { 
	  try{
	    return !$self->equals(other);  
	  }_CLCATCH();
	}
  inline bool __eq__(const Lucene::Collection<Type>& other) { 
	  try{
	    return $self->equals(other);  
	  }_CLCATCH();
	}
  inline int32_t __hash__() { 
	  try{
	    return $self->hashCode();  
	  }_CLCATCH();
	}

  %insert("python") %{
    def __contains__(self, v): return self.contains(v)
    def __len__(self): return self.size()
    def __str__(self): return "[" + ", ".join([`item` for item in self]) + "]"
  %}
}

#swig generator.i iterator base...
SETUP_GENERATOR( Lucene::Collection<Type>::const_iterator )
ADD_GENERATOR( Lucene::Collection<Type>, __iter__,
        Lucene::Collection<Type>::const_iterator, Type,
        begin, end)

//must be last...
%template (Name) Lucene::Collection<Type>;

%enddef









//fix booleanclause::occur fragment.
%fragment("AsBooleanClauseOccurCollection", "header"){
  Lucene::Collection<BooleanClause::Occur>* AsBooleanClauseOccurCollection(PyObject *input, Lucene::Collection<BooleanClause::Occur>& arg1, swig_type_info * arg1Descriptor, swig_type_info * typeDescriptor) {
    //this is special because Occur is an enum
    int arg1r;
    int ecode2;
    int val;
    
    /* Check if is a list */
    if (PyList_Check(input)) {
      int size = PyList_Size(input);
      
      arg1 = Lucene::Collection<BooleanClause::Occur>::newInstance(size);
      for (int i = 0; i < size; i++) {
        PyObject *o = PyList_GetItem(input,i);
        
        BooleanClause::Occur *arg1ptr = (BooleanClause::Occur *)0;
        ecode2 = SWIG_AsVal_int (o, &val);
        if (!SWIG_IsOK(arg1r) ) {
          return NULL;
        }
        
        arg1[i] = static_cast< Lucene::BooleanClause::Occur >(val);
      }
      return &arg1;
    } else {
      Lucene::Collection<BooleanClause::Occur>* ret = 0;
      arg1r = SWIG_ConvertPtr(input, (void**) &ret, arg1Descriptor, 0 );
      if (!SWIG_IsOK(arg1r) || !ret) {
        return NULL;
      }
      return ret;
    }
  }
}


%define COLLECTION_BI_IN_TYPEMAP(Type, CheckFunction, ConversionFunction, FunctionName, precedenceNum)
  %fragment("FunctionName", "header") {
    Lucene::Collection<Type>* FunctionName(PyObject *input, Lucene::Collection<Type>& arg1, swig_type_info * arg1Descriptor) {
      int arg1r;
          
      /* Check if is a list */
      if (PyList_Check(input)) {
        int size = PyList_Size(input);
        
        for (int i = 0; i < size; i++) {
          PyObject *o = PyList_GetItem(input,i);
          if (! CheckFunction(o)) {
	          PyErr_SetString(PyExc_TypeError,"list must contain '""Type""'");
	          return NULL;
          }
        }
      
        arg1 = Lucene::Collection<Type>::newInstance(size);
        for (int i = 0; i < size; i++) {
          PyObject *o = PyList_GetItem(input,i);
          
          Type arg1ptr = 0;
          
          arg1r = ConversionFunction(o, &arg1ptr);
          if (!SWIG_IsOK(arg1r) || !arg1ptr) {
            return NULL;
          }
          arg1[i] = arg1ptr;
        }
        return &arg1;
      } else {
        Lucene::Collection<Type>* ret = 0;
        arg1r = SWIG_ConvertPtr(input, (void**) &ret, arg1Descriptor, 0 );
        if (!SWIG_IsOK(arg1r) || !ret) {
          return NULL;
        }
        return ret;
      }
    }
  }
  %typemap(arginit) Lucene::Collection<Type>& %{
    Lucene::Collection<Type> temp$1;
  %}
  %typemap(arginit) Lucene::Collection<Type> %{
    Lucene::Collection<Type> temp$1;
    Lucene::Collection<Type>* tmp$argnum = 0;
  %}
  %typemap (in, fragment="FunctionName") Lucene::Collection<Type>& %{
    $1 = FunctionName($input, temp$1, $1_descriptor);
    if ( $1 == NULL ) SWIG_exception_fail(SWIG_ValueError,"in method '$symname', argument $argnum of type '$type'"); 
  %}
  %typemap (in, fragment="FunctionName") Lucene::Collection<Type> %{
    tmp$argnum = FunctionName($input, temp$1, $descriptor(Lucene::Collection<Type>*));
    if ( tmp$argnum == NULL ) SWIG_exception_fail(SWIG_ValueError,"in method '$symname', argument $argnum of type '$type'"); 
    $1 = *tmp$argnum;
  %}
  %typemap(typecheck,precedence=precedenceNum) Lucene::Collection<Type>, Lucene::Collection<Type>& {
     int res = SWIG_ConvertPtr($input, 0, $descriptor(Lucene::Collection<Type>*), 0);
     $1 = ( SWIG_CheckState(res) || PyList_Check($input) )? 1 : 0;
  }
%enddef



%define COLLECTION_STR_IN_TYPEMAP(Type, CheckFunction, ConversionFunction, FunctionName, precedenceNum)
  %fragment("FunctionName", "header") {
    Lucene::Collection<Type>* FunctionName(PyObject *input, Lucene::Collection<Type>& arg1, swig_type_info * arg1Descriptor) {
      int arg1r;
          
      /* Check if is a list */
      if (PyList_Check(input)) {
        int size = PyList_Size(input);
        
        for (int i = 0; i < size; i++) {
          PyObject *o = PyList_GetItem(input,i);
          if (! CheckFunction(o)) {
	          PyErr_SetString(PyExc_TypeError,"list must contain '""Type""'");
	          return NULL;
          }
        }
      
        arg1 = Lucene::Collection<Type>::newInstance(size);
        for (int i = 0; i < size; i++) {
          PyObject *o = PyList_GetItem(input,i);
          
          Type *arg1ptr = (Type *)0;
          
          arg1r = ConversionFunction(o, &arg1ptr);
          if (!SWIG_IsOK(arg1r) || !arg1ptr) {
            return NULL;
          }
          arg1[i] = *arg1ptr;
          delete arg1ptr;
        }
        return &arg1;
      } else {
        Lucene::Collection<Type>* ret = 0;
        arg1r = SWIG_ConvertPtr(input, (void**) &ret, arg1Descriptor, 0 );
        if (!SWIG_IsOK(arg1r) || !ret) {
          return NULL;
        }
        return ret;
      }
    }
  }
  %typemap(arginit) Lucene::Collection<Type>& %{
    Lucene::Collection<Type> temp$1;
  %}
  %typemap(arginit) Lucene::Collection<Type> %{
    Lucene::Collection<Type> temp$1;
    Lucene::Collection<Type>* tmp$argnum = 0;
  %}
  %typemap (in, fragment="FunctionName") Lucene::Collection<Type>& %{
    $1 = FunctionName($input, temp$1, $1_descriptor);
    if ( $1 == NULL ) SWIG_exception_fail(SWIG_ValueError,"in method '$symname', argument $argnum of type '$type'"); 
  %}
  %typemap (in, fragment="FunctionName") Lucene::Collection<Type> %{
    tmp$argnum = FunctionName($input, temp$1, $descriptor(Lucene::Collection<Type>*));
    if ( tmp$argnum == NULL ) SWIG_exception_fail(SWIG_ValueError,"in method '$symname', argument $argnum of type '$type'"); 
    $1 = *tmp$argnum;
  %}
  %typemap(typecheck,precedence=precedenceNum) Lucene::Collection<Type>, Lucene::Collection<Type>& {
     int res = SWIG_ConvertPtr($input, 0, $descriptor(Lucene::Collection<Type>*), 0);
     $1 = ( SWIG_CheckState(res) || PyList_Check($input) )? 1 : 0;
  }
%enddef


%define COLLECTION_IN_TYPEMAP(Type, FunctionName)
  %fragment("FunctionName", "header") {
    Lucene::Collection<Type>* FunctionName(PyObject *input, Lucene::Collection<Type>& arg1, swig_type_info * arg1Descriptor, swig_type_info * typeDescriptor) {
      int arg1r;
          
      /* Check if is a list */
      if (PyList_Check(input)) {
        int size = PyList_Size(input);
        
        arg1 = Lucene::Collection<Type>::newInstance(size);
        for (int i = 0; i < size; i++) {
          PyObject *o = PyList_GetItem(input,i);
          
          Type *arg1ptr = (Type *)0;
          
          int newmem = 0;
          int res2 = SWIG_ConvertPtrAndOwn(o, (void**)&arg1ptr, typeDescriptor,  0 , &newmem);
          if (!SWIG_IsOK(res2) || !arg1ptr) {
            return NULL;
          }
          arg1[i] = *reinterpret_cast< Type * >(arg1ptr);
          if (newmem & SWIG_CAST_NEW_MEMORY) {
            delete reinterpret_cast< Type * >(arg1ptr);
          }
        }
        return &arg1;
      } else {
        Lucene::Collection<Type>* ret = 0;
        arg1r = SWIG_ConvertPtr(input, (void**) &ret, arg1Descriptor, 0 );
        if (!SWIG_IsOK(arg1r) || !ret) {
          return NULL;
        }
        return ret;
      }
    }
  }

  %typemap(arginit) Lucene::Collection<Type>& %{
    Lucene::Collection<Type> temp$1;
  %}
  %typemap(arginit) Lucene::Collection<Type> %{
    Lucene::Collection<Type> temp$1;
    Lucene::Collection<Type>* tmp$argnum = 0;
  %}
  %typemap (in, fragment="FunctionName") Lucene::Collection<Type>& %{
    $1 = FunctionName($input, temp$1, $descriptor(Lucene::Collection<Type>*), $descriptor(Type*));
    if ( $1 == NULL ) SWIG_exception_fail(SWIG_ValueError,"in method '$symname', argument $argnum of type '$type'"); 
  %}
  %typemap (in, fragment="FunctionName") Lucene::Collection<Type> %{
    tmp$argnum = FunctionName($input, temp$1, $descriptor(Lucene::Collection<Type>*), $descriptor(Type*));
    if ( tmp$argnum == NULL ) SWIG_exception_fail(SWIG_ValueError,"in method '$symname', argument $argnum of type '$type'"); 
    $1 = *tmp$argnum;
  %}
  %typemap(typecheck,precedence=SWIG_TYPECHECK_STRING_ARRAY) Lucene::Collection<Type>, Lucene::Collection<Type>& {
     int res = SWIG_ConvertPtr($input, 0, $descriptor(Lucene::Collection<Type>*), 0);
     $1 = (SWIG_CheckState(res) || PyList_Check($input) ) ? 1 : 0;
  }
%enddef


COLLECTION_STR_IN_TYPEMAP(String, PyString_Check, SWIG_AsPtr_Lucene_String, AsStringCollection, SWIG_TYPECHECK_STRING_ARRAY)


%{
  SWIGINTERN int
  SWIG_AsVal_longLong (PyObject *obj, long long* val)
  {
    
    if (PyLong_Check(obj)) {
      long long v = PyLong_AsLongLong(obj);
      if (!PyErr_Occurred()) {
        if (val) *val = v;
        return SWIG_OK;
      } else {
        PyErr_Clear();
      }
    }
    //let default handling takeover...
    long lval = 0;
    int ret = SWIG_AsVal_long(obj, &lval);
    *val = lval;
    return ret;
  }
%}
#built in types...
COLLECTION_BI_IN_TYPEMAP(int, PyInt_Check, SWIG_AsVal_int, AsIntCollection, SWIG_TYPECHECK_INT32_ARRAY)
COLLECTION_BI_IN_TYPEMAP(double, PyFloat_Check, SWIG_AsVal_double, AsDoubleCollection, SWIG_TYPECHECK_DOUBLE_ARRAY)
//COLLECTION_BI_IN_TYPEMAP(long, PyLong_Check, SWIG_AsVal_long, AsLongCollection, SWIG_TYPECHECK_INT32_ARRAY)
COLLECTION_BI_IN_TYPEMAP(long long, PyLong_Check, SWIG_AsVal_longLong, AsLongLongCollection, SWIG_TYPECHECK_INT64_ARRAY)


#objects...
COLLECTION_IN_TYPEMAP(FieldCollectionPtr, AsFieldCollection)
COLLECTION_IN_TYPEMAP(FieldablePtr, AsFieldableCollection)
COLLECTION_IN_TYPEMAP(AttributePtr, AsAttributeCollection)
COLLECTION_IN_TYPEMAP(BooleanClausePtr, AsBooleanClauseCollection)
COLLECTION_IN_TYPEMAP(BooleanQueryPtr, AsBooleanQueryCollection)
COLLECTION_IN_TYPEMAP(DirectoryPtr, AsDirectoryCollection)
COLLECTION_IN_TYPEMAP(ExplanationPtr, AsExplanationCollection)
COLLECTION_IN_TYPEMAP(FieldCacheEntryPtr, AsFieldCacheEntryCollection)
COLLECTION_IN_TYPEMAP(FieldComparatorPtr, AsFieldComparatorCollection)
COLLECTION_IN_TYPEMAP(IndexReaderPtr, AsIndexReaderCollection)
COLLECTION_IN_TYPEMAP(IndexCommitPtr, AsIndexCommitCollection)
COLLECTION_IN_TYPEMAP(OneMergePtr, AsOneMergeCollection)
COLLECTION_IN_TYPEMAP(PositionInfoPtr, AsPositionInfoCollection)
COLLECTION_IN_TYPEMAP(QueryPtr, AsQueryCollection)
COLLECTION_IN_TYPEMAP(ScoreDocPtr, AsScoreDocCollection)
COLLECTION_IN_TYPEMAP(SearchablePtr, AsSearchableCollection)
COLLECTION_IN_TYPEMAP(SegmentInfoStatusPtr, AsSegmentInfoStatusCollection)
COLLECTION_IN_TYPEMAP(SegmentReaderPtr, AsSegmentReaderCollection)
COLLECTION_IN_TYPEMAP(SortFieldPtr, AsSortFieldCollection)
COLLECTION_IN_TYPEMAP(SpanQueryPtr, AsSpanQueryCollection)
COLLECTION_IN_TYPEMAP(SpansPtr, AsSpansCollection)
COLLECTION_IN_TYPEMAP(StartEndPtr, AsStartEndCollection)
COLLECTION_IN_TYPEMAP(TermFreqVectorPtr, AsTermFreqVectorCollection)
COLLECTION_IN_TYPEMAP(TermVectorEntryPtr, AsTermVectorEntryCollection)
COLLECTION_IN_TYPEMAP(TermVectorOffsetInfoPtr, AsTermVectorOffsetInfoCollection)
COLLECTION_IN_TYPEMAP(ValueSourceQueryPtr, AsValueSourceQueryCollection)
COLLECTION_IN_TYPEMAP(TermPtr, AsTermCollection)
COLLECTION_IN_TYPEMAP(Insanity, AsInsanityCollection)

COLLECTION_IN_TYPEMAP(BooleanClause::Occur, AsBooleanClauseOccurCollection)



