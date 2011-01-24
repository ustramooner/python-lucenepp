#!/usr/bin/env python

"""
setup.py file for clucene-bindings
"""

from distutils.core import setup, Extension

lucene_module = Extension('_lucenepp',
                           sources=['lucene++PYTHON_wrap.cxx'],
                           libraries=['lucene++'],
                           include_dirs=["include", "/usr/include/lucene++"]
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


