# === Building a prediction model ===

# Loading dependencies.
library(caret)


# Retrieving data.
if(!file.exists("./data/sparse_dtm.RData") |
   !file.exists("./data/doc_corpus_clean.RData")){
    print("data not present, running text_mining.R")
    source("text_mining.R")
} else{
    print("Data present, getting data...")
    load("./data/sparse_dtm.RData")
    load("./data/doc_term_matrix.RData")
    load("./data/doc_corpus_clean.RData")
}


# Partitioning into training and testing sets.