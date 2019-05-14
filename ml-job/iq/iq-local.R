# Fit multiple Stan models in sequence using local background jobs

# Setup ----
library(rstan)

# Load data ----
iq_env <- new.env()
source("iq-data.R", local = iq_env)

# Train ----
# Single predictor ----
# Fit simple model with single predictor - mother high school
mom_hs <- stan("models/kidscore_momhs.stan", data = iq_env)

# Multiple predictors ----
# Fit model with multiple predictors
mom_hs_iq <- stan("models/kidiq_multi_preds.stan", data = iq_env)

# Multiple predictors with interaction ----
# Fit model with multiple predictors and interaction
mom_int <- stan("models/kidiq_interaction.stan", data = iq_env)