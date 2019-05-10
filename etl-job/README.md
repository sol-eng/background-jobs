# ETL in background jobs

Sometimes there are long running data collection and aggregation tasks (commonly
referred to as ETL). These jobs can be run in the background in order to keep
the current R session free. This can be especially helpful when the background
job saves a small portion of the data initially and then continues running to
collect more data. In this case, the user can use the initial data to experiment
and build an initial analysis, all while the rest of the dataset is being
collected in the background.

This example uses the [`rtweet`](https://rtweet.info/index.html) package to
collect data from Twitter. By default, tweet search queries return at most
18,000 results within a 15 minute window. The `search_tweets` function includes
a `retryonratelimit` parameter that can be used to collect more than 18,000
tweets for a given search. However, this can take a long time to run since it
waits until the 15 minute window has passed in order to submit another query.
Instead of collecting all the data at once, [`etl.R`](etl.R) collects just a few
tweets, saves the results, and then collects more tweets. This way, instead of
waiting for all data to be collected, a user can send `etl.R` to a background
job, then use the preliminary results to start designing an analysis while the
remaining results are being collected.

![](etl.gif)