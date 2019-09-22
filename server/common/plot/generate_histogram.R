# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

GenerateHistogram <- function(data, bins, main, xlab, ylab) {
    # Generates histogram from tweet dataset according to the sentiment value
    #
    # Args:
    #   data: Data, as integer vector, used for plotting histogram
    #   bins: Number of bins to be shown on histogram
    #   main: Main header on histogram
    #   xlab: X axis label
    #   ylab: y axis label
    #
    # Returns:
    #   Histogram object for plotting.
    hist(
        data, 
        breaks = bins, 
        main = main,
        xlab = xlab,
        ylab = ylab,
        col = brewer.pal(8, "Dark2"), 
        border = 'white', 
        axes = F
    )

    axis(1, at = seq(-10, 10, by = 1), labels = seq(-10, 10, by = 1))
}
