
import os, sys, lucene

sys.path.append(os.path.dirname(os.path.abspath(sys.argv[0])))

from lia.indexing.IndexTuningDemo import IndexTuningDemo
IndexTuningDemo.main(sys.argv)
