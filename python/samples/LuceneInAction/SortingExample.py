import tempfile
import os, sys, lucene

baseDir = os.path.dirname(os.path.abspath(sys.argv[0]))
sys.path.append(baseDir)

from lia.advsearching.SortingExample import SortingExample

os.environ["index.dir"] = os.path.join(baseDir, "index")
SortingExample.main(sys.argv)
