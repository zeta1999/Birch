/**
 * @file
 */
#pragma once

#include "src/statement/Statement.hpp"
#include "src/common/Braced.hpp"
#include "src/common/Conditioned.hpp"
#include "src/common/Scoped.hpp"

namespace birch {
/**
 * Block without control flow, but defining a scope.
 *
 * @ingroup statement
 */
class Block: public Statement,
    public Scoped,
    public Braced {
public:
  /**
   * Constructor.
   *
   * @param braces Body of block.
   * @param loc Location.
   */
  Block(Statement* braces, Location* loc = nullptr);

  /**
   * Destructor.
   */
  virtual ~Block();

  virtual Statement* accept(Cloner* visitor) const;
  virtual Statement* accept(Modifier* visitor);
  virtual void accept(Visitor* visitor) const;
};
}
