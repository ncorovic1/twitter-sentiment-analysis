# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

GenerateWordcloud2 <- function(data, wordNumberLimit) {
    # Generates wordcloud from tweet dataset
    #
    # Args:
    #   data: Data, in data frame format, for which wordcloud is plotted
    #   wordNumberLimit: Maximum number of words to be shown on wordcloud
    #
    # Returns:
    #   Wordcloud2 object for plotting.
    require(wordcloud2)

    data.tm <- data.frame(doc_id = row.names(data), text = as.character(data$Text))
    data.corpus <- Corpus(DataframeSource(data.tm))
    data.tdm <- TermDocumentMatrix(data.corpus)
    data.m <- as.matrix(data.tdm)
    data.v <- sort(rowSums(data.m), decreasing = TRUE)
    data.df <- data.frame(word = names(data.v), freq = data.v)
    data.df <- data.df[1 : wordNumberLimit, ]

    wordcloud2(
      data = data.df,
      size = 3
    )
}
