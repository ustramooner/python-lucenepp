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
import codecs

from lucene import Document, Field, StringReader


class PlainTextHandler(object):

    def indexFile(self, writer, path):
        f = None
        try:
            f = codecs.open(path, encoding='utf-8')
            text = f.read()
        except Exception:
            raise
        finally:
            if f != None:
              f.close()

        doc = Document()
        doc.add(Field("contents", StringReader(text)))
        doc.add(Field("filename", os.path.abspath(path),
                      Field.Store.YES, Field.Index.NOT_ANALYZED))
        writer.addDocument(doc)

        return doc
