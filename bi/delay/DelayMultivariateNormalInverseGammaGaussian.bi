/**
 * Multivariate normal-inverse-gamma-Gaussian random variable with delayed
 * sampling.
 */
class DelayMultivariateNormalInverseGammaGaussian(x:Random<Real[_]>,
    μ:DelayMultivariateNormalInverseGamma) < DelayValue<Real[_]>(x) {
  /**
   * Mean.
   */
  μ:DelayMultivariateNormalInverseGamma <- μ;

  function doSimulate() -> Real[_] {
    return simulate_multivariate_normal_inverse_gamma_gaussian(μ.μ, μ.Λ,
        μ.σ2.α, μ.σ2.β);
  }
  
  function doObserve(x:Real[_]) -> Real {
    return observe_multivariate_normal_inverse_gamma_gaussian(x, μ.μ, μ.Λ,
        μ.σ2.α, μ.σ2.β);
  }

  function doCondition(x:Real[_]) {
    (μ.μ, μ.Λ, μ.σ2.α, μ.σ2.β) <- update_multivariate_normal_inverse_gamma_gaussian(
        x, μ.μ, μ.Λ, μ.σ2.α, μ.σ2.β);
  }
}
