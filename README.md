# RStudio 1.2 Background Jobs

[RStudio 1.2](https://www.rstudio.com/products/rstudio/) introduced the ability to send long running R scripts to [local and remote background jobs](https://blog.rstudio.com/2019/03/14/rstudio-1-2-jobs/). Local background jobs are supported by all versions of RStudio, while remote background jobs is a feature of [RStudio Server Pro](https://www.rstudio.com/products/rstudio-server-pro/). Remote jobs are a feature of the [RStudio Job Launcher](https://docs.rstudio.com/job-launcher/), which also supports running interactive R sessions on remote resource managers. The following helps illustrate general use cases for these new features:

<!--
Add clean graphic illustrating local vs remote jobs
-->

These background jobs can be started manually or programatically. As mentioned in [RStudio blog post](https://blog.rstudio.com/2019/03/14/rstudio-1-2-jobs/), local background jobs are ideal for interactive, ad-hoc usage. The [`callr`](https://blog.rstudio.com/2019/03/14/rstudio-1-2-jobs/) package provides a mechanism for orchestrating background R processes. This repository is a collection of resources used to demonstrate various use cases for local and remote background jobs. In many cases, scripts can be run as local or remote jobs. For the resources collected here, :house: indicates resources ideal for local Jobs while :rocket: indicates jobs suited for the Launcher.

<!--
Add note about advantages of Launcher over local jobs
-->

### [Shiny App](shiny-job) :house:
Running a Shiny application as a background job allows the current R session to remain free to work on other things. This can be especially helpful for making changes to the Shiny code and refreshing the app to see the changes in real time.

### [Plumber API](plumber-job) :house:
Similar to Shiny applications, plumber APIs can be run as a background job. This allows the current R session to remain open for things like testing or interacting with the API.

### Extract, Transform, Load (ETL) :house: :rocket:
Background jobs are ideal for long running processes, like loading data from an external database or API.

### [Simulations](simulation-job) :house: :rocket:
Long running tasks like simulation studies are ideal use cases for background jobs.

### Model Fitting :house: :rocket:
Model training, which can often take a long time, is another ideal use cases for background jobs.

### Multiple Models :house: :rocket:
Fitting multiple models in parallel can be accomplished programatically using backgound jobs. 
