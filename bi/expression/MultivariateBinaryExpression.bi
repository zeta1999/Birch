/**
 * Multivariate binary expression.
 *
 * - `Left`: Left argument type. Should derive from `Expression<...>`.
 * - `Right`: Right argument type. Should derive from `Expression<...>`.
 * - `LeftValue`: Left value type. This is the type to which the left
 *    argument evaluates.
 * - `RightValue`: Right value type. This is the type to which the right
 *   argument evaluates.
 * - `LeftGradient`: Left upstream gradient type. This is the type of the
 *   upstream gradient that the left argument accepts. It should be `Real`,
 *   `Real[_]`, or `Real[_,_]`.
 * - `RightGradient`: Right upstrem gradient type. This is the type of the
 *   upstream gradient that the right argument accepts. It should be `Real`,
 *   `Real[_]`, or `Real[_,_]`.
 * - `Value`: The type to which the expression evaluates.
 */
abstract class MultivariateBinaryExpression<Left,Right,LeftValue,RightValue,
    LeftGradient,RightGradient,Value>(y:Left, z:Right) <
    MultivariateExpression<Value> {  
  /**
   * Left argument.
   */
  y:Left? <- y;
  
  /**
   * Right argument.
   */
  z:Right? <- z;

  /*
   * Evaluate.
   */
  abstract function doEvaluate(y:LeftValue, z:RightValue) -> Value;
  
  /*
   * Evaluate the gradient for the left argument.
   */
  abstract function doEvaluateGradLeft(d:Real[_], x:Value, y:LeftValue,
      z:RightValue) -> LeftGradient;

  /*
   * Evaluate the gradient for the right argument.
   */
  abstract function doEvaluateGradRight(d:Real[_], x:Value, y:LeftValue,
      z:RightValue) -> RightGradient;

  final override function doDepth() -> Integer {
    return max(y!.depth(), z!.depth()) + 1;
  }

  final override function doValue() -> Value {
    return doEvaluate(y!.value(), z!.value());
  }

  final override function doPilot() -> Value {
    return doEvaluate(y!.pilot(), z!.pilot());
  }

  final override function doGet() -> Value {
    return doEvaluate(y!.get(), z!.get());
  }

  final override function doMove(κ:Kernel) -> Value {
    return doEvaluate(y!.move(κ), z!.move(κ));
  }
  
  final override function doGrad() {
    y!.grad(doEvaluateGradLeft(d!, x!, y!.get(), z!.get()));
    z!.grad(doEvaluateGradRight(d!, x!, y!.get(), z!.get()));
  }
  
  final override function doPrior(vars:RaggedArray<DelayExpression>) ->
      Expression<Real>? {
    auto l <- y!.prior(vars);
    auto r <- z!.prior(vars);
    if l? && r? {
      return l! + r!;
    } else if l? {
      return l!;
    } else if r? {
      return r!;
    } else {
      return nil;
    }
  }

  final override function doConstant() {
    y!.constant();
    z!.constant();
  }

  final override function doCount() {
    y!.count();
    z!.count();
  }
  
  final override function doDetach() {
    y <- nil;
    z <- nil;
  }
}
