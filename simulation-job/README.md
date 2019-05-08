# Simulations as background jobs

Simulations, including Monte Carlo simulations, can often take a long time to
run. This makes them ideal candidates for background jobs. In [this
example](estimate-pi.R), we estimate Pi using a Monte Carlo simulation.

## Start the job
With [`estimate-pi.R`](estimate-pi.R) open, you can either click on the Jobs
pane and then *Start Local Job* or click on Source, then *Source as Local
Job...*. In this example, the job periodically saves out results. This pattern
works for both local and remote jobs, since remote jobs have access to the
specified working directory. If job scripts are saving data, it is best practice
to have each script save data to a unique output file. This prevents concurrent
scripts from attempting to write to the same file.

## Monitor the job
Since the job periodically saves results, you can interactively load and work
with those results in the original R session. [`pi-results.R`](pi-results.R)
provides an example of this pattern.