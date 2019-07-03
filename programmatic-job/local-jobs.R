# Utils ----
estimate_pi <- function(x) {
  mean(x[,1]^2 + x[,2]^2 <= 1) * 4
}

# Start concurrent local jobs
n <- 3
jobs <- replicate(n, rstudioapi::jobRunScript(path = here::here("programmatic-job", "estimate-pi.R")))
