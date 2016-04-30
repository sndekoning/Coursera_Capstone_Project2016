source("get_data.R")

# Creating smaller workable samples from the 3 data-sets.
setwd("./data/final/en_US")


# Sampling 5% of the lines of the twitter file.
file_name <- "en_US.twitter.txt"
con <- file(file_name, open = "r")
twitter_lines <- readLines(con, encoding = "UTF-8")
close(con)

set.seed(290420161)

twitter_lines_sample <- sample(twitter_lines, size = length(twitter_lines)*.05)

save(twitter_lines_sample, file = "twitter_lines_sample.RData")
rm(list = ls())
gc(verbose = FALSE)

# Sampling 5% of the lines in the news file.
file_name <- "en_US.news.txt"
con <- file(file_name, open = "r")
news_lines <- readLines(con, encoding = "UTF-8")
close(con)

set.seed(290420162)

news_lines_sample <- sample(news_lines, size = length(news_lines)*.05)

save(news_lines_sample, file = "news_lines_sample.RData")
rm(list = ls())
gc(verbose = FALSE)

# Sampling 5% of the lines in the blog file.
file_name <- "en_US.blogs.txt"
con <- file(file_name, open = "r")
blog_lines <- readLines(con, encoding = "UTF-8")
close(con)

set.seed(290420163)

blog_lines_sample <- sample(blog_lines, size = length(blog_lines)*.05)

save(blog_lines_sample, file = "blog_lines_sample.RData")
rm(list = ls())
gc(verbose = FALSE)

setwd("..")
setwd("..")
setwd("..")