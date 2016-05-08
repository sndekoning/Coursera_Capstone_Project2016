# === Transforming the sample into workable corpi ===

# Loading dependencies.
library(tm)
library(dplyr)
library(SnowballC)
library(RWeka)


# Retrieving the sampled data.
if(!file.exists("./data/total_lines_sample.RData")){
    print("Sample data not present, sampling data...")
    source("sample.R")
} else{
    print("Sample data present, getting data...")
    load("./data/total_lines_sample.RData")
}


# Converting the sample in corpus.
doc_corpus <- Corpus(VectorSource(total_sample))


# Getting bad words filter.
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


# Creating document term matrix for word frequencies. 
doc_term_matrix <- DocumentTermMatrix(doc_corpus_clean)

sparse_dtm <- removeSparseTerms(doc_term_matrix,
                                sparse =  0.99) # Removing infrequent words.

save(doc_term_matrix, file = "./data/doc_term_matrix.RData")
save(sparse_dtm, file = "./data/sparse_dtm.Rdata")


# Finding common bigrams.
bigram_tokenizer <- function(x) {
    NGramTokenizer(x, Weka_control(min = 2, max = 2))
}

bi_tokenized_dtm <- DocumentTermMatrix(doc_corpus_clean,
                                    control = list(tokenize = bigram_tokenizer))
save(bi_tokenized_dtm, file = "./data/bi_tokenized_dtm.RData")

sparse_bigram_dtm <- removeSparseTerms(bi_tokenized_dtm,
                                       sparse = .99) # Removing infrequent words.
save(sparse_bigram_dtm, file = "./data/sparse_bigram_dtm.RData")


# Finding common trigrams.
trigram_tokenizer <- function(x) {
    NGramTokenizer(x, Weka_control(min = 3, max = 3))
}

tri_tokenized_dtm <- DocumentTermMatrix(doc_corpus_clean,
                                       control = list(tokenize = trigram_tokenizer))
save(tri_tokenized_dtm, file = "./data/tri_tokenized_dtm.RData")

sparse_trigram_dtm <- removeSparseTerms(tri_tokenized_dtm,
                                       sparse = .99) # Removing infrequent words.
save(sparse_trigram_dtm, file = "./data/sparse_trigram_dtm.RData")


# Finding common quadgrams.
quadgram_tokenizer <- function(x) {
    NGramTokenizer(x, Weka_control(min = 4, max = 4))
}

quad_tokenized_dtm <- DocumentTermMatrix(doc_corpus_clean,
                                       control = list(tokenize = quadgram_tokenizer))
save(quad_tokenized_dtm, file = "./data/quad_tokenized_dtm.RData")

sparse_quadgram_dtm <- removeSparseTerms(quad_tokenized_dtm,
                                       sparse = .99) # Removing infrequent words.
save(sparse_quadgram_dtm, file = "./data/sparse_quadgram_dtm.RData")
