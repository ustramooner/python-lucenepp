
import os, sys, lucene

sys.path.append(os.path.dirname(os.path.abspath(sys.argv[0])))

from lia.meetlucene.Indexer import Indexer
Indexer.main(sys.argv)
