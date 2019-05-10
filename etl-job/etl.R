# Read data from Twitter API
library(rtweet)

search_term <- "#rstats"
output_file <- "output/tweets.rds"
total_tweets <- 30000
# Collect initial tweets ----
message("Collecting initial 50 tweets")
# Search for 50 tweets with the #rstats hashtag
initial_tweets <- search_tweets(search_term, n = 50, include_rts = FALSE)

# Save initial tweets ----
message("Saving initial tweets")
if (!dir.exists("output")) dir.create("output")
saveRDS(initial_tweets, output_file)

# Search for additional tweets ----
message("Searching for additional tweets")
max_id <- initial_tweets$status_id[which.min(initial_tweets$created_at)]
more_tweets <- search_tweets(search_term, 
                             n = total_tweets - nrow(initial_tweets), 
                             max_id = max_id, 
                             retryonratelimit = TRUE)

# Combine all tweets ----
message("Combining all tweets")
all_tweets <- rbind(initial_tweets[initial_tweets$status_id != max_id,], more_tweets)

# Save all tweets ----
message("Saving all tweets")
saveRDS(all_tweets, output_file)
