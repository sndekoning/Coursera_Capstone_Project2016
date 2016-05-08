# === Building a prediction model ===

# Loading dependencies.
library(caret)


# Retrieving data.
if(!file.exists("./data/sparse_dtm.RData") |
   !file.exists("./data/doc_term_matrix.RData") |
   !file.exists("./data/doc_corpus_clean.RData") |
   !file.exists("./data/bi_tokenized_dtm.RData") |
   !file.exists("./data/sparse_bigram_dtm.RData") |
   !file.exists("./data/tri_tokenized_dtm.RData") |
   !file.exists("./data/sparse_trigram_dtm.RData") |
   !file.exists("./data/quad_tokenized_dtm.RData") |
   !file.exists("./data/sparse_quadgram_dtm.RData")){
    print("data not present, running text_mining.R")
    source("./scripts/text_mining.R")
} else{
    print("Data present, getting data...")
    load("./data/doc_term_matrix.RData")
    load("./data/doc_corpus_clean.RData")
    load("./data/sparse_dtm.RData")
    load("./data/bi_tokenized_dtm.RData")
    load("./data/sparse_bigram_dtm.RData")
    load("./data/tri_tokenized_dtm.RData")
    load("./data/sparse_trigram_dtm.RData")
    load("./data/quad_tokenized_dtm.RData")
    load("./data/sparse_quadgram_dtm.RData")
}


# Partitioning into training and testing sets.