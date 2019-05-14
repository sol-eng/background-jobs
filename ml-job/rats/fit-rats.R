# Example pulled from https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started

y <- as.matrix(read.table('https://raw.github.com/wiki/stan-dev/rstan/rats.txt', header = TRUE))
x <- c(8, 15, 22, 29, 36)
xbar <- mean(x)
N <- nrow(y)
T <- ncol(y)
fit <- rstan::stan("rats.stan")

fit@stanmodel@dso <- new("cxxdso")
saveRDS(fit, "fit.rds")