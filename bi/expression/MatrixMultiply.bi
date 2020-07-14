/**
 * Lazy matrix multiply.
 */
final class MatrixMultiply(y:Expression<Real[_,_]>,
    z:Expression<Real[_,_]>) < MatrixBinaryExpression<Expression<Real[_,_]>,
    Expression<Real[_,_]>,Real[_,_],Real[_,_],Real[_,_],Real[_,_],
    Real[_,_]>(y, z) {  
  override function doRows() -> Integer {
    return y!.rows();
  }
  
  override function doColumns() -> Integer {
    return z!.columns();
  }

  override function doEvaluate(y:Real[_,_], z:Real[_,_]) -> Real[_,_] {
    return y*z;
  }

  override function doEvaluateGradLeft(d:Real[_,_], x:Real[_,_], y:Real[_,_],
      z:Real[_,_]) -> Real[_,_] {
    return d*transpose(z);
  }

  override function doEvaluateGradRight(d:Real[_,_], x:Real[_,_], y:Real[_,_],
      z:Real[_,_]) -> Real[_,_] {
    return transpose(y)*d;
  }

  override function graftLinearMatrixGaussian() -> TransformLinearMatrix<MatrixGaussian>? {
    r:TransformLinearMatrix<MatrixGaussian>?;
    if !hasValue() {
      x1:MatrixGaussian?;
    
      if (r <- z!.graftLinearMatrixGaussian())? {
        r!.leftMultiply(matrix(y!));
      } else if (x1 <- z!.graftMatrixGaussian())? {
        r <- TransformLinearMatrix<MatrixGaussian>(matrix(y!), x1!);
      }
    }
    return r;
  }
  
  override function graftLinearMatrixNormalInverseGamma(compare:Distribution<Real[_]>) ->
      TransformLinearMatrix<MatrixNormalInverseGamma>? {
    r:TransformLinearMatrix<MatrixNormalInverseGamma>?;
    if !hasValue() {
      x1:MatrixNormalInverseGamma?;

      if (r <- z!.graftLinearMatrixNormalInverseGamma(compare))? {
        r!.leftMultiply(matrix(y!));
      } else if (x1 <- z!.graftMatrixNormalInverseGamma(compare))? {
        r <- TransformLinearMatrix<MatrixNormalInverseGamma>(matrix(y!), x1!);
      }
    }
    return r;
  }

  override function graftLinearMatrixNormalInverseWishart(compare:Distribution<LLT>) ->
      TransformLinearMatrix<MatrixNormalInverseWishart>? {
    r:TransformLinearMatrix<MatrixNormalInverseWishart>?;
    if !hasValue() {
      x1:MatrixNormalInverseWishart?;

      if (r <- z!.graftLinearMatrixNormalInverseWishart(compare))? {
        r!.leftMultiply(matrix(y!));
      } else if (x1 <- z!.graftMatrixNormalInverseWishart(compare))? {
        r <- TransformLinearMatrix<MatrixNormalInverseWishart>(matrix(y!), x1!);
      }
    }
    return r;
  }
}

/**
 * Lazy matrix multiply.
 */
operator (y:Expression<Real[_,_]>*z:Expression<Real[_,_]>) ->
    MatrixMultiply {
  return construct<MatrixMultiply>(y, z);
}

/**
 * Lazy matrix multiply.
 */
operator (y:Real[_,_]*z:Expression<Real[_,_]>) -> MatrixMultiply {
  return box(y)*z;
}

/**
 * Lazy matrix multiply.
 */
operator (y:Expression<Real[_,_]>*z:Real[_,_]) -> MatrixMultiply {
  return y*box(z);
}
