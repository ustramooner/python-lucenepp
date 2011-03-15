%include "generator.i"

%define LUCENE_HASHSET(Name, Type)
	//TODO: %typemap(javainterfaces) Lucene::Collection<Type> "java.util.Set"
	SWIG_DECLARE_FINAL( (Lucene::HashSet<Type, boost::hash<Type>, std::equal_to<Type> >) )


  ////////////////////////////////////////////////
  //Begin of iterator stuff...
  //Expanded out because macros and templates don't seem to mix...
  ////////////////////////////////////////////////
  
  //swig generator.i iterator base...
  SETUP_GENERATOR( Lucene::HashSet<Type, boost::hash<Type>, std::equal_to<Type> >::const_iterator )

  %extend Lucene::HashSet<Type, boost::hash<Type>, std::equal_to<Type> > {
    //! Dereference the iterator; return NULL if at the end
    const Type& _deref___iter__ ( const Lucene::HashSet<Type, boost::hash<Type>, std::equal_to<Type> >::const_iterator* iter )
    {
        // otherwise, return the POINTER to the dereferenced iterator
        return (**iter);
    }
    const bool _end__iter__ ( const Lucene::HashSet<Type, boost::hash<Type>, std::equal_to<Type> >::const_iterator* iter )
    {
        return *iter == ($self)->end();
    }
    // get the first element in the vector
    //TODO: shouldn't this be %newobject?
    Lucene::HashSet<Type, boost::hash<Type>, std::equal_to<Type> >::const_iterator* _begin__iter__()
    {
        return new Lucene::HashSet<Type, boost::hash<Type>, std::equal_to<Type> >::const_iterator( ($self)->begin() );
    }
    
    %insert("python") %{
      def __iter__(self):
          "Returns an iterator for __iter__."
          return GenericIterator( self._begin__iter__, self._end__iter__, self._deref___iter__, _iter_incr )
      def __contains__(self, v): return self.contains(v)
      def __len__(self): return self.size()
      def __str__(self): return "[" + ", ".join([`item` for item in self]) + "]"
    %}
  }

  //End of iterator stuff
  ////////////////////////////////////////////////
  
	//must be last...
	%template (Name) Lucene::HashSet<Type, boost::hash<Type>, std::equal_to<Type> >;
%enddef

