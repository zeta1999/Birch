/**
 * @file
 */
#pragma once

#include "src/expression/Expression.hpp"

namespace birch {
/**
 * Nil literal.
 *
 * @ingroup expression
 */
class Nil: public Expression {
public:
  /**
   * Constructor.
   *
   * @param loc Location.
   */
  Nil(Location* loc = nullptr);

  /**
   * Destructor.
   */
  virtual ~Nil();

  virtual Expression* accept(Cloner* visitor) const;
  virtual Expression* accept(Modifier* visitor);
  virtual void accept(Visitor* visitor) const;
};
}
