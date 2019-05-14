# Fit a Stan model with a single predictor

# Setup ----
library(rstan)

# Load data ----
iq_env <- new.env()
source("iq-data.R", local = iq_env)

# Train ----
# Single predictor ----
# Fit simple model with single predictor - mother high school
fit <- stan("stan/kidscore_momhs.stan", data = iq_env)

# Save ----
fit@stanmodel@dso <- new("cxxdso")
if (!dir.exists("fitted-models")) dir.create("fitted-models")
saveRDS(fit, file = "fitted-models/multi-fit.rds")