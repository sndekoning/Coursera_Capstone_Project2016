# 1. 
# The en_US.blogs.txt  file is how many megabytes?

blog_file <- file.info("./data/final/en_US/en_US.blogs.txt")
blog_file$size / 1024^2

# 2.
# The en_US.twitter.txt has how many lines of text?

lines_twitter <- length(readLines("././data/final/en_US/en_US.twitter.txt"))

# 3.
# What is the length of the longest line seen in any of the three en_US data sets?

library(stringr)
setwd("./data/final/en_US")

file_name <- "en_US.blogs.txt"
con <- file(file_name, open = "r")
blog_lines <- readLines(con)
blog_length <- str_length(blog_lines)
close(con)

blog_max <- max(blog_length)
rm(blog_lines, blog_length)
blog_max

file_name <- "en_US.news.txt"
con <- file(file_name, open = "r")
news_lines <- readLines(con)
news_length <- str_length(news_lines)
close(con)

news_max <- max(news_length)
rm(news_lines, news_length)
news_max

file_name <- "en_US.twitter.txt"
con <- file(file_name, open = "r")
twitter_lines <- readLines(con)
twitter_length <- str_length(twitter_lines)
close(con)

twitter_max <- max(twitter_length)
rm(twitter_lines, twitter_length)
twitter_max

