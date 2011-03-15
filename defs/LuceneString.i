%include <typemaps/wstring.swg>
%include <typemaps/std_strings.swg>

%{
#include <cwchar>
#include <string>
%}

namespace Lucene
{
  %naturalvar String;
  class String;
}

%typemaps_std_string(Lucene::String, wchar_t, SWIG_AsWCharPtrAndSize, SWIG_FromWCharPtrAndSize, %checkcode(STDUNISTRING));

%typemap(typecheck, precedence=SWIG_TYPECHECK_STRING) Lucene::String, Lucene::String&, const Lucene::String, const Lucene::String& %{
  $1 = PyUnicode_Check($input) || PyString_Check($input) ? 1 : 0;
%}

