# Retrieving data.
if(!file.exists("./data/sparse_dtm.RData") &
   !file.exists("./data/doc_corpus_clean.RData")){
    print("data not present, running text_mining.R")
    source("text_mining.R")
} else{
    print("Data present, getting data...")
    load("./data/sparse_dtm.RData")
    load("./data/doc_term_matrix.RData")
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

# N-Gram Frequencies.
library(RWeka)
library(tm)

tokenizer_function <- function(x) {NGramTokenizer(x, Weka_control(min = 2, max = 4))}
tokenized_dtm <- DocumentTermMatrix(doc_corpus_clean, control = list(tokenize = tokenizer_function))