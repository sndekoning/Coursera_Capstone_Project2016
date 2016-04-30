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