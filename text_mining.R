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

# Loading dependencies.
library(tm)
library(dplyr)
library(SnowballC)
library(RWeka)

total_sample <- paste(blog_lines_sample, news_lines_sample, twitter_lines_sample)
rm(blog_lines_sample, news_lines_sample, twitter_lines_sample)

# total_sample <- iconv(total_sample, from = "UTF-8", to = "latin1", sub = "")

doc_corpus <- Corpus(VectorSource(total_sample))

# doc_corpus_sample <- Corpus(VectorSource(total_sample[1:50]))

# Getting bad words.

bad_words <- scan("./bad_words.txt", what = "character", sep = "\n")

# Cleaning up the corpus.
remove_url <- function(x) {
    gsub("http[[:alnum:]]*", "", x)
    }

doc_corpus_clean <- doc_corpus %>% 
    tm_map(content_transformer(removePunctuation)) %>%
    tm_map(content_transformer(tolower)) %>%
    tm_map(content_transformer(removeNumbers)) %>%
    tm_map(content_transformer(remove_url)) %>%
    tm_map(stripWhitespace) %>%
    tm_map(removeWords, bad_words) %>%
    tm_map(stripWhitespace)

doc_term_matrix <- DocumentTermMatrix(doc_corpus_clean)
sparse_dtm <- removeSparseTerms(doc_term_matrix, sparse =  0.99)

save(doc_term_matrix, file = "./data/doc_term_matrix.RData")
save(sparse_dtm, file = "./data/sparse_dtm.Rdata")


