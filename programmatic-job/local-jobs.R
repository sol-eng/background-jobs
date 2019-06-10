# Setup ----
library(tidyverse)

# Utils ----
estimate_pi <- function(x) {
  mean(x[,1]^2 + x[,2]^2 <= 1) * 4
}

# Start 5 concurrent local jobs
n <- 3
jobs <- replicate(n, rstudioapi::jobRunScript(path = here::here("programmatic-job", "estimate-pi.R")))

# Monitor job status
# List all Pi output files
pi_files <- fs::dir_ls(here::here("programmatic-job", "output"), regexp = "*.rds$")

# Read all Pi output files and calculate Pi estimates
pi_results <- map_df(pi_files, ~{
  read_rds(.x) %>% 
    as_tibble(.name_repair = ~make.names(., unique = TRUE)) %>% 
    rename("Y" = "X.1") %>% 
    mutate(pi_estimate = cumsum((X^2 + Y^2) <= 1)/row_number() * 4, 
           file = .x)
})

# Output number of rows in each output file
pi_results %>% 
  count(file)

# Estimate Pi using the results in each output file
pi_results %>% 
  group_by(file) %>%
  filter(row_number() == max(row_number()))

pi_results %>% 
  group_by(file) %>%
  summarise(pi_estimate = mean((X^2 + Y^2) <= 1) * 4)

# Visualize convergence in each file
pi_results %>% 
  group_by(file) %>% 
  mutate(obs = row_number() * 25) %>% 
  ggplot(aes(x = obs, y = pi_estimate, group = file)) +
  geom_hline(yintercept = pi, col = "red") +
  # geom_point(alpha = .4) +
  geom_line(alpha = .4) +
  # facet_wrap(~file) +
  theme_minimal() +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "Pi Estimate Convergance",
       y = "Pi Estimate",
       x = "Observation")
