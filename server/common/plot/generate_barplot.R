# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

GenerateBarplot <- function(data, main, xlab, ylab) {
    # Generates barplot from tweet dataset according to the sentiment value
    #
    # Args:
    #   data: Data, as integer vector, used for plotting barplot
    #   main: Main header on barplot
    #   xlab: X axis label
    #   ylab: y axis label
    #
    # Returns:
    #   Barplot object for plotting.
    barplot(
        table(data), 
        main = main,
        xlab = xlab,
        ylab = ylab,
        col = brewer.pal(8, "Dark2"), 
        border = 'white', 
        axes = F
    )
}
