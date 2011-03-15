/*!
 * \file   generators.i
 * \author Seth R. Johnson
 * \brief  Define generator/iterator for any type

Example:
\code
    SETUP_GENERATOR( std::vector<Cell>::const_iterator )
    ADD_GENERATOR( Mesh, cells,
    std::vector<Cell>::const_iterator, Cell, beginCells, endCells)
\endcode
would be a method to add a \c cells generator method method to the Python class
\c Mesh, when the C++ class \c Mesh has a \c std::vector<Cell> accessed through
methods \c beginCells and \c endCells.

The macro \c ADD_GENERATOR_P would be if the underlying storage were \c
std::vector<Cell*> instead.

Alternatively, for containers of regular objects that provide \c begin(), \c end(), and \c const_iterator, you can use the \c ADD_CONTAINER_ITERATOR macro:
\code
ADD_CONTAINER_ITERATOR( QuadratureSet )
\endcode

\section License

Copyright (c) 2010, Seth R. Johnson
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 * Neither the name of the this project nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 This material is based upon work supported under a National Science
 Foundation Graduate Research Fellowship. Any opinions, findings, conclusions
 or recommendations expressed in this publication are those of the author
 and do not necessarily reflect the views of the National Science
 Foundation.
*/
#ifndef tools_SWIG_generators_i
#define tools_SWIG_generators_i
/*----------------------------------------------------------------------------*/

// Add a Python class to provide iterator objects
%insert("python") %{
class GenericIterator:
    def __init__(self, begin_iter_method, end_method, deref_method, incr_method):
        self.it = begin_iter_method()
        self.incr   = incr_method
        self.end  = end_method
        self.deref  = deref_method

    def __iter__(self): 
        return self
    def next(self):
        if self.end( self.it ): raise StopIteration
        ret = self.deref( self.it )
        self.incr( self.it )
        return ret
%}

//============== GENERIC GENERATOR/ITERATOR WRAPPER SUPPORT ============
//! Thin wrapper for incrementing a certain type of iterator
// only need to define once per iterator type, and we can use the same name
// thanks to overloading (even though this may decrease efficiency)
%define SETUP_GENERATOR( ITERATOR... )
%inline %{
void _iter_incr( ITERATOR* iter )
{
    ++(*iter);
}
%}
%enddef

/*----------------------------------------------------------------------------*/
// Internal method for adding common parts of the generator
%define PYTRT_BASE_ADD_GENERATOR( CLASS, PYMETHOD, ITERATOR, CBEGIN )
    %extend CLASS {
%insert("python") %{
    def PYMETHOD(self):
        "Returns an iterator for PYMETHOD."
        return GenericIterator(
                self._begin_ ## PYMETHOD,
                self._end ## PYMETHOD,
                self._deref_ ## PYMETHOD,
                _iter_incr
                 )
%}
// get the first element in the vector
//TODO: shouldn't this be %newobject?
ITERATOR* _begin_ ## PYMETHOD()
{
    return new ITERATOR( ($self)->CBEGIN() );
}
    }
%enddef
/*----------------------------------------------------------------------------*/
// If the dereferenced iterator is an object
%define ADD_GENERATOR( CLASS, PYMETHOD, ITERATOR, RVALUE, CBEGIN, CEND )

// add the python and begin method
PYTRT_BASE_ADD_GENERATOR( CLASS, PYMETHOD, ITERATOR, CBEGIN )

    %extend CLASS {
//! Dereference the iterator
const RVALUE& _deref_ ## PYMETHOD ## ( const ITERATOR* iter )
{
    // return the POINTER to the dereferenced iterator
    return (**iter);
}
//! returns true if iterator is at end
const bool _end ## PYMETHOD ## ( const ITERATOR* iter )
{
    // if at the end, return NULL
    return ( *iter == ($self)->CEND() );
}
    }
%enddef
/*----------------------------------------------------------------------------*/
// If the dereferenced iterator is a pointer
%define ADD_GENERATOR_P( CLASS, PYMETHOD, ITERATOR, RVALUE, CBEGIN, CEND )

// add the python and begin method
PYTRT_BASE_ADD_GENERATOR( CLASS, PYMETHOD, ITERATOR, CBEGIN )

    %extend CLASS {
//! Dereference the iterator
const RVALUE& _deref_ ## PYMETHOD ## ( const ITERATOR* iter )
{
    // otherwise, return the dereferenced iterator (a pointer)
    return (**iter);
}
//! returns true if iterator is at end
const bool _end ## PYMETHOD ## ( const ITERATOR* iter )
{
    return (*iter == ($self)->CEND() );
}
    }
%enddef
/*----------------------------------------------------------------------------*/
//! For a regular container with "begin" and "end" and "size"
%define ADD_CONTAINER_ITERATOR( CLASS )
    SETUP_GENERATOR( CLASS::const_iterator );
    ADD_GENERATOR( CLASS, __iter__,
            CLASS ## ::const_iterator, CLASS ## ::value_type,
            begin, end)
    %extend CLASS {
    %insert("python") %{
    def __len__(self):
        return self.size()
    %}
    }
%enddef

/*============================================================================*/
#endif

