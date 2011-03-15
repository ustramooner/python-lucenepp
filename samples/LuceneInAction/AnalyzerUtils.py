
import os, sys, lucene

sys.path.append(os.path.dirname(os.path.abspath(sys.argv[0])))

from lia.analysis.AnalyzerUtils import AnalyzerUtils
AnalyzerUtils.main(sys.argv)
