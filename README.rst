P Y T H O N - L U C E N E + +
-----------------------------
This project is part of clucene-bindings (http://github.com/ustramooner/clucene-bindings)

The lucene module is an extensive set of bindings around Lucene++ (http://github.com/ustramooner/LucenePlusPlus/)

After installing, have a look at the samples and test folder to see how to create your first python-lucene++ app. 

PyLucene users should find python-lucene++ very familiar, and there are very few changes necessary (see the section 'Porting your code from PyLucene' below)

Ubuntu Packages
-----------------------------
Ubuntu packages are available from my ppa. To get them, run:

 sudo add-apt-repository ppa:ustramooner
 
 sudo apt-get update
 
 sudo apt-get install python-lucenepp


Installing from source
-------------------------------------
You will need the following packages installed:
 * python (I have only tested 2.6.6 so far)
 * Lucene++ (get it from http://github.com/ustramooner/LucenePlusPlus, or install the ubuntu package liblucene++-dev from ppa:ustramooner)
 
 # cd <python-lucene++-dir>/python/
 
 # python setup.py install

It is better to use a package, so that you can remove it:
 # python setup.py bdist_rpm

If you are on a debian system, convert the rpm into a deb
 # fakeroot alien --to-deb `ls python-lucene++-*.rpm|grep -v src`

Then install the resulting rpm or deb from the `dist` folder.

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

* There is no object.instance_(other). Use object.getClassName() == "OtherClassName"

H A C K I N G
-------------
If you want to make changes to the code, you will need the full source distribution,
you can find that at https://github.com/ustramooner/clucene-bindings
You will also need cmake 2.8+ and swig version 2.0.1.
Note that different swig versions are known to create changes that break the system.
If you use another version, be sure to do a diff of what gets created before actually 
changing something

 # cd <python-lucene++-dir>/python/

 # mkdir build

 # cd build

 # cmake -DBindingLang=Python ../../
 
 # ln -s liblucenepp.so _lucenepp.so

Note that the generated swig file is gigantic, and you'll need a fair bit of memory
to compile. It would be ideal to be able to split up the file, but swig has not
such option currently.

Make python look for the module here since it's not installed.
 # export PYTHONPATH=`pwd`:`cd ../ && pwd`

Testing
 * You'll need python-unittest2 installed
 * Run:
 # python ../test/BaseLuceneTestCase.py


K N O W N   B U G S
------------------

Swig has a few bugs with Python Directors and smart_ptrs. As a result there
are a few problems which you need to be aware of until these are fixed.

* The Lucene objects do not store a pointer to the python object, as a result, using
  a custom class needs to be stored in the user's code.
  
  This will fail (keep a MySimiliarity instane in scope instead)
  searcher.setSimiliarity(MySimilarity())
  
  This needs to be fixed in swig

* You MUST return the correct object type from a Director class. No casting
  is done from the result. So returning StandardTokenizer from Analyzer->getAnalyzer()
  must be cast to Tokenizer. Returning None will also fail badly
  
  This needs to be fixed in swig


