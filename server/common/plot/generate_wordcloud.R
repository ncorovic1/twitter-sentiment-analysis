# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

GenerateWordcloud <- function(data, wordNumberLimit) {
    # Generates wordcloud from tweet dataset
    #
    # Args:
    #   data: Data, in data frame format, for which wordcloud is plotted
    #   wordNumberLimit: Maximum number of words to be shown on wordcloud
    #
    # Returns:
    #   Wordcloud object for plotting.
    require(wordcloud)

    data.tm <- data.frame(doc_id=row.names(data), text=as.character(data$Text))
    data.corpus <- Corpus(DataframeSource(data.tm))
    data.tdm <- TermDocumentMatrix(data.corpus)
    data.m <- as.matrix(data.tdm)
    data.v <- sort(rowSums(data.m), decreasing = TRUE)
    data.df <- data.frame(word = names(data.v), freq = data.v)
    # removes plot margins
    par(mar = rep(0, 4))
    set.seed(1234)
    wordcloud(
      data.df$word,
      data.df$freq,
      min.freq = 1,
      max.words = wordNumberLimit,
      scale = c(5, 1),
      colors = brewer.pal(8, "Dark2"),
      random.order=FALSE, 
      rot.per=0.35,
      random.color = T
    )
}
