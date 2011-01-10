%{
  LuceneObjectPtr ToLuceneObjectPtr(PyObject* obj){
    Lucene::LuceneObjectPtr arg1;
    void *argp1 ;
    int res1 = 0 ;
    int newmem = 0;
    res1 = SWIG_ConvertPtrAndOwn(obj, &argp1, SWIGTYPE_p_boost__shared_ptrT_Lucene__LuceneObject_t,  0 , &newmem);
    if (!SWIG_IsOK(res1) || argp1 == NULL) {
      return LuceneObjectPtr();
    }
    if (argp1) arg1 = *(reinterpret_cast< Lucene::LuceneObjectPtr * >(argp1));
    if (newmem & SWIG_CAST_NEW_MEMORY) delete reinterpret_cast< Lucene::LuceneObjectPtr * >(argp1);

    return arg1;
  }
%}

%{
  static PyObject* SWIG_From_bool  (bool value);
%}
%inline %{
  PyObject* LuceneObject__equals(PyObject* objSelf, PyObject* obj) {
    //todo: throw an error?
    LuceneObjectPtr self = ToLuceneObjectPtr(objSelf);
    if ( !self ){
      PyErr_SetString(PyExc_RuntimeError, "self is not a LuceneObject");
      return NULL;
    }
    LuceneObjectPtr other = ToLuceneObjectPtr(obj);
    if ( !other ){
      PyErr_SetString(PyExc_RuntimeError, "argument is not a LuceneObject");
      return NULL;
    }
    return SWIG_From_bool(static_cast< bool >(self->equals(other))); 
  }
  PyObject* LuceneObject__compare(PyObject* objSelf, PyObject* obj) {
    //todo: throw an error?
    LuceneObjectPtr self = ToLuceneObjectPtr(objSelf);
    if ( !self ){
      PyErr_SetString(PyExc_RuntimeError, "self is not a LuceneObject");
      return NULL;
    }
    LuceneObjectPtr other = ToLuceneObjectPtr(obj);
    if ( !other ){
      PyErr_SetString(PyExc_RuntimeError, "argument is not a LuceneObject");
      return NULL;
    }
    return SWIG_From_int(static_cast< int >(self->compareTo(other))); 
  }
  Lucene::String LuceneObject__str(PyObject* objSself) { 
    LuceneObjectPtr self = ToLuceneObjectPtr(objSself);
    if ( !self ){
      return L"";
    }
    return self->toString(); 
  }
  PyObject* LuceneObject__hash(PyObject* objSelf) {
    LuceneObjectPtr self = ToLuceneObjectPtr(objSelf);
    if ( !self ){
      PyErr_SetString(PyExc_RuntimeError, "argument is not a LuceneObject");
      return NULL;
    }
    return SWIG_From_int(static_cast< int >(self->hashCode()));
  }
  
%}

%extend Lucene::LuceneObject {
  %insert("python") %{
    def __eq__(self, other): return False if other == None else LuceneObject__equals(self, other)
    def __ne__(self, other): return True if other == None else not LuceneObject__equals(self, other)
    def __cmp__(self, other): return LuceneObject__compare(self, other)
    def __str__(self): return LuceneObject__str(self)
    def __hash__(self): return LuceneObject__hash(self)
  %}
}

%define SWIG_ADD_CAST_METHODS(Type)
%extend Lucene::Type {
  static PyObject* __cast_(PyObject* obj){
    Type ##Ptr result;
    void *argp1 ;
    int res1 = 0 ;
    int newmem = 0;
    res1 = SWIG_ConvertPtrAndOwn(obj, &argp1, $descriptor(Type ##Ptr *),  0 , &newmem);
    if (SWIG_IsOK(res1) && argp1 != NULL) {
      result = *(reinterpret_cast< Type ##Ptr * >(argp1));
      if (newmem & SWIG_CAST_NEW_MEMORY) delete reinterpret_cast< Type ##Ptr * >(argp1);
    }else{
      res1 = SWIG_ConvertPtrAndOwn(obj, &argp1, $descriptor(LuceneObjectPtr *),  0 , &newmem);
      if (SWIG_IsOK(res1) && argp1 != NULL) {
        result = boost::dynamic_pointer_cast< Type >( *(reinterpret_cast< LuceneObjectPtr * >(argp1)) );
        if (newmem & SWIG_CAST_NEW_MEMORY) delete reinterpret_cast< LuceneObjectPtr * >(argp1);
      }
    }
    if ( ! result ){
      Py_INCREF(Py_None);
      return Py_None;
    }else{
      boost::shared_ptr< Lucene::Type > *smartresult = new boost::shared_ptr< Lucene::Type >(result);
      return SWIG_NewPointerObj(SWIG_as_voidptr(smartresult), $descriptor(Type ##Ptr *), SWIG_POINTER_OWN);
    }
  }
  
  %insert("python") %{
    @staticmethod
    def cast_(obj):
      if getattr(obj, "toLuceneObject", None): obj = obj.toLuceneObject()
      return Type.__cast_(obj)
  %}
}
%enddef

%define SWIG_ADD_STD_INTERFACE_METHODS(Type)
# Interfaces need to be able to be cast back to LuceneObject for cast_
%extend Lucene::Type {
  PyObject* toLuceneObject__(PyObject* obj){
    Type ##Ptr result;
    Lucene::LuceneObjectPtr arg1;
    void *argp1 ;
    int res1 = 0 ;
    int newmem = 0;
    res1 = SWIG_ConvertPtrAndOwn(obj, &argp1, $descriptor(Type ##Ptr *),  0 , &newmem);
    if (SWIG_IsOK(res1) && argp1 != NULL) {
      result = *(reinterpret_cast< Type ##Ptr * >(argp1));
      if (newmem & SWIG_CAST_NEW_MEMORY) delete reinterpret_cast< Type ##Ptr * >(argp1);
    }
    
    if ( ! result ){
      Py_INCREF(Py_None);
      return Py_None;
    }else{
      boost::shared_ptr< LuceneObject > *smartresult = new boost::shared_ptr< LuceneObject >( boost::dynamic_pointer_cast< LuceneObject >(result) );
      return SWIG_NewPointerObj(SWIG_as_voidptr(smartresult), $descriptor(LuceneObjectPtr *), SWIG_POINTER_OWN);
    }
  }
  %insert("python") %{
    def toLuceneObject(self): return self.toLuceneObject__(self)
  %}
}
  SWIG_ADD_CAST_METHODS(Type)
%enddef
%define SWIG_ADD_STD_METHODS(Type)
  SWIG_ADD_CAST_METHODS(Type)
%enddef

//////////////////////////////////////////////////////
// Director stuff
//////////////////////////////////////////////////////
/*%{

  std::map<void*, PyObject*> director_PyObject_Map;
  void directorDeleter( Lucene::LuceneObject* d ) { 
    //todo: use hashmap
    std::map<void*, PyObject*>::iterator f = director_PyObject_Map.find(d);
    if ( f != director_PyObject_Map.end() ){
      PyObject* py = f->second;
      printf("void deleter( %S )... count=%ld\n", d->toString().c_str(), py != NULL ? py->ob_refcnt : -1);
      if ( py != NULL )
        Py_DECREF(py);
      director_PyObject_Map.erase(f);
    }else{
      printf("object not found in director_PyObject_Map\n");
    }
    delete d; 
  }
  void normalDeleter( Lucene::LuceneObject* d ) {
    delete d;
  }

%}
*/

%define SWIG_DECLARE_DIRECTOR(OWNERSHIP, WEAKREF, Type)
SWIG_DECLARE_SHARED_PTR(Type)
%feature("director") Lucene::Type;

%typemap(directorout) Type##Ptr %{
  void *swig_argp;
  int swig_res = 0;
  
  //Directors hold their memory in the PyObject...
  swig_res = SWIG_ConvertPtr($input,&swig_argp,$descriptor, SWIG_POINTER_DISOWN  | 0);
  if (!SWIG_IsOK(swig_res)) {
    Swig::DirectorTypeMismatchException::raise(SWIG_ErrorType(SWIG_ArgError(swig_res)), "in output value of type '""Type""'");
  }
  if ( swig_argp ){
    $result = *(reinterpret_cast< Lucene::Type##Ptr * >(swig_argp));
    delete reinterpret_cast< Lucene::Type##Ptr * >(swig_argp); 
  }
%}

SWIG_ADD_STD_METHODS(Type)
%enddef

%define SWIG_DECLARE_DIRECTOR_ABSTRACT(OWNERSHIP, WEAKREF, Type)
  SWIG_DECLARE_DIRECTOR(OWNERSHIP, WEAKREF, Type)
%enddef

//////////////////////////////////////////////////////
// Forward declaratiosn
//////////////////////////////////////////////////////

%define SWIG_DECLARE_SHARED_PTR(Type)
  %shared_ptr(Lucene::Type)
  typedef boost::shared_ptr<Lucene::Type> Type##Ptr;
%enddef
%define SWIG_DECLARE_ABSTRACT(Type)
	%ignore Lucene::Type::Type;
%enddef
%define SWIG_DECLARE_NORMAL(Type)
%enddef
%define SWIG_DECLARE_FINAL(Type)
%enddef

%define SWIG_DECLARE_INTERFACE_SHARED_PTR(Type)
	SWIG_DECLARE_SHARED_PTR(Type) 	
	SWIG_DECLARE_ABSTRACT(Type)
	SWIG_ADD_STD_INTERFACE_METHODS(Type)
%enddef
%define SWIG_DECLARE_ABSTRACT_SHARED_PTR(Type)
	SWIG_DECLARE_SHARED_PTR(Type) 	
	SWIG_DECLARE_ABSTRACT(Type)
	SWIG_ADD_STD_METHODS(Type)
%enddef
%define SWIG_DECLARE_NORMAL_SHARED_PTR(Type)
	SWIG_DECLARE_SHARED_PTR(Type) 	
	SWIG_DECLARE_NORMAL(Lucene::Type)
	SWIG_ADD_STD_METHODS(Type)
%enddef
%define SWIG_DECLARE_FINAL_SHARED_PTR(Type)
	SWIG_DECLARE_SHARED_PTR(Type) 	
	SWIG_DECLARE_FINAL(Lucene::Type)
	SWIG_ADD_STD_METHODS(Type)
%enddef

SWIG_DECLARE_FINAL_SHARED_PTR(StringReader)

