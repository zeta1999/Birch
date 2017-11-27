/**
 * @file
 *
 * The state of the parser, as seen from C++ code.
 */
#pragma once

#include "libubjpp/value.hpp"

#include <stack>

struct ParserState {
  /**
   * Constructor.
   */
  ParserState();

  /**
   * Get the root value of the data.
   */
  libubjpp::value root();

  /**
   * Push a value onto the stack (used by tokenizer).
   */
  void push(const libubjpp::value& value);

  void member();
  void element();
  void error();

  /**
   * Has the parser failed? Parsers generated by lemon will attempt to recover
   * after an error. This flag is used to annul subsequent calls on the state
   * object.
   */
  bool failed;

  /**
   * Stack of values.
   */
  std::stack<libubjpp::value> values;
};

/**
 * Reduce an object member.
 */
extern "C" void member(ParserState* s);

/**
 * Reduce an array element.
 */
extern "C" void element(ParserState* s);

/**
 * Report a parse error.
 */
extern "C" void error(ParserState* s);