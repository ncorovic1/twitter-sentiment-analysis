# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

FscoreAccuracy <- function(precision, recall, b_value = 1, .progress = 'none') {
    # Calculates weighted average of precision and recall known as F1 score.
    #
    # Args:
    #   precision: Testing precision accuracy
    #   recall: Testing recall accuracy
    #   b_value: Coefficient indicating importance of precision over recall
    #   .progress: Enabling or disabling progress print.
    #
    # Returns:
    #   F1 score for the given data

    B <- b_value
    fscore <- ((1 + B ^ 2) * precision * recall) / ((B ^ 2 * precision) + recall)
    return(fscore)
}
