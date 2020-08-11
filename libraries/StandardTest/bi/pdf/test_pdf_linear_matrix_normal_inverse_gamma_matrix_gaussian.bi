/*
 * Test linear matrix normal-inverse-gamma Gaussian pdf evaluations.
 */
program test_pdf_linear_matrix_normal_inverse_gamma_matrix_gaussian(
    N:Integer <- 10000, B:Integer <- 500, S:Integer <- 30) {
  m:TestLinearMatrixNormalInverseGammaMatrixGaussian;
  m.initialize();
  handle(m.simulate());
  test_pdf(m.marginal(), 5, 2, N, B, S);
}