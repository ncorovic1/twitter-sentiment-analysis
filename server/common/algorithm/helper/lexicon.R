# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

Lexicon <- function() {
    # Creates lexicon for sentiment analysis.
    #
    # Returns:
    #   Lexicon filled with words that indicate certain sentiment, along with their sentiment value.
    
    # Origin: https://github.com/ftan84/twitter-sentiment-R
    positive_words <- scan('./data/dictionary/positive-words.txt', what='character', comment.char=';', quiet = TRUE)
    negative_words <- scan('./data/dictionary/negative-words.txt', what='character', comment.char=';', quiet = TRUE)
    
    positive_words = c(positive_words, 
                       'congrats', 'prizes', 'prize', 'thanks', 'thnx', 'grt', 'gr8', 'plz', 'trending', 'recovering', 
                       'brainstorm', 'leader', 'power', 'powerful', 'latest', 'new', 'horizon')
    negative_words = c(negative_words, 
                       'wtf', 'behind', 'feels', 'ugly', 'back', 'worse' , 'shitty', 'bad', 'no', 'freaking', 'sucks', 
                       'horrible', 'fight', 'fighting', 'arrest', 'not')

    lexicon = list(positive_words = positive_words, negative_words = negative_words)
    return(lexicon)
}
