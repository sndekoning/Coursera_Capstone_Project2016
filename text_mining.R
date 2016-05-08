# Retrieving the sampled data.
if(!file.exists("./data/total_lines_sample.RData")){
    print("Sample data not present, sampling data...")
    source("sample.R")
} else{
    print("Sample data present, getting data...")
    load("./data/total_lines_sample.RData")
}

# Loading dependencies.
library(tm)
library(dplyr)
library(SnowballC)
library(RWeka)

#
doc_corpus <- Corpus(VectorSource(total_sample))

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

save(doc_corpus_clean, file = "./data/doc_corpus_clean.RData")

doc_term_matrix <- DocumentTermMatrix(doc_corpus_clean)
sparse_dtm <- removeSparseTerms(doc_term_matrix, sparse =  0.99)

save(doc_term_matrix, file = "./data/doc_term_matrix.RData")
save(sparse_dtm, file = "./data/sparse_dtm.Rdata")
