# compile flags
AM_CPPFLAGS = -Wall -DEIGEN_NO_STATIC_ASSERT -DEIGEN_NO_AUTOMATIC_RESIZING=1 -DEIGEN_DONT_PARALLELIZE=1
if DEBUG
AM_CXXFLAGS = $(OPENMP_CXXFLAGS) -O0 -g -fno-inline
else
if TEST
AM_CXXFLAGS = $(OPENMP_CXXFLAGS) -O0 -g -fno-inline -fprofile-abs-path --coverage
else
if RELEASE
AM_CXXFLAGS = $(OPENMP_CXXFLAGS) -O3 -g
else
AM_CXXFLAGS = $(OPENMP_CXXFLAGS)
endif
endif
endif

lib_LTLIBRARIES = libbirch@SUFFIX@.la

libbirch@SUFFIX@_la_SOURCES =  \
  libbirch/Label.cpp \
  libbirch/LabelPtr.cpp \
  libbirch/Memo.cpp \
  libbirch/memory.cpp \
  libbirch/stacktrace.cpp

include_HEADERS = \
  libbirch/libbirch.hpp

nobase_include_HEADERS = \
  libbirch/Allocator.hpp \
  libbirch/Any.hpp \
  libbirch/Array.hpp \
  libbirch/Atomic.hpp \
  libbirch/assert.hpp \
  libbirch/basic.hpp \
  libbirch/Buffer.hpp \
  libbirch/class.hpp \
  libbirch/Collector.hpp \
  libbirch/Copier.hpp \
  libbirch/docs.hpp \
  libbirch/Dimension.hpp \
  libbirch/Eigen.hpp \
  libbirch/EigenFunctions.hpp \
  libbirch/EigenOperators.hpp \
  libbirch/ExitBarrierLock.hpp \
  libbirch/external.hpp \
  libbirch/Fiber.hpp \
  libbirch/FiberState.hpp \
  libbirch/Finisher.hpp \
  libbirch/Freezer.hpp \
  libbirch/Index.hpp \
  libbirch/Init.hpp \
  libbirch/Iterator.hpp \
  libbirch/Label.hpp \
  libbirch/LabelPtr.hpp \
  libbirch/Lazy.hpp \
  libbirch/Length.hpp \
  libbirch/Lock.hpp \
  libbirch/Marker.hpp \
  libbirch/Memo.hpp \
  libbirch/memory.hpp \
  libbirch/mutable.hpp \
  libbirch/Nil.hpp \
  libbirch/Offset.hpp \
  libbirch/Optional.hpp \
  libbirch/Pool.hpp \
  libbirch/Range.hpp \
  libbirch/Reacher.hpp \
  libbirch/ReadersWriterLock.hpp \
  libbirch/Recycler.hpp \
  libbirch/Scanner.hpp \
  libbirch/Semaphore.hpp \
  libbirch/Shape.hpp \
  libbirch/Shared.hpp \
  libbirch/Slice.hpp \
  libbirch/stacktrace.hpp \
  libbirch/Stride.hpp \
  libbirch/SwitchLock.hpp \
  libbirch/thread.hpp \
  libbirch/Tuple.hpp \
  libbirch/type.hpp

dist_noinst_DATA =  \
  Doxyfile \
  LICENSE