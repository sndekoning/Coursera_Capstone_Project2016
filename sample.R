source("get_data.R")

# Creating smaller workable samples from the 3 data-sets.
setwd("./data/final/en_US")

file_name <- "en_US.twitter.txt"
con <- file(file_name, open = "r")
twitter_lines <- readLines(con)
close(con)

set.seed(290420161)

sample_rank <- rbinom(2360148, 1, .05)
twitter_df <- data.frame(sample_rank, twitter_lines)
twitter_df <- twitter_df[sample_rank == 1, ,]
twitter_lines_sample <- twitter_df$twitter_lines

# Sampling 5% of the lines in the news file.
file_name <- "en_US.news.txt"
con <- file(file_name, open = "r")
news_lines <- readLines(con)
close(con)

set.seed(290420162)

sample_rank <- rbinom(77259, 1, .05)
news_df <- data.frame(sample_rank, news_lines)
news_df <- news_df[sample_rank == 1, ,]
news_lines_sample <- news_df$news_lines

# Sampling 5% of the lines in the blog file.
file_name <- "en_US.blogs.txt"
con <- file(file_name, open = "r")
blog_lines <- readLines(con)
close(con)

set.seed(290420163)

sample_rank <-rbinom(899288, 1, 0.05)
blog_df <- data.frame(sample_rank, blog_lines)
blog_df <- blog_df[sample_rank == 1, ,]
blog_lines_sample <- blog_df$blog_lines

# Saving the samples for easy later access.
save(blog_lines_sample, file = "blog_lines_sample.RData")
save(news_lines_sample, file = "news_lines_sample.RData")
save(twitter_lines_sample, file = "twitter_lines_sample.RData")

# Cleaning workspace.
rm(list = ls())