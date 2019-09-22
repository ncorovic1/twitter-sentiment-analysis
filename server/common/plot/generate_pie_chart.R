# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

GeneratePieChart <- function(negativeCount, neutralCount, positiveCount) {
    # Generates histogram from tweet dataset according to sentiment value
    #
    # Args:
    #   negativeCount: Number of instances marked with negative sentiment
    #   neutralCount: Number of instances marked with neutral sentiment
    #   positiveCount: Number of instances marked with positive sentiment
    #
    # Returns:
    #   Pie chart object for plotting.
    par(mar = c(1, 1, 1, 1))

    sentimentCount <- c(negativeCount, neutralCount, positiveCount)
    
    labels <- c(
        paste("Negative   ", negativeCount), 
        paste("Neutral      ", neutralCount), 
        paste("Positive     ", positiveCount)
    )
    colorPallete <- brewer.pal(length(sentimentCount), 'Dark2')

    pie(sentimentCount, labels = labels, col = colorPallete, radius = 1)
    legend("topleft", legend = labels, fill = colorPallete)
}
