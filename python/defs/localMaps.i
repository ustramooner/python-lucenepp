%include "generator.i"

%define LUCENE_HASHMAP(Name, Key, Val)
  SWIG_DECLARE_FINAL( (Lucene::HashMap<Key, Val, boost::hash< Key >, std::equal_to< Key > >) )
  
	//must be last...
	%template (Name) Lucene::HashMap<Key, Val, boost::hash<Key>, std::equal_to<Key> >;
%enddef

