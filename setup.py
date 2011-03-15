#!/usr/bin/env python

"""
setup.py file for clucene-bindings
"""

from distutils.core import setup, Extension
import os

dirname=os.path.dirname(__file__)
dirname = os.path.relpath(dirname) if dirname != '' else '.'

def get_pkgconfig_value(param, package):
  """ get a value from pkg-config for package
      param value: option to pkg-config
  """
  try:
    f = os.popen("pkg-config %s %s" % (param, package))
    x = f.readline().strip()
    f.close()
  except Exception:
    print "Couldn't run 'pkg-config %s %s', check that liblucene++ and pkg-config is properly installed"  % (param, package)
    exit(1)
  
  # generators: 2.4+ only :(
  #return list(y[2:] for y in x.split(" "))

  l = []
  for y in x.split(" "):
	  y = y.strip()
	  if y != '':
	    l.append(y) 
  return l


inc_dirs = [dirname + "/include"]
inc_dirs.extend(get_pkgconfig_value('--variable=includedir', 'liblucene++'))
if len(inc_dirs) == 1:
  #TODO: remove this when pc file is fixed: 
  inc_dirs.append('/usr/include/lucene++');

lib_dirs = []
lib_dirs.extend(get_pkgconfig_value('--variable=libdir', 'liblucene++'))
 
lucene_module = Extension('_lucenepp',
                           sources=[dirname + '/lucene++PYTHON_wrap.cxx'],
                           libraries=get_pkgconfig_value('--variable=lib', 'liblucene++'),
                           library_dirs=lib_dirs,
                           include_dirs=inc_dirs,
                           )

setup (name = 'python-lucene++',
       version = '0.2',
       author      = "Ben van Klinken",
       author_email= "ustramooner@users.sourceforge.net",
       description = """Python bindings for Lucene++""",
       license = "Apache Software License",
       long_description = """
       """,
       ext_modules = [lucene_module],
       py_modules = ["lucene"],
       url = "http://www.github.com/ustramooner",
       classifiers=[
          'Development Status :: 3 - Alpha',
          'Environment :: Console',
          'Environment :: Web Environment',
          'Environment :: Plugins',
          'Intended Audience :: Developers',
          'License :: OSI Approved :: Apache Software License',
          'Operating System :: POSIX',
          'Programming Language :: Python',
          'Topic :: Internet :: WWW/HTTP :: Indexing/Search',
          'Topic :: Software Development :: Libraries :: Python Modules',
       ]
)


