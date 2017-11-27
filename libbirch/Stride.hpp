/**
 * @file
 */
#pragma once

#include "libbirch/global.hpp"

#include <cassert>

namespace bi {
/**
 * Stride. The number of elements to skip between adjacent active elements
 * along a dimension.
 *
 * @ingroup libbirch
 */
template<ptrdiff_t n>
struct Stride {
  static const ptrdiff_t stride_value = n;
  static const ptrdiff_t stride = n;

  Stride(const ptrdiff_t stride) {
    assert(stride == this->stride);
  }
};
template<>
struct Stride<mutable_value> {
  static const ptrdiff_t stride_value = mutable_value;
  ptrdiff_t stride;
  Stride(const ptrdiff_t stride) :
      stride(stride) {
    //
  }
};
}