# ====================================================================
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
# ====================================================================

from unittest2 import TestCase as UnitTestCase, main, TestLoader
import lucene
import os

class BaseLuceneTestCase(UnitTestCase):
  "Test base class"
  
  def cleanup(*args):
    lucene.DumpCycleCheckRefs()
  
  def __init__(self, *args, **kwds):
    super(BaseLuceneTestCase, self).__init__(*args, **kwds)
    self.addCleanup(self.cleanup)

def load_tests(loader, standard_tests, pattern):
  # top level directory cached on loader instance
  this_dir = os.path.dirname(__file__)
  package_tests = loader.discover(start_dir=this_dir, pattern='test_*.py')
  standard_tests.addTests(package_tests)
  return standard_tests
    
if __name__ == "__main__":
  import sys, lucene
  if '-loop' in sys.argv:
      sys.argv.remove('-loop')
      while True:
          try:
              main()
          except:
              pass
  else:
       main()

