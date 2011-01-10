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

import math

from itertools import izip
from random import randint
from BaseLuceneTestCase import BaseLuceneTestCase, main
from lucene import *

NUM_STRINGS = 6000



class SortTestCase(BaseLuceneTestCase):
    """
    Unit tests for sorting code, ported from Java Lucene
    """

    def __init__(self, *args, **kwds):

        super(SortTestCase, self).__init__(*args, **kwds)

        self.data = [
    #      tracer  contents         int            float           string   custom   i18n               long                  double,                short,                byte,           custom parser encoding'
        [   "A",   "x a",           "5",           "4f",           "c",    "A-3",   u"p\u00EAche",      "10",                  "-4.0",                "3",                  "126",          "J"  ],
        [   "B",   "y a",           "5",           "3.4028235E38", "i",    "B-10",  "HAT",             "1000000000",          "40.0",                "24",                 "1",            "I"  ],
        [   "C",   "x a b c",       "2147483647",  "1.0",          "j",    "A-2",   u"p\u00E9ch\u00E9", "99999999",            "40.00002343",         "125",                "15",           "H"  ],
        [   "D",   "y a b c",       "-1",          "0.0f",         "a",     "C-0",   "HUT",             str(2^63-1),          str(2^-1074),           str(-2^15),           str(-2^7),      "G"  ],
        [   "E",   "x a b c d",     "5",           "2f",           "h",     "B-8",   "peach",           str(-2^63),           str((2-2^52) * 2^1023), str(2^15-1),          str(2^7-1),     "F"  ],
        [   "F",   "y a b c d",     "2",           "3.14159f",     "g",     "B-1",   u"H\u00C5T",        "-44",                "343.034435444",       "-3",                 "0",            "E"  ],
        [   "G",   "x a b c d",     "3",           "-1.0",         "f",     "C-100", "sin",             "323254543543",       "4.043544",            "5",                  "100",          "D"  ],
        [   "H",   "y a b c d",     "0",           "1.4E-45",      "e",     "C-88",  u"H\u00D8T",        "1023423423005",      "4.043545",            "10",                 "-50",          "C"  ],
        [   "I",   "x a b c d e f", "-2147483648", "1.0e+0",       "d",     "A-10",  u"s\u00EDn",        "332422459999",       "4.043546",            "-340",               "51",           "B"  ],
        [   "J",   "y a b c d e f", "4",           ".5",           "b",     "C-7",   "HOT",             "34334543543",        "4.0000220343",        "300",                "2",            "A"  ],
        [   "W",   "g",             "1",           None,           None,    None,    None,              None,                 None,                  None,                 None,           None  ],
        [   "X",   "g",             "1",           "0.1",          None,    None,    None,              None,                 None,                  None,                 None,           None  ],
        [   "Y",   "g",             "1",           "0.2",          None,    None,    None,              None,                 None,                  None,                 None,           None  ],
        [   "Z",   "f g",           None,          None,           None,    None,    None,              None,                 None,                  None,                 None,           None  ],
        ]

    def _getIndex(self, even, odd):

        indexStore = RAMDirectory()
        writer = IndexWriter(indexStore, SimpleAnalyzer(), True,
                             IndexWriter.MaxFieldLength.LIMITED)
        writer.setMaxBufferedDocs(2)
        writer.setMergeFactor(1000)

        for i in xrange(len(self.data)):
            if (i % 2 == 0 and even) or (i % 2 == 1 and odd):
                doc = Document()
                doc.add(Field("tracer", self.data[i][0], Field.Store.YES,
                              Field.Index.NO))
                doc.add(Field("contents", self.data[i][1], Field.Store.NO,
                              Field.Index.ANALYZED))
                if self.data[i][2] is not None:
                    doc.add(Field("int", self.data[i][2], Field.Store.NO,
                                  Field.Index.NOT_ANALYZED))
                if self.data[i][3] is not None:
                    doc.add(Field("float", self.data[i][3], Field.Store.NO,
                                  Field.Index.NOT_ANALYZED))
                if self.data[i][4] is not None:
                    doc.add(Field("string", self.data[i][4], Field.Store.NO,
                                  Field.Index.NOT_ANALYZED))
                if self.data[i][5] is not None:
                    doc.add(Field("custom", self.data[i][5], Field.Store.NO,
                                  Field.Index.NOT_ANALYZED))
                if self.data[i][6] is not None:
                    doc.add(Field("i18n", self.data[i][6], Field.Store.NO,
                                  Field.Index.NOT_ANALYZED))
                if self.data[i][7] is not None:
                    doc.add(Field("long", self.data[i][7], Field.Store.NO,
                                  Field.Index.NOT_ANALYZED))
                if self.data[i][8] is not None:
                    doc.add(Field("double", self.data[i][8], Field.Store.NO,
                                  Field.Index.NOT_ANALYZED))
                if self.data[i][9] is not None:
                    doc.add(Field("short", self.data[i][9], Field.Store.NO,
                                  Field.Index.NOT_ANALYZED))
                if self.data[i][10] is not None:
                    doc.add(Field("byte", self.data[i][10], Field.Store.NO,
                                  Field.Index.NOT_ANALYZED))
                if self.data[i][11] is not None:
                    doc.add(Field("parser", self.data[i][11], Field.Store.NO,
                                  Field.Index.NOT_ANALYZED))
                doc.setBoost(2.0)  # produce some scores above 1.0
                writer.addDocument(doc)
        # writer.optimize()
        writer.close()
        s = IndexSearcher(indexStore, True)
        s.setDefaultFieldSortScoring(True, True)

        return s

    def _getFullIndex(self):
        return self._getIndex(True, True)

    def getFullStrings(self):

        indexStore = RAMDirectory()
        writer = IndexWriter(indexStore, SimpleAnalyzer(), True,
                             IndexWriter.MaxFieldLength.LIMITED)
        writer.setMaxBufferedDocs(4)
        writer.setMergeFactor(97)
        
        for i in xrange(NUM_STRINGS):
            doc = Document()
            num = self.getRandomCharString(self.getRandomNumber(2, 8), 48, 52)
            doc.add(Field("tracer", num, Field.Store.YES, Field.Index.NO))
            # doc.add(Field("contents", str(i), Field.Store.NO,
            #         Field.Index.ANALYZED))
            doc.add(Field("string", num, Field.Store.NO,
                          Field.Index.NOT_ANALYZED))
            num2 = self.getRandomCharString(self.getRandomNumber(1, 4), 48, 50)
            doc.add(Field("string2", num2, Field.Store.NO,
                          Field.Index.NOT_ANALYZED))
            doc.add(Field("tracer2", num2, Field.Store.YES, Field.Index.NO))
            doc.setBoost(2.0)  # produce some scores above 1.0
            writer.setMaxBufferedDocs(self.getRandomNumber(2, 12))
            writer.addDocument(doc)
      
        # writer.optimize()
        # print writer.getSegmentCount()
        writer.close()

        return IndexSearcher(indexStore, True)
  
    def getRandomNumberString(self, num, low, high):

        return ''.join([self.getRandomNumber(low, high) for i in xrange(num)])
  
    def getRandomCharString(self, num):

        return self.getRandomCharString(num, 48, 122)
  
    def getRandomCharString(self, num,  start, end):
        
        return ''.join([chr(self.getRandomNumber(start, end))
                        for i in xrange(num)])
  
    def getRandomNumber(self, low, high):
  
        return randint(low, high)

    def _getXIndex(self):
        return self._getIndex(True, False)

    def _getYIndex(self):
        return self._getIndex(False, True)

    def _getEmptyIndex(self):
        return self._getIndex(False, False)

    def setUp(self):
        self.full = self._getFullIndex()
        self.searchX = self._getXIndex()
        self.searchY = self._getYIndex()
        self.queryX = TermQuery(Term("contents", "x"))
        self.queryY = TermQuery(Term("contents", "y"))
        self.queryA = TermQuery(Term("contents", "a"))
        self.queryE = TermQuery(Term("contents", "e"))
        self.queryF = TermQuery(Term("contents", "f"))
        self.queryG = TermQuery(Term("contents", "g"))

    def tearDown(self):
        self.full = None
        self.searchX = None
        self.searchY = None
        self.queryX = None
        self.queryY = None
        self.queryA = None
        self.queryE = None
        self.queryF = None
        self.queryG = None
    
    def runMultiSorts(self, multi, isFull):
        """
        runs a variety of sorts useful for multisearchers
        """
        sort = Sort()

        sort.setSort(SortField.FIELD_DOC)
        expected = isFull and "ABCDEFGHIJ" or "ACEGIBDFHJ"
        self._assertMatches(multi, self.queryA, sort, expected)

        sort.setSort(SortField("int", SortField.INT))
        expected = isFull and "IDHFGJABEC" or "IDHFGJAEBC"
        self._assertMatches(multi, self.queryA, sort, expected)

        sort.setSort([SortField("int", SortField.INT), SortField.FIELD_DOC])
        expected = isFull and "IDHFGJABEC" or "IDHFGJAEBC"
        self._assertMatches(multi, self.queryA, sort, expected)

        sort.setSort(SortField("int", SortField.INT))
        expected = isFull and "IDHFGJABEC" or "IDHFGJAEBC"
        self._assertMatches(multi, self.queryA, sort, expected)

        sort.setSort([SortField("float", SortField.FLOAT), SortField.FIELD_DOC])
        self._assertMatches(multi, self.queryA, sort, "GDHJCIEFAB")

        sort.setSort(SortField("float", SortField.FLOAT))
        self._assertMatches(multi, self.queryA, sort, "GDHJCIEFAB")

        sort.setSort(SortField("string", SortField.STRING))
        self._assertMatches(multi, self.queryA, sort, "DJAIHGFEBC")

        sort.setSort(SortField("int", SortField.INT, True))
        expected = isFull and "CABEJGFHDI" or "CAEBJGFHDI"
        self._assertMatches(multi, self.queryA, sort, expected)

        sort.setSort(SortField("float", SortField.FLOAT, True))
        self._assertMatches(multi, self.queryA, sort, "BAFECIJHDG")

        sort.setSort(SortField("string", SortField.STRING, True))
        self._assertMatches(multi, self.queryA, sort, "CBEFGHIAJD")

        sort.setSort([SortField("int", SortField.INT),
                      SortField("float", SortField.FLOAT)])
        self._assertMatches(multi, self.queryA, sort, "IDHFGJEABC")

        sort.setSort([SortField("float", SortField.FLOAT),
                      SortField("string", SortField.STRING)])
        self._assertMatches(multi, self.queryA, sort, "GDHJICEFAB")

        sort.setSort(SortField("int", SortField.INT))
        self._assertMatches(multi, self.queryF, sort, "IZJ")

        sort.setSort(SortField("int", SortField.INT, True))
        self._assertMatches(multi, self.queryF, sort, "JZI")

        sort.setSort(SortField("float", SortField.FLOAT))
        self._assertMatches(multi, self.queryF, sort, "ZJI")

        sort.setSort(SortField("string", SortField.STRING))
        self._assertMatches(multi, self.queryF, sort, "ZJI")

        sort.setSort(SortField("string", SortField.STRING, True))
        self._assertMatches(multi, self.queryF, sort, "IJZ")

        # up to this point, all of the searches should have "sane" 
        # FieldCache behavior, and should have reused hte cache in several
        # cases 
        self._assertSaneFieldCaches(self.getName() + " various")
        
        # next we'll check Locale based(String[]) for 'string', so purge first
        FieldCache.DEFAULT.purgeAllCaches()

        sort.setSort([SortField("string", Locale("en_US.utf8"))])
        self._assertMatches(multi, self.queryA, sort, "DJAIHGFEBC")

        sort.setSort([SortField("string", Locale("en_US.utf8"), True)])
        self._assertMatches(multi, self.queryA, sort, "CBEFGHIAJD")

        sort.setSort([SortField("string", Locale("en_GB.utf8"))])
        self._assertMatches(multi, self.queryA, sort, "DJAIHGFEBC")

        self._assertSaneFieldCaches(self.getName() + " Locale.US + Locale.UK")
        FieldCache.DEFAULT.purgeAllCaches()


    def _assertMatches(self, searcher, query, sort, expectedResult):
        """
        make sure the documents returned by the search match the expected
        list
        """

        # ScoreDoc[] result = searcher.search(query, None, 1000, sort).scoreDocs
        hits = searcher.search(query, None, len(expectedResult), sort)
        sds = hits.scoreDocs

        self.assertEqual(hits.totalHits, len(expectedResult))
        buff = []
        for sd in sds:
            doc = searcher.doc(sd.doc)
            v = doc.getValues("tracer")
            for _v in v:
                buff.append(_v)

        self.assertEqual(expectedResult, ''.join(buff))

    def getScores(self, hits, searcher):

        scoreMap = {}
        for hit in hits:
            doc = searcher.doc(hit.doc)
            v = doc.getValues("tracer")
            self.assertEqual(len(v), 1)
            scoreMap[v[0]] = hit.score

        return scoreMap

    def _assertSameValues(self, m1, m2):
        """
        make sure all the values in the maps match
        """
          
        self.assertEquals(len(m1), len(m2))
        for key in m1.iterkeys():
            self.assertEquals(m1[key], m2[key], 1e-6)

    def getName(self):

        return type(self).__name__

    def _assertSaneFieldCaches(self, msg):

        entries = FieldCache.DEFAULT.getCacheEntries()

        insanity = FieldCacheSanityChecker.checkSanity(entries)
        self.assertEqual(0, len(insanity),
                         msg + ": Insane FieldCache usage(s) found")

        



    def testBuiltInSorts(self):
        """
        test the sorts by score and document number
        """

        sort = Sort()
        self._assertMatches(self.full, self.queryX, sort, "ACEGI")
        self._assertMatches(self.full, self.queryY, sort, "BDFHJ")

        sort.setSort(SortField.FIELD_DOC)
        self._assertMatches(self.full, self.queryX, sort, "ACEGI")
        self._assertMatches(self.full, self.queryY, sort, "BDFHJ")

    def testTypedSort(self):
        """
        test sorts where the type of field is specified
        """

        sort = Sort()
        
        sort.setSort([SortField("int", SortField.INT),
                      SortField.FIELD_DOC])
        self._assertMatches(self.full, self.queryX, sort, "IGAEC")
        self._assertMatches(self.full, self.queryY, sort, "DHFJB")

        sort.setSort([SortField("float", SortField.FLOAT),
                      SortField.FIELD_DOC])
        self._assertMatches(self.full, self.queryX, sort, "GCIEA")
        self._assertMatches(self.full, self.queryY, sort, "DHJFB")

        #sort.setSort([SortField("long", SortField.LONG),
        #              SortField.FIELD_DOC])
        #self._assertMatches(self.full, self.queryX, sort, "EACGI")
        #self._assertMatches(self.full, self.queryY, sort, "FBJHD")

        sort.setSort([SortField("double", SortField.DOUBLE),
                      SortField.FIELD_DOC])
        self._assertMatches(self.full, self.queryX, sort, "AGICE")
        self._assertMatches(self.full, self.queryY, sort, "DJHBF")

        #sort.setSort([SortField("byte", SortField.BYTE),
        #              SortField.FIELD_DOC])
        #self._assertMatches(self.full, self.queryX, sort, "CIGAE")
        #self._assertMatches(self.full, self.queryY, sort, "DHFBJ")

        #sort.setSort([SortField("short", SortField.SHORT),
        #              SortField.FIELD_DOC])
        #self._assertMatches(self.full, self.queryX, sort, "IAGCE")
        #self._assertMatches(self.full, self.queryY, sort, "DFHBJ")

        sort.setSort([SortField("string", SortField.STRING),
                      SortField.FIELD_DOC])
        self._assertMatches(self.full, self.queryX, sort, "AIGEC")
        self._assertMatches(self.full, self.queryY, sort, "DJHFB")
  
    def testSortCombos(self):
        """
        test sorts using a series of fields
        """
        sort = Sort()

        sort.setSort([SortField("int", SortField.INT),
                      SortField("float", SortField.FLOAT)])
        self._assertMatches(self.full, self.queryX, sort, "IGEAC")

        sort.setSort([SortField("int", SortField.INT, True),
                      SortField("", SortField.DOC, True)])
        self._assertMatches(self.full, self.queryX, sort, "CEAGI")

        sort.setSort([SortField("float", SortField.FLOAT),
                      SortField("string", SortField.STRING)])
        self._assertMatches(self.full, self.queryX, sort, "GICEA")

    def testNormalizedScores(self):
        """
        test that the relevancy scores are the same even if
        hits are sorted
        """

        # capture relevancy scores
        scoresX = self.getScores(self.full.search(self.queryX, None,
                                                  1000).scoreDocs, self.full)
        scoresY = self.getScores(self.full.search(self.queryY, None,
                                                  1000).scoreDocs, self.full)
        scoresA = self.getScores(self.full.search(self.queryA, None,
                                                  1000).scoreDocs, self.full)

        # we'll test searching locally, remote and multi
        multi = MultiSearcher([self.searchX, self.searchY])

        # change sorting and make sure relevancy stays the same

        sort = Sort()
        self._assertSameValues(scoresX, self.getScores(self.full.search(self.queryX, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresX, self.getScores(multi.search(self.queryX, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresY, self.getScores(self.full.search(self.queryY, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresY, self.getScores(multi.search(self.queryY, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresA, self.getScores(self.full.search(self.queryA, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresA, self.getScores(multi.search(self.queryA, None, 1000, sort).scoreDocs, multi))

        sort.setSort(SortField.FIELD_DOC)
        self._assertSameValues(scoresX, self.getScores(self.full.search(self.queryX, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresX, self.getScores(multi.search(self.queryX, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresY, self.getScores(self.full.search(self.queryY, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresY, self.getScores(multi.search(self.queryY, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresA, self.getScores(self.full.search(self.queryA, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresA, self.getScores(multi.search(self.queryA, None, 1000, sort).scoreDocs, multi))

        sort.setSort(SortField("int", SortField.INT))
        self._assertSameValues(scoresX, self.getScores(self.full.search(self.queryX, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresX, self.getScores(multi.search(self.queryX, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresY, self.getScores(self.full.search(self.queryY, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresY, self.getScores(multi.search(self.queryY, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresA, self.getScores(self.full.search(self.queryA, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresA, self.getScores(multi.search(self.queryA, None, 1000, sort).scoreDocs, multi))

        sort.setSort(SortField("float", SortField.FLOAT))
        self._assertSameValues(scoresX, self.getScores(self.full.search(self.queryX, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresX, self.getScores(multi.search(self.queryX, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresY, self.getScores(self.full.search(self.queryY, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresY, self.getScores(multi.search(self.queryY, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresA, self.getScores(self.full.search(self.queryA, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresA, self.getScores(multi.search(self.queryA, None, 1000, sort).scoreDocs, multi))

        sort.setSort(SortField("string", SortField.STRING))
        self._assertSameValues(scoresX, self.getScores(self.full.search(self.queryX, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresX, self.getScores(multi.search(self.queryX, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresY, self.getScores(self.full.search(self.queryY, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresY, self.getScores(multi.search(self.queryY, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresA, self.getScores(self.full.search(self.queryA, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresA, self.getScores(multi.search(self.queryA, None, 1000, sort).scoreDocs, multi))

        sort.setSort([SortField("int", SortField.INT),
                      SortField("float", SortField.FLOAT)])
        self._assertSameValues(scoresX, self.getScores(self.full.search(self.queryX, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresX, self.getScores(multi.search(self.queryX, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresY, self.getScores(self.full.search(self.queryY, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresY, self.getScores(multi.search(self.queryY, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresA, self.getScores(self.full.search(self.queryA, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresA, self.getScores(multi.search(self.queryA, None, 1000, sort).scoreDocs, multi))

        sort.setSort([SortField("int", SortField.INT, True),
                      SortField("", SortField.DOC, True)])
        self._assertSameValues(scoresX, self.getScores(self.full.search(self.queryX, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresX, self.getScores(multi.search(self.queryX, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresY, self.getScores(self.full.search(self.queryY, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresY, self.getScores(multi.search(self.queryY, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresA, self.getScores(self.full.search(self.queryA, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresA, self.getScores(multi.search(self.queryA, None, 1000, sort).scoreDocs, multi))

        sort.setSort([SortField("float", SortField.FLOAT),
                      SortField("string", SortField.STRING)])
        self._assertSameValues(scoresX, self.getScores(self.full.search(self.queryX, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresX, self.getScores(multi.search(self.queryX, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresY, self.getScores(self.full.search(self.queryY, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresY, self.getScores(multi.search(self.queryY, None, 1000, sort).scoreDocs, multi))
        self._assertSameValues(scoresA, self.getScores(self.full.search(self.queryA, None, 1000, sort).scoreDocs, self.full))
        self._assertSameValues(scoresA, self.getScores(multi.search(self.queryA, None, 1000, sort).scoreDocs, multi))

    def testSortWithoutFillFields(self):
        """
        There was previously a bug in TopFieldCollector when fillFields was
        set to False - the same doc and score was set in ScoreDoc[]
        array. This test asserts that if fillFields is False, the documents
        are set properly. It does not use Searcher's default search
        methods(with Sort) since all set fillFields to True.
        """

        sorts = [Sort(SortField.FIELD_DOC), Sort()]
        for sort in sorts:
            q = MatchAllDocsQuery()
            tdc = TopFieldCollector.create(sort, 10, False,
                                           False, False, True)
            self.full.search(q, tdc)
      
            sds = tdc.topDocs().scoreDocs
            for i in xrange(1, len(sds)):
                self.assert_(sds[i].doc != sds[i - 1].doc)

    def testSortWithoutScoreTracking(self):
        """
        Two Sort criteria to instantiate the multi/single comparators.
        """

        sorts = [Sort(SortField.FIELD_DOC), Sort()]
        for sort in sorts:
            q = MatchAllDocsQuery()
            tdc = TopFieldCollector.create(sort, 10, True, False,
                                           False, True)
      
            self.full.search(q, tdc)
      
            tds = tdc.topDocs()
            sds = tds.scoreDocs
            for sd in sds:
                self.assert_(math.isnan(sd.score))

            self.assert_(math.isnan(tds.getMaxScore()))

    def testSortWithScoreNoMaxScoreTracking(self):
        """
        Two Sort criteria to instantiate the multi/single comparators.
        """
        
        sorts = [Sort(SortField.FIELD_DOC), Sort()]
        for sort in sorts:
            q = MatchAllDocsQuery()
            tdc = TopFieldCollector.create(sort, 10, True, True,
                                           False, True)
      
            self.full.search(q, tdc)
      
            tds = tdc.topDocs()
            sds = tds.scoreDocs
            for sd in sds:
                self.assert_(not math.isnan(sd.score))

            self.assert_(math.isnan(tds.getMaxScore()))
  
    def testSortWithScoreAndMaxScoreTracking(self):
        """
        Two Sort criteria to instantiate the multi/single comparators.
        """
        
        sorts = [Sort(SortField.FIELD_DOC), Sort()]
        for sort in sorts:
            q = MatchAllDocsQuery()
            tdc = TopFieldCollector.create(sort, 10, True, True,
                                           True, True)
      
            self.full.search(q, tdc)
      
            tds = tdc.topDocs()
            sds = tds.scoreDocs
            for sd in sds:
                self.assert_(not math.isnan(sd.score))

            self.assert_(not math.isnan(tds.getMaxScore()))

    def testOutOfOrderDocsScoringSort(self):
        """
        Two Sort criteria to instantiate the multi/single comparators.
        """

        sorts = [Sort(SortField.FIELD_DOC), Sort()]

        tfcOptions = [[False, False, False],
                      [False, False, True],
                      [False, True, False],
                      [False, True, True],
                      [True, False, False],
                      [True, False, True],
                      [True, True, False],
                      [True, True, True]]

        actualTFCClasses = [
            "OutOfOrderOneComparatorNonScoringCollector", 
            "OutOfOrderOneComparatorScoringMaxScoreCollector", 
            "OutOfOrderOneComparatorScoringNoMaxScoreCollector", 
            "OutOfOrderOneComparatorScoringMaxScoreCollector", 
            "OutOfOrderOneComparatorNonScoringCollector", 
            "OutOfOrderOneComparatorScoringMaxScoreCollector", 
            "OutOfOrderOneComparatorScoringNoMaxScoreCollector", 
            "OutOfOrderOneComparatorScoringMaxScoreCollector" 
        ]
    
        bq = BooleanQuery()

        # Add a Query with SHOULD, since bw.scorer() returns BooleanScorer2
        # which delegates to BS if there are no mandatory clauses.
        bq.add(MatchAllDocsQuery(), BooleanClause.Occur.SHOULD)

        # Set minNrShouldMatch to 1 so that BQ will not optimize rewrite to
        # return the clause instead of BQ.
        bq.setMinimumNumberShouldMatch(1)

        for sort in sorts:
            for tfcOption, actualTFCClass in izip(tfcOptions,
                                                  actualTFCClasses):
                tdc = TopFieldCollector.create(sort, 10, tfcOption[0],
                                               tfcOption[1], tfcOption[2],
                                               False)
                self.assert_(tdc.getClassName() == actualTFCClass)
          
                self.full.search(bq, tdc)
          
                tds = tdc.topDocs()
                sds = tds.scoreDocs  
                self.assertEqual(10, len(sds))
  
    def testSortWithScoreAndMaxScoreTrackingNoResults(self):
        """
        Two Sort criteria to instantiate the multi/single comparators.
        """

        sorts = [Sort(SortField.FIELD_DOC), Sort()]
        for sort in sorts:
            tdc = TopFieldCollector.create(sort, 10, True, True, True, True)
            tds = tdc.topDocs()
            self.assertEqual(0, tds.totalHits)
            self.assert_(math.isnan(tds.getMaxScore()))

    def testMultiSort(self):
      """
      test a variety of sorts using more than one searcher
      """

      searchers = SearchableCollection()
      searchers.append(self.searchX)
      searchers.append(self.searchY)

      searcher = MultiSearcher(searchers)
      self.runMultiSorts(searcher, False)


if __name__ == "__main__":
    import sys, lucene
    if '-loop' in sys.argv:
        sys.argv.remove('-loop')
        while True:
            try:
                main()
            except:
                pass
#            refs = sorted(env._dumpRefs(classes=True).items(),
#                          key=lambda x: x[1], reverse=True)
#            print refs[0:4]
    else:
        main()
