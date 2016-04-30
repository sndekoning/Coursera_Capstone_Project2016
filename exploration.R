# Retrieving data.
if(!file.exists("./data/sparse_dtm.RData")){
    print("data not present, running text_mining.R")
    source("sample.R")
} else{
    print("Data present, getting data...")
    load("./data/final/en_US/blog_lines_sample.RData")
    load("./data/final/en_US/news_lines_sample.RData")
    load("./data/final/en_US/twitter_lines_sample.RData")
}

# Getting Word Frequencies.
word_frequencies <- sort(colSums(as.matrix(sparse_dtm)), decreasing = TRUE)
word_frequencies_df <- data.frame(word = names(word_frequencies), frequency = word_frequencies)

# Frequency plot.
library(ggplot2)

ggplot(word_frequencies_df[1:50, ,], aes(x=word, y=frequency)) +
    geom_bar(stat="identity") +
    xlab("") +
    ylab("Frequency") +
    ggtitle("Top 50 most frequently occurring words over the three datasets") + 
    coord_flip()