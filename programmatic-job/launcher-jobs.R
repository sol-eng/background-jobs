# Utils ----
estimate_pi <- function(x) {
  mean(x[,1]^2 + x[,2]^2 <= 1) * 4
}

launcher_script <- function(script_path,
                            wd = NULL,
                            cluster = "Kubernetes", 
                            name = "scripted_job", 
                            image = "rstudio/r-session-complete:centos7-1.2.1511-1") {
  rstudioapi::launcherSubmitJob(name = name, 
                                cluster = cluster, 
                                command = "R", 
                                args = c("--slave", "--no-save", "--no-restore"), 
                                stdin = glue::glue("source('{script_path}')"), 
                                container = rstudioapi::launcherContainer(image),
                                workingDirectory = dirname(script_path),
                                tags = c("programmatic-job"))
}

# Start concurrent Launcher jobs
n <- 3
jobs <- purrr::map_chr(1:n, ~launcher_script(here::here("programmatic-job", "estimate-pi.R"), name = glue::glue("scripted_job_{.}")))

# Stop launcher jobs
cancel_jobs <- purrr::map(jobs, rstudioapi::launcherControlJob, "kill")

