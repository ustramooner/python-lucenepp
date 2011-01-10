%ignore Lucene::SortField::getLocale;
%rename (Version) Lucene::LuceneVersion;

//make Document accessible
%extend Lucene::Document {
  %insert("python") %{
    def __getitem__(self, name): return self.get(name)
  %}
}

