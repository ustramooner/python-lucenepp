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

from BaseLuceneTestCase import BaseLuceneTestCase, main
from lucene import *

class Test_Bug1564(BaseLuceneTestCase):

    def setUp(self):
        self.analyzer = StandardAnalyzer(Version.LUCENE_CURRENT)
        self.store = RAMDirectory()

        writer = IndexWriter(self.store, self.analyzer, True,
                             IndexWriter.MaxFieldLength.LIMITED)
        doc = Document()
        doc.add(Field('all', u'windowpane beplaster rapacious \
        catatonia gauntlet wynn depressible swede pick dressmake supreme \
        jeremy plumb theoretic bureaucracy causation chartres equipoise \
        dispersible careen heard',
                      Field.Store.NO, Field.Index.ANALYZED))
        doc.add(Field('id', '1', Field.Store.YES, Field.Index.NO))
        writer.addDocument(doc)
        writer.optimize()
        writer.close()

    def tearDown(self):
        self.analyzer = None
        self.store = None

    def test_bug1564(self):

        searcher = IndexSearcher(self.store, True)
        query = QueryParser(Version.LUCENE_CURRENT, 'all',
                            self.analyzer).parse('supreme')
        topDocs = searcher.search(query, 50)
        self.assertEqual(topDocs.totalHits, 1)


if __name__ == '__main__':
    main()
