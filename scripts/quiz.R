# 1. 
# The en_US.blogs.txt  file is how many megabytes?

blog_file <- file.info("./data/final/en_US/en_US.blogs.txt")
blog_file$size / 1024^2 #Converting to MB's

# 2.
# The en_US.twitter.txt has how many lines of text?

lines_twitter <- length(readLines("././data/final/en_US/en_US.twitter.txt"))
print(lines_twitter)

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
# rm(twitter_lines, twitter_length)
twitter_max


# 4.
# In the en_US twitter data set, if you divide the number of lines where the 
# word "love" (all lowercase) occurs by the number of lines the word "hate" 
# (all lowercase) occurs, about what do you get?

twitter_love <- grep("love", twitter_lines)
twitter_hate <- grep("hate", twitter_lines)

length(twitter_love)/length(twitter_hate)

# 5.
# The one tweet in the en_US twitter data set that matches the word "biostats" says what?

twitter_biostats <- twitter_lines[grep("biostats", twitter_lines)]
print(twitter_biostats)

# 6.
# How many tweets have the exact characters "A computer once beat me at chess,
# but it was no match for me at kickboxing". (I.e. the line matches those
#characters exactly.)

ln <- "A computer once beat me at chess, but it was no match for me at kickboxing"
twitter_kickbox <- length(grep(ln, twitter_lines))
print(twitter_kickbox)
