/**
 * @file
 */
#include "src/statement/With.hpp"

#include "src/visitor/all.hpp"

birch::With::With(Expression* single, Statement* braces, Location* loc) :
    Statement(loc),
    Single<Expression>(single),
    Scoped(LOCAL_SCOPE),
    Braced(braces) {
  //
}

birch::With::~With() {
  //
}

birch::Statement* birch::With::accept(Cloner* visitor) const {
  return visitor->clone(this);
}

birch::Statement* birch::With::accept(Modifier* visitor) {
  return visitor->modify(this);
}

void birch::With::accept(Visitor* visitor) const {
  visitor->visit(this);
}
