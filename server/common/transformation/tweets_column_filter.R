# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

TweetsColumnFilter <- function(data) {
    # Data received as input represents raw twitter data and contains, in scope of this research, reduntant columns.
    # Needed columns are defined ("Id", "CreatedAt", "Text", "User", "Favorited", "Retweeted", "IsRetweet")
    # Redundant columns are removed.
    # Id is converted into hex code for easier reading.
    # CreatedAt is converted from timestamp to date time so that it becomes understandable.
    #
    # Args:
    #   data: Data to be cleaned (in data frame format)
    #
    # Returns:
    #   Data received as input, with removed redundant columns.
    require("anytime")
    require("gmp")

    data = data[, c("id", "created", "text", "screenName", "retweetCount")]
    colnames(data) <- c("Id", "CreatedAt", "Text", "User", "Retweeted")

    # from dec to hex for a cleaner view
    data["Id"] <- lapply(data["Id"], function(x) as.character(as.bigz(x), b=16))
    # from UTC (ISO 8601) to a more readable format for a cleaner view
    data["CreatedAt"] <- lapply(data["CreatedAt"], function(x) as.character(anytime(x)))

    return(data)
}
