# List all Pi output files
pi_files <- fs::dir_ls(here::here("simulation-job", "output"), regexp = "*.rds$")

# Read all Pi output files
pi_results <- purrr::map(pi_files, readRDS)

# Output number of rows in each output file
purrr::map(pi_results, nrow)

# Helper function for estimating Pi
estimate_pi <- function(x) {
  mean(x[,1]^2 + x[,2]^2 <= 1) * 4
}

# Estimate Pi using the results in each output file
purrr::map(pi_results, estimate_pi)
