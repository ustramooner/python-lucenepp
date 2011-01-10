
%{
	#include "ChecksumIndexInput.h"
	#include "ChecksumIndexOutput.h"
	#include "LockFactory.h"
	#include "FSLockFactory.h"
	#include "Lock.h"
	#include "NativeFSLockFactory.h"
	#include "SimpleFSLockFactory.h"
	#include "SingleInstanceLockFactory.h"
	#include "NoLockFactory.h"
  #include "RAMFile.h"
  #include "FileSwitchDirectory.h"
%}


//not exposed:
%ignore Lucene::IndexInput;
%ignore Lucene::BufferedIndexOutput;
%ignore Lucene::BufferedIndexInput;
%ignore Lucene::IndexOutput;
%ignore Lucene::ChecksumIndexInput;
%ignore Lucene::ChecksumIndexOutput;
%ignore Lucene::Directory::openInput;
%ignore Lucene::Directory::createOutput;

// store
%include "IndexInput.h";
%include "IndexOutput.h";
%include "BufferedIndexInput.h";
%include "BufferedIndexOutput.h";
%include "Directory.h";
%include "FSDirectory.h";
%include "SimpleFSDirectory.h";
%include "ChecksumIndexInput.h";
%include "ChecksumIndexOutput.h";
%include "FileSwitchDirectory.h";
%include "LockFactory.h";
%include "FSLockFactory.h";
%include "Lock.h";
%include "MMapDirectory.h";
%include "NativeFSLockFactory.h";
%include "NoLockFactory.h";
%include "RAMDirectory.h";
%include "RAMFile.h";
%include "SimpleFSLockFactory.h";
%include "SingleInstanceLockFactory.h";

