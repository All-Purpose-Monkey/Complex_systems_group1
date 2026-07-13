# Complex Systems Analysis of Beijing PM2.5 (2010–2014)

**Author: Yash Saraswat**

Two-part characterisation of Beijing's fine particulate matter (PM2.5) as a dynamical system, using Empirical Dynamic Modelling (EDM) and fractal/scaling analysis. Instead of fitting a predefined statistical model, both modules reconstruct the system's behaviour directly from the observed time series — asking what *kind* of system PM2.5 is before asking how to predict it.

**Submitted Research Documents:**
- [Module 10 — Empirical Dynamic Modelling of Beijing's PM2.5](https://docs.google.com/document/d/1PJG1devZMyLJtU5hQ6y2E5nJB37x2oAFdfPaGl68I-s/edit?tab=t.0)
- [Module 11 — Fractal and Scaling Analysis (DFA/MF-DFA, PSD, h(q))](https://docs.google.com/document/d/1QdoBgiR9Vp3haXBO-2uLiQw3mkyjVvRwbEa07JLCzh0/edit?usp=sharing)

## Module 10 — Empirical Dynamic Modelling

**Question:** Is Beijing's PM2.5 a deterministic, low-dimensional system, and what drives it?

**Methods:** State-space reconstruction with embedding-dimension estimation (Simplex projection, FNN, Cao's algorithm), S-map for nonlinearity/state dependence, univariate vs. multivariate vs. multiview embeddings, variable ablation, prediction-horizon (Tp) decay analysis, time-varying S-map interaction coefficients, and Convergent Cross Mapping (CCM) for causal directionality.

**Key results:**
- Low-dimensional deterministic system: optimal embedding dimension E = 5–6, peak predictive skill ρ ≈ 0.965 (Simplex) and ρ ≈ 0.972 at θ = 4 (S-map), confirming nonlinear, state-dependent dynamics.
- Largely self-driven: univariate embedding outperforms multivariate and multiview; removing any single meteorological variable barely moves predictive skill.
- Short memory: skill halves by Tp ≈ 15 steps and decays to noise by Tp ≈ 32 — high short-term predictability, chaotic-like information loss beyond that.
- Uni-directional causality (CCM): meteorology (temperature, dew point, pressure, wind) drives PM2.5, not the reverse — PM2.5 acts as a high-fidelity proxy of regional atmospheric state.
- Interaction strengths are episodic and seasonal: wind and rain act as negative "disruptor" forcings during weather events (winter Siberian High, spring dust storms) rather than steady drivers.

## Module 11 — Fractal and Scaling Analysis

**Question:** Does PM2.5 exhibit long-range memory and scale-dependent structure?

**Methods:** Power spectral density (Welch), Detrended Fluctuation Analysis (DFA), Multifractal DFA with h(q) spectra, shuffled-surrogate testing, conditional DFA (weekday/weekend, season, pollution regime), and rolling-window DFA (3-month windows, weekly step) for time-varying exponents.

**Key results:**
- Strong long-range dependence: DFA α ≈ 0.99 vs. α ≈ 0.49 for the shuffled surrogate — persistence comes from temporal ordering, not the value distribution.
- Weak-to-moderate multifractality: MF width ≈ 0.176 with h(q) declining 0.93 → 0.75, meaning large and small fluctuations follow different scaling laws.
- Nonstationary scaling: rolling DFA shows α consistently above 1, systematically strengthening in autumn/winter (heating season, stagnant conditions) across all five years.
- Complexity matching: PM2.5 scaling exponents correlate with dew point (r ≈ 0.33) and wind speed, and anti-correlate with temperature (r ≈ −0.34) — the temporal organisation of pollution partially co-evolves with atmospheric moisture dynamics.

**Combined conclusion:** PM2.5 in Beijing behaves as a low-dimensional, nonlinear, externally forced system with strong but nonstationary memory — highly predictable in the short term, seasonally modulated, and best understood as a memory bank of recent meteorological forcing.

## Tools

Python, pyEDM, NumPy, Pandas, SciPy, statsmodels, MFDFA, Matplotlib.
