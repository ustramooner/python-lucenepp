
import os, sys, unittest, lucene

baseDir = os.path.dirname(os.path.abspath(sys.argv[0]))
sys.path.append(baseDir)

import lia.searching.QueryParserTest

os.environ["index.dir"] = os.path.join(baseDir, "index")
unittest.main(lia.searching.QueryParserTest)
