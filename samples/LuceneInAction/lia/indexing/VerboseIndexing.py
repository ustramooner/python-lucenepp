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

import os
import tempfile

from lucene import \
     FSDirectory, Document, Field, IndexWriter, SimpleAnalyzer, InfoStreamOut


class VerboseIndexing(object):

    def main(cls, argv):

        vi = VerboseIndexing()
        vi.index()

    def index(self):

        dirPath = os.path.join(tempfile.gettempdir(),
                               "verbose-index")
        dir = FSDirectory.open(dirPath)
        writer = IndexWriter(dir, SimpleAnalyzer(), True)

        writer.setInfoStream(InfoStreamOut())

        for i in xrange(100):
            doc = Document()
            doc.add(Field("keyword", "goober",
                             Field.Store.YES, Field.Index.NOT_ANALYZED))
            writer.addDocument(doc)

        writer.optimize()
        writer.close()

    main = classmethod(main)


if __name__ == "__main__":
    import sys
    VerboseIndexing.main(sys.argv)
