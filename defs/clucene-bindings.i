%module(directors="1") lucenepp

%include <boost_shared_ptr.i>

#ifdef SWIGJAVA
  %include <boost_intrusive_ptr.i>
  %include <arrays_java.i>
#endif
%include <typemaps.i>
%include <exception.i>
%include <std_string.i>
%include <std_wstring.i>
%include <wchar.i>

//local typemaps:
%include LuceneString.i

#define INTERNAL private
namespace boost{
	typedef signed char int8_t;
	typedef unsigned char uint8_t;
	typedef short int16_t;
	typedef unsigned short uint16_t;
	typedef int int32_t;
	typedef unsigned int uint32_t;
	typedef long int64_t;
	typedef unsigned long uint64_t;
}
typedef signed char int8_t;
typedef unsigned char uint8_t;
typedef short int16_t;
typedef unsigned short uint16_t;
typedef int int32_t;
typedef unsigned int uint32_t;
typedef long int64_t;
typedef unsigned long uint64_t;
%apply long long {long};

//mapping for wchar_t
%include "LuceneChar.i"

%{
  //provide user define assert...
  #define BOOST_ENABLE_ASSERT_HANDLER
  
	//stuff that goes in the wrapper
	#include "LuceneHeaders.h"
	#include "Collection.h"
	#include "StringUtils.h"
	using namespace Lucene;
	
  namespace boost
  {
    void assertion_failed(char const * expr, char const * function, char const * file, long line){ // user defined
      std::string error = std::string("Assertion Failed: ") + std::string(expr);
      
      #ifndef NDEBUG
        char sline[10];
        sprintf(sline, "%ld", line);
        error += std::string(" in ") + std::string(function) + " at " + std::string(file) + std::string(":") + std::string(sline);
      #endif
      boost::throw_exception(RuntimeException(StringUtils::toUnicode((uint8_t*)error.c_str(), error.size())));
    }
  } // namespace boost

  //catch used in functions which may call a director function
 	#define _CLCATCH() \
 	  catch ( ... ){ \
 	    throw Swig::DirectorMethodException(); \
 	  }
 	 
%}

#ifndef SUMO
  //exclude stuff if not build sumo mode
  %include "NonSumoExcludes.i";
#endif

//forward declaration of all classes
%include lucene_fwd.i

//shared stuff first.
%include "lucene_shared.i";

//the lucene exceptions handler
%include LuceneExceptions.i

#ifndef TESTING
  //maps and sets and arrays, etc
  %include LuceneCollections.i
  %include LuceneMaps.i
  %include LuceneSets.i
  %include LuceneArrays.i

  //add functionality to classes
  %include local_functionality.i

  %include "lucene_util.i";

  %include "lucene_document.i";
  %include "lucene_analysis.i";
  %include "lucene_store.i";
  %include "lucene_index.i";
  %include "lucene_search.i";
  %include "lucene_queryparser.i";
  %include "extras.i"
#else
  %include "lucene_testing.i"
#endif

