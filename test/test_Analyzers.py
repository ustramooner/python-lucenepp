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
from BaseTokenStreamTestCase import BaseTokenStreamTestCase

class AnalyzersTestCase(BaseTokenStreamTestCase):
    """
    Unit tests ported from Java Lucene
    """

    def testSimple(self):

        a = SimpleAnalyzer()
        self._assertAnalyzesTo(a, "foo bar FOO BAR", 
                               [ "foo", "bar", "foo", "bar" ])
        self._assertAnalyzesTo(a, "foo      bar .  FOO <> BAR", 
                               [ "foo", "bar", "foo", "bar" ])
        self._assertAnalyzesTo(a, "foo.bar.FOO.BAR", 
                               [ "foo", "bar", "foo", "bar" ])
        self._assertAnalyzesTo(a, "U.S.A.", 
                               [ "u", "s", "a" ])
        self._assertAnalyzesTo(a, "C++", 
                               [ "c" ])
        self._assertAnalyzesTo(a, "B2B", 
                               [ "b", "b" ])
        self._assertAnalyzesTo(a, "2B", 
                               [ "b" ])
        self._assertAnalyzesTo(a, "\"QUOTED\" word", 
                               [ "quoted", "word" ])


    def testNull(self):

        a = WhitespaceAnalyzer()
        self._assertAnalyzesTo(a, "foo bar FOO BAR", 
                               [ "foo", "bar", "FOO", "BAR" ])
        self._assertAnalyzesTo(a, "foo      bar .  FOO <> BAR", 
                               [ "foo", "bar", ".", "FOO", "<>", "BAR" ])
        self._assertAnalyzesTo(a, "foo.bar.FOO.BAR", 
                               [ "foo.bar.FOO.BAR" ])
        self._assertAnalyzesTo(a, "U.S.A.", 
                               [ "U.S.A." ])
        self._assertAnalyzesTo(a, "C++", 
                               [ "C++" ])
        self._assertAnalyzesTo(a, "B2B", 
                               [ "B2B" ])
        self._assertAnalyzesTo(a, "2B", 
                               [ "2B" ])
        self._assertAnalyzesTo(a, "\"QUOTED\" word", 
                               [ "\"QUOTED\"", "word" ])

    def testStop(self):

        a = StopAnalyzer(Version.LUCENE_CURRENT)
        self._assertAnalyzesTo(a, "foo bar FOO BAR", 
                               [ "foo", "bar", "foo", "bar" ])
        self._assertAnalyzesTo(a, "foo a bar such FOO THESE BAR", 
                               [ "foo", "bar", "foo", "bar" ])

    def _verifyPayload(self, ts):

        payloadAtt = ts.getAttribute(PayloadAttribute.class_)
        b = 0
        while True:
            b += 1
            if not ts.incrementToken():
                break
            self.assertEqual(b, payloadAtt.getPayload().toByteArray()[0])


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
