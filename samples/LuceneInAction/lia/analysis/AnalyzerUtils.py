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

from lucene import \
     SimpleAnalyzer, StandardAnalyzer, StringReader, Version, \
     TermAttribute, PositionIncrementAttribute, TypeAttribute, OffsetAttribute


class AnalyzerUtils(object):

    def main(cls, argv):

        print "SimpleAnalyzer"
        cls.displayTokensWithFullDetails(SimpleAnalyzer(),
                                         "The quick brown fox....")

        print "\n----"
        print "StandardAnalyzer"
        cls.displayTokensWithFullDetails(StandardAnalyzer(Version.LUCENE_CURRENT), "I'll e-mail you at xyz@example.com")

    def setPositionIncrement(cls, source, posIncr):
        attr = source.addAttribute(PositionIncrementAttribute)
        attr.setPositionIncrement(posIncr)

    def getPositionIncrement(cls, source):
        attr = source.addAttribute(PositionIncrementAttribute)
        return attr.getPositionIncrement()

    def setTerm(cls, source, term):
        attr = source.addAttribute(TermAttribute)
        attr.setTermBuffer(term)

    def getTerm(cls, source):
        attr = source.addAttribute(TermAttribute)
        return attr.term()

    def setType(cls, source, type):
        attr = source.addAttribute(TypeAttribute)
        attr.setType(type)

    def getType(cls, source):
        attr = source.addAttribute(TypeAttribute)
        return attr.type()

    def displayTokens(cls, analyzer, text):

        tokenStream = analyzer.tokenStream("contents", StringReader(text))
        term = tokenStream.addAttribute(TermAttribute)

        while tokenStream.incrementToken():
            print "[%s]" %(term.term()),

    def displayTokensWithPositions(cls, analyzer, text):

        stream = analyzer.tokenStream("contents", StringReader(text))
        term = stream.addAttribute(TermAttribute)
        posIncr = stream.addAttribute(PositionIncrementAttribute)

        position = 0
        while stream.incrementToken():
            increment = posIncr.getPositionIncrement()
            if increment > 0:
                position = position + increment
                print "\n%d:" %(position),

            print "[%s]" %(term.term()),
        print

    def displayTokensWithFullDetails(cls, analyzer, text):

        stream = analyzer.tokenStream("contents", StringReader(text))

        term = stream.addAttribute(TermAttribute)
        posIncr = stream.addAttribute(PositionIncrementAttribute)
        offset = stream.addAttribute(OffsetAttribute)
        type = stream.addAttribute(TypeAttribute)

        position = 0
        while stream.incrementToken():
            increment = posIncr.getPositionIncrement()
            if increment > 0:
                position = position + increment
                print "\n%d:" %(position),

            print "[%s:%d->%d:%s]" %(term.term(),
                                     offset.startOffset(),
                                     offset.endOffset(),
                                     type.type()),
        print

    def assertAnalyzesTo(cls, analyzer, input, outputs):

        stream = analyzer.tokenStream("field", StringReader(input))
        termAttr = stream.addAttribute(TermAttribute)
        for output in outputs:
            if not stream.incrementToken():
                raise AssertionError, 'stream.incremementToken()'
            if output != termAttr.term():
                raise AssertionError, 'output == termAttr.term())'

        if stream.incrementToken():
            raise AssertionError, 'not stream.incremementToken()'

        stream.close()

    main = classmethod(main)
    setPositionIncrement = classmethod(setPositionIncrement)
    getPositionIncrement = classmethod(getPositionIncrement)
    setTerm = classmethod(setTerm)
    getTerm = classmethod(getTerm)
    setType = classmethod(setType)
    getType = classmethod(getType)
    displayTokens = classmethod(displayTokens)
    displayTokensWithPositions = classmethod(displayTokensWithPositions)
    displayTokensWithFullDetails = classmethod(displayTokensWithFullDetails)
    assertAnalyzesTo = classmethod(assertAnalyzesTo)


if __name__ == "__main__":
    import sys
    AnalyzerUtils.main(sys.argv)
