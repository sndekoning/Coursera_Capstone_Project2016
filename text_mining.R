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

total_sample <- paste(blog_lines_sample, news_lines_sample, twitter_lines_sample)
doc_corpus <- Corpus(VectorSource(total_sample), readerControl = list(reader=readPlain, language="en_US", load=TRUE))

# Getting bad words.

bad_words <- scan("./bad_words.txt", what = "character", sep = "\n")

# Cleaning up the corpus.
remove_url <- function(x) {
    gsub("http[[:alnum:]]*", "", x)
    }

doc_corpus_clean <- doc_corpus %>% 
    tm_map(content_transformer(removePunctuation)) %>%
    tm_map(content_transformer(removeNumbers)) %>%
    tm_map(content_transformer(remove_url)) %>%
    # tm_map(stripWhitespace) %>%
    # tm_map(removeWords, stopwords("english")) %>%
    # tm_map(removeWords, bad_words) %>%
    # tm_map(stemDocument) %>%
    # tm_map(stripWhitespace) 

doc_term_matrix <- TermDocumentMatrix(doc_corpus_clean)