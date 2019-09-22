# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

BagOfWords <- function(sentences, .progress = 'none') {
    # Calculates sentiment of sentence as a difference between positive and negative score.
    # Positive score represents number of words with a indication of positive sentiment. 
    # Negative score represents number of words with a indication of negative sentiment. 
    #
    # Args:
    #   sentences: Tweets given as input data in form of sentences.
    #   .progress: Enabling or disabling progress print.
    #
    # Returns:
    #   Dataframe with words from sentences reveived as input and their corresponding sentiment score.
    require(plyr)
    require(stringr)
    
    source("server/common/algorithm/helper/lexicon.R", local = TRUE)
    lexicon <- Lexicon()

    positive_words = unlist(lexicon["positive_words"])
    negative_words = unlist(lexicon["negative_words"])

    sentences <- as.factor(sentences)

    scores = laply(sentences, function(sentence, positive_words, negative_words) {
        word.list <- str_split(sentence, '\\s+')
        words <- unlist(word.list)
        
        positive_matches <- match(words, positive_words)
        positive_matches <- !is.na(positive_matches)

        negative_matches <- match(words, negative_words)
        negative_matches <- !is.na(negative_matches)

        score <- sum(positive_matches) - sum(negative_matches)
        return(score)
    }, positive_words, negative_words, .progress = .progress)
    
    scores.df <- data.frame(Text = sentences, Score = scores)

    return(scores.df)
}
