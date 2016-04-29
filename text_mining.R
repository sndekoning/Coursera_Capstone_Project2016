# Retrieving the sampled data.
if(!file.exists("./data/final/en_US/blog_lines_sample.RData")){
    print("Sample data not present, sampling data...")
    source("sample.R")
} else{
    print("Sample data present, getting data...")
    load("./data/final/en_US/blog_lines_sample.RData")
    load("./data/final/en_US/news_lines_sample.RData")
    load("./data/final/en_US/twitter_lines_sample.RData")
}

# Loading dependencies
library(tm)
library(dplyr)

total_sample <- paste(blog_lines_sample, news_lines_sample, twitter_lines_sample)
doc_corpus <- VCorpus(VectorSource(total_sample))

# Getting bad words.
bw_url <- "https://github.com/shutterstock/List-of-Dirty-Naughty-Obscecne-and-Otherwise-Bad-Words/blob/master/en"
download.file(bw_url, "./bad_words.txt")

doc_copus_clean <- doc_corpus %>% 
    tm_map(stripWhitespace) %>%
    tm_map(content_transformer(tolower)) %>%
    tm_map(content_transformer(removePunctuation)) %>%
    tm_map(content_transformer(removeNumbers)) %>%
    tm_map(removeWords, stopwords("english")) %>%
    

doc_term_matrix <- TermDocumentMatrix(doc_corpus)

mx <- as.matrix(doc_term_matrix)