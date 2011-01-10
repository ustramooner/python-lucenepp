
import os, sys, lucene

sys.path.append(os.path.dirname(os.path.abspath(sys.argv[0])))

from lia.searching.Explainer import Explainer
Explainer.main(sys.argv)
