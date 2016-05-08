# === Exploratory Plots ===

# Loading Dependencies.
library(ggplot2)
library(RWeka)
library(tm)


# Retrieving data.
if(!file.exists("./data/sparse_dtm.RData") |
   !file.exists("./data/doc_corpus_clean.RData") |
   !file.exists("./data/sparse_bigram_dtm.RData")){
    print("data not present, running text_mining.R")
    source("./scripts/text_mining.R")
} else{
    print("Data present, getting data...")
    load("./data/sparse_dtm.RData")
    load("./data/doc_term_matrix.RData")
    load("./data/doc_corpus_clean.RData")
    load("./data/sparse_bigram_dtm.RData")
}


# Getting Word Frequencies.
word_frequencies <- sort(colSums(as.matrix(sparse_dtm)), decreasing = TRUE)
word_frequencies_df <- data.frame(word = names(word_frequencies),
                                  frequency = word_frequencies)

word_frequencies_df$word <- factor(word_frequencies_df$word,
                                   levels = word_frequencies_df$word) #Preventing ggplot autosort.


# Frequency plot.
ggplot(word_frequencies_df[1:50, ,], aes(x=word, y=frequency)) +
    geom_bar(stat="identity") +
    xlab("") +
    ylab("Frequency") +
    ggtitle("Top 50 most frequently occurring words over the three datasets") + 
    coord_flip()


# Bigram Frequencies.
twogram_frequencies <- sort(colSums(as.matrix(sparse_ngram_dtm)),
                            decreasing = TRUE)

twogram_frequencies_df <- data.frame(twogram = names(twogram_frequencies),
                                     frequency = twogram_frequencies)

twogram_frequencies_df$twogram <- factor(twogram_frequencies_df$twogram,
                                   levels = twogram_frequencies_df$twogram) #Preventing ggplot autosort.


# Bigram Frequency Plot.
ggplot(twogram_frequencies_df[1:50, ,], aes(x=twogram, y=frequency)) +
    geom_bar(stat="identity") +
    xlab("") +
    ylab("Frequency") +
    ggtitle("Top 50 most frequently occurring 2-Gram word combinations over the three datasets") + 
    coord_flip()