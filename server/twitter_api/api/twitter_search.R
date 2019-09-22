# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

TwitterSearch <- function(query, count) {
    # Retrieves defined number of tweets as a result of a defined query.
    #
    # Args:
    #   query: Query upon which is twitter searched.
    #   count: Number of tweets to be fetched.
    #
    # Returns:
    #   Tweets as data fetched from twitter.
    if(!exists("TwitterConnection", mode="function")) {
        source("server/twitter_api/api/twitter_connection.R", local = TRUE)
        TwitterConnection()
    }

    require(twitteR)

    data <- searchTwitter(query, n = count, lang = "en")
    return(data)
}
