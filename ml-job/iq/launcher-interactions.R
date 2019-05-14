# Fit a Stan model with interactions

# Setup ----
library(rstan)

# Load data ----
iq_env <- new.env()
source("iq-data.R", local = iq_env)

# Train ----
# Multiple predictors with interaction ----
# Fit model with multiple predictors and interaction
fit <- stan("models/kidiq_interaction.stan", data = iq_env)

# Save ----
fit@stanmodel@dso <- new("cxxdso")
saveRDS(fit, file = "fitted-models/interactions-fit.rds")