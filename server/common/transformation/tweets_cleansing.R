# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

TweetsCleansing <- function() {
    # Data received as input is cleaned and prepared for sentiment analysis.
    #
    # Returns:
    #   Object that encapsulates transformations based on regex
    require(tm)
    
    transformations <- c(
        function(x) gsub("http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+", "", x, perl = FALSE),
        function(x) gsub('\\s*(?<!\\B|-)\\d+(?!\\B|-)\\s*', "", x, perl = TRUE),
        function(x) gsub(" . ", " ", x, perl = FALSE),
        function(x) gsub("@\\w+[:]?", "", x, perl = FALSE),
        function(x) removeWords(x, c(stopwords(), "rt", "retweet", "can", "are", "that", "the", "rs", "amp", "in", "it", "will"))
    )

    names(transformations) <- c(
        "removeURL",
        "removeAloneDigits",
        "removeSingle",
        "removeAtPeople",
        "removeStopWords"
    )

    return(transformations);
}
