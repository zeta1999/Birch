/**
 * @file
 */
#include "bi/io/cpp/CppCoroutineGenerator.hpp"

#include "bi/visitor/Gatherer.hpp"

bi::CppCoroutineGenerator::CppCoroutineGenerator(std::ostream& base,
    const int level, const bool header) :
    CppBaseGenerator(base, level, header),
    state(0) {
  //
}

void bi::CppCoroutineGenerator::visit(const Coroutine* o) {
  /* gather local variables */
  Gatherer<LocalVariable> locals;
  o->accept(&locals);

  /* gather return statements */
  Gatherer<Return> returns;
  o->braces->accept(&returns);

  /* supporting class */
  if (header) {
    line("namespace bi {");
    in();
    line("namespace func {");
    out();
    line(
        "class " << o->name << "Coroutine : public Coroutine<" << o->returnType << "> {");
    line("public:");
    in();
  }

  /* constructor, taking the arguments of the coroutine */
  start("");
  if (!header) {
    middle("bi::func::" << o->name << "Coroutine::");
  }
  middle(o->name << "Coroutine" << o->parens);
  if (header) {
    finish(';');
  } else {
    if (o->parens->tupleSize() > 0) {
      finish(" :");
      in();
      for (auto iter = o->parens->begin(); iter != o->parens->end(); ++iter) {
        if (iter != o->parens->begin()) {
          finish(',');
        }
        auto param = dynamic_cast<const Parameter*>(*iter);
        assert(param);
        start(param->name << '(' << param->name << ')');
      }
      out();
    }
    finish(" {");
    in();
    line("//");
    out();
    line("}\n");
  }

  /* clone function */
  if (!header) {
    start("bi::func::");
  } else {
    start("virtual ");
  }
  middle(o->name << "Coroutine* ");
  if (!header) {
    middle("bi::func::" << o->name << "Coroutine::");
  }
  middle("clone()");
  if (header) {
    finish(";\n");
  } else {
    finish(" {");
    in();
    line("return copy_object(this);");
    out();
    line("}\n");
  }

  /* call function */
  start("");
  if (header) {
    middle("virtual ");
  }
  middle(o->returnType << ' ');
  if (!header) {
    middle("bi::func::" << o->name << "Coroutine::");
  }
  middle("operator()()");
  if (header) {
    finish(';');
  } else {
    finish(" {");
    in();
    if (returns.size() > 0) {
      line("switch (state) {");
      in();
      for (int s = 0; s <= returns.size(); ++s) {
        line("case " << s << ": goto STATE" << s << ';');
      }
      out();
      line('}');
    }

    line("STATE0:");
    ++state;
    *this << o->braces;

    line("state = " << state << ';');
    out();
    finish("}\n");
  }

  if (header) {
    line("");
    out();
    line("private:");
    in();

    /* parameters and local variables as class member variables */
    for (auto iter = o->parens->begin(); iter != o->parens->end(); ++iter) {
      auto param = dynamic_cast<const Parameter*>(*iter);
      assert(param);
      line(param->type << ' ' << param->name << ';');
    }
    for (auto iter = locals.begin(); iter != locals.end(); ++iter) {
      auto param = dynamic_cast<const LocalVariable*>(*iter);
      assert(param);
      line(param->type << ' ' << param->name << param->number << ';');
    }

    out();
    line("};");
    in();
    line("}");
    out();
    line("}\n");
  }

  /* initialisation function */
  if (header) {
    line("namespace bi {");
    in();
    line("namespace func {");
    out();
  }
  start("bi::Fiber<" << o->returnType << "> ");
  if (!header) {
    middle("bi::func::");
  }
  middle(o->name << o->parens);
  if (header) {
    finish(';');
  } else {
    finish(" {");
    in();
    start("return Fiber<" << o->returnType << ">(make_object<");
    middle(o->name << "Coroutine>(");
    for (auto iter = o->parens->begin(); iter != o->parens->end(); ++iter) {
      if (iter != o->parens->begin()) {
        middle(", ");
      }
      const Parameter* param = dynamic_cast<const Parameter*>(*iter);
      assert(param);
      middle(param->name);
    }
    finish("));");
    out();
    finish("}\n");
  }
  if (header) {
    in();
    line("}");
    out();
    line("}\n");
  }
}

void bi::CppCoroutineGenerator::visit(const Return* o) {
  line("state = " << state << "; return " << o->single << ';');
  line("STATE" << state << ": ;");
  ++state;
}

void bi::CppCoroutineGenerator::visit(const Identifier<LocalVariable>* o) {
  middle(o->name << o->target->number);
}

void bi::CppCoroutineGenerator::visit(const LocalVariable* o) {
  if (o->type->isClass() || !o->parens->isEmpty() || !o->value->isEmpty()) {
    middle(o->name << o->number);
    genInit(o);
    ///@todo This will need to resize arrays, overload operator() for Array?
  }
}
