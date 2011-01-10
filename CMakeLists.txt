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

project(clucene-bindings)
cmake_minimum_required(VERSION 2.8)
# include specific modules
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")


FIND_PACKAGE(SWIG REQUIRED)
#override ${SWIG_USE_FILE} with our own version, because we need to be able to modify the
#the swig'd wrapper before continuing
INCLUDE(${CMAKE_CURRENT_SOURCE_DIR}/cmake/UseSWIG.cmake)


#choose binding lang
SET(BindingLang ""
  CACHE STRING "Name of binding language")

OPTION(ENABLE_GPROF
  "turn on gprof profiling support"
  OFF)
  
OPTION(ENABLE_CYCLE_CHECK
  "turn lucene cyclick checking"
  OFF)

IF ( ENABLE_GPROF )
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pg")
    SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -pg")
    SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -pg")
    SET(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -pg")
ENDIF ( ENABLE_GPROF )

IF ( ENABLE_CYCLE_CHECK )
  ADD_DEFINITIONS(-DLPP_USE_CYCLIC_CHECK)
ENDIF ( ENABLE_CYCLE_CHECK )

STRING(TOLOWER ${BindingLang} bindingLang)
STRING(TOUPPER ${BindingLang} BINDINGLang)
IF ( BindingLang STREQUAL "Java" )
  ADD_SUBDIRECTORY(${bindingLang})
ELSEIF ( BindingLang STREQUAL "Python" )
  ADD_SUBDIRECTORY(${bindingLang})
ELSE()
  MESSAGE(FATAL_ERROR "BindingLang must be defined as a valid binding language")
ENDIF()

#set build type
IF(NOT CMAKE_BUILD_TYPE)
    SET(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
      "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel."
      FORCE)
ELSE(NOT CMAKE_BUILD_TYPE)
    MESSAGE( "Compiling as ${CMAKE_BUILD_TYPE}" )
ENDIF(NOT CMAKE_BUILD_TYPE)

#set clucene dir
SET(CLUCENE_INCLUDE /home/ben/dev/lucenexx/lucene3/include)
SET(CLUCENE_LIB /home/ben/dev/lucenexx/llvm2/bin/)

#create the swig target...
file(GLOB_RECURSE lucene_i_sources
  ${clucene-bindings_SOURCE_DIR}/defs/*.i
  ${clucene-bindings-${bindingLang}_SOURCE_DIR}/defs/*.i)
ADD_CUSTOM_COMMAND(
	OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/lucene++${BINDINGLang}_wrap.cxx
  COMMAND 
    bash -c "CLUCENE_INCLUDE=${CLUCENE_INCLUDE} ../swigme -q -s"
  DEPENDS ${lucene_i_sources}
)

INCLUDE_DIRECTORIES(${CLUCENE_INCLUDE} ${LANGUAGE_INCLUDES})
ADD_LIBRARY (
  lucenepp SHARED
  ${CMAKE_CURRENT_BINARY_DIR}/lucene++${BINDINGLang}_wrap.cxx
)
TARGET_LINK_LIBRARIES(lucenepp -llucene++ -L${CLUCENE_LIB})

ADD_CUSTOM_TARGET(
  clucene-binding
  COMMENT "Build ${BindingLang} bindings"
  DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/lucene++${BINDINGLang}_wrap.cxx lucene++
)

