%define SWIG_SET_EXCEPTION(TYPE, Exception)
%enddef

%{
	//we need to fool the swig preprocessor, otherwise it expands these directives
	 #define ___FILE___ __FILE__
	 #define ___LINE___ __LINE__

	  #include "StringUtils.h"
	  //TODO: use approperiate error
	  
	 	#define _CATCHALL() \
  	  catch (Lucene::LuceneException& e) { \
	      PyErr_SetString(PyExc_RuntimeError, const_cast<char*>(Lucene::StringUtils::toUTF8(e.getError()).c_str())); \
 			  return NULL; \
	    } catch (std::exception const& e) { \
			  char buf[250]; \
			  snprintf(buf,250,"std exception %s in %s at %d", e.what(), ___FILE___,___LINE___); \
        PyErr_SetString(PyExc_RuntimeError,buf); \
			  return NULL; \
	    } catch (Swig::DirectorException &e) { \
        SWIG_fail; \
      } /*catch (...) { \
			  char buf[250]; \
			  snprintf(buf,250,"UNKNOWN exception in %s at %d",___FILE___,___LINE___); \
        PyErr_SetString(PyExc_RuntimeError,buf); \
			  return NULL; \
			}*/
%}

%feature("director:except") %{
  if ($error != NULL) throw Swig::DirectorMethodException();
%}

//the exception handler...
%exception {
  try {
		$function
  }_CATCHALL();
}

