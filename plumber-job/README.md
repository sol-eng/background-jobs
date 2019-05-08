# Plumber APIs in background jobs
Plumber APIs can be run in local background jobs. This promotes a workflow of running an API in a background job and then interacting with that API from the original R session.

## Starting the API
To run a Plumber API as a background job, create an [`entrypoint.R`](entrypoint.R) file that creates and starts the Plumber router. If you want to utilize Swagger with your API, make sure to specify `swagger = TRUE` in the `run` method. Then start a local job in the Jobs pane by clicking on *Start Local Job*. 

## Using Swagger
Once the background job starts, the Jobs pane will provide the URL for the API (if Swagger was enabled). You can open this URL in the RStudio Viewer pane with `rstudioapi::viewer(<URL>)`.

## Interacting with the API
Now that the API is running in the background, you can use your original R session to interact with the API and verify that everything is working as expected. [`api-check.R`](api-check.R) provides an example of such interaction.

![](../images/api-viewer.gif)