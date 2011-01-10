This file is part of clucene-bindings

  Copyright 2011 Ben van Klinken

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

python-lucenepp

The lucene module is an extensive set of bindings around Lucene++  
  (http://github.com/ustramooner/LucenePlusPlus/)


Porting your code from PyLucene
-------------------------------
As long as your code runs on PyLucene 3, python-lucene++ will work with these changes:

* Director classes (overridable classes) are not called Python* (PythonCollector, for example)
They are just called by the real name. Also, some classes like PythonCollector have some
convienience methods like collect(doc, score) which python-lucene++ doesnt currently have

* Attributes are used as follows:
  posIncrAtt = stream.addAttribute(PositionIncrementAttribute)

* Locale.X doesn't work... java comes with a very extensive locale selection.
we have Locale("en_US.utf8") which is a thin wrapper around std::locale. It
completely depends on what locale you have installed locally as to which locale
will work. On linux you can type 'locale -a' to get a list of installed locales.
  NOTE: currently there is a bug with dates and locales

* There is no object.instance_(other). Use object.getClassName() == "OtherClassName"


K N O W N  B U G S
------------------

Swig has a few bugs with Python Directors and smart_ptrs. As a result there
are a few problems which you need to be aware of until these are fixed.

* The Lucene objects do not store a pointer to the python object, as a result, using
  a custom class needs to be stored in the user's code.
  
  This will fail (keep a MySimiliarity instane in scope instead)
  searcher.setSimiliarity(MySimilarity())

* You MUST return the correct object type from a Director class. No casting
  is done from the result. So returning StandardTokenizer from Analyzer->getAnalyzer()
  must be cast to Tokenizer. Returning None will also fail badly

* QueryParser date parsing with locales fail. This is a problem in c++ where the
  locale doesn't return a valid correct date format. This always returns no_order for me:
  std::use_facet< std::time_get<wchar_t> >(locale).date_order()
  
  


T O D O
-------

* Implement contribs lib: highlighter, analyzers, etc

* Fix Director bugs, then re-instance all the tests and samples based on Tokenizer,
  etc which returns instances of Director'd objects.

* Iterators could be implemented for these classes:
  TermDocs, TermPositions, DocIdSetIterator, FilteredDocIdSetIterator, TermEnum, FilteredTermEnum
  and perhaps these: Spans, SpanScorer, NearSpansOrdered, NearSpansUnordered, TermSpans
  
  
