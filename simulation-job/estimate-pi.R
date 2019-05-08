# Use a monte carlo simulation to estimate pi
n <- 1e6
results_file <- tempfile("pi-", "output", ".rds")
results <- matrix(nrow = n, ncol = 2)

for (i in 1:n) {
  results[i,] <- runif(2)
  # Save out results every 25 iterations
  if (i %% 25 == 0) {
    print(paste0("Saving results (i = ", i, ")"))
    save_results <- results[apply(results, 1, function(x) !all(is.na(x))),]
    print(paste0("Pi estimate: ", mean((save_results[,1]^2 + save_results[,2]^2) <= 1) * 4))
    saveRDS(save_results, results_file)
  }
}
