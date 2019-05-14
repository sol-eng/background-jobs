# IQ Models

The resources here provide data and various [Stan models](https://mc-stan.org)
built around the provided data. Specific details about these examples can be
found [here](https://github.com/stan-dev/example-models/tree/master/ARM/Ch.3).

The [`iq-local.R`](iq-local.R) script trains multiple Stan models sequentially,
which is ideal for a local background job.

Scripts that start with `lancher-` can be used to run concurrent Launcher Jobs
to train multiple models in parallel.