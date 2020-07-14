/**
 * Lazy access of a matrix element.
 */
final class MatrixElement<Value>(y:Expression<Value[_,_]>, i:Integer,
    j:Integer) < ScalarExpression<Value> {
  /**
   * Argument.
   */
  y:Expression<Value[_,_]>? <- y;

  /**
   * Row.
   */
  i:Integer <- i;

  /**
   * Column.
   */
  j:Integer <- j;
  
  override function doDepth() -> Integer {
    return y!.depth() + 1;
  }

  override function doValue() -> Value {
    return y!.value()[i,j];
  }

  override function doPilot() -> Value {
    return y!.pilot()[i,j];
  }

  override function doGet() -> Value {
    return y!.get()[i,j];
  }

  override function doMove(κ:Kernel) -> Value {
    return y!.move(κ)[i,j];
  }

  override function doGrad() {
    y!.grad(d!, i, j);
  }

  override function doPrior(vars:RaggedArray<DelayExpression>) ->
      Expression<Real>? {
    return y!.prior(vars);
  }

  override function doConstant() {
    y!.constant();
  }

  override function doCount() {
    y!.count();
  }

  override function doDetach() {
    y <- nil;
  }
}

/**
 * Lazy access of a matrix element.
 */
function MatrixElement(y:Expression<Real[_,_]>, i:Integer, j:Integer) ->
    MatrixElement<Real> {
  return construct<MatrixElement<Real>>(y, i, j);
}

/**
 * Lazy access of a matrix element.
 */
function MatrixElement(y:Expression<Integer[_,_]>, i:Integer, j:Integer) ->
    MatrixElement<Integer> {
  return construct<MatrixElement<Integer>>(y, i, j);
}

/**
 * Lazy access of a matrix element.
 */
function MatrixElement(y:Expression<Boolean[_,_]>, i:Integer, j:Integer) ->
    MatrixElement<Boolean> {
  return construct<MatrixElement<Boolean>>(y, i, j);
}
