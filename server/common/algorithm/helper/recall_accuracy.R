# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

RecallAccuracy <- function(data, .progress = 'none') {
    # Calculates recall accuracy based on given predicted data.
    #
    # Args:
    #   data: Tweets given as input data in form of labeled and predicted sentiment value.
    #   .progress: Enabling or disabling progress print.
    #
    # Returns:
    #   Recall accuracy for the given data (mean for all sentiment values)

    positiveMatches <- data[(data$Sentiment == "positive" & data$SentimentPredicted == "positive"), ]
    negativeMatches <- data[(data$Sentiment == "negative" & data$SentimentPredicted == "negative"), ]
    neutralMatches <- data[(data$Sentiment == "neutral" & data$SentimentPredicted == "neutral"), ]

    positiveRelevant <- data[(data$Sentiment == "positive"), ]
    negativeRelevant <- data[(data$Sentiment == "negative"), ]
    neutralRelevant <- data[(data$Sentiment == "neutral"), ]

    positivePrecision <- nrow(positiveMatches) / nrow(positiveRelevant)
    negativePrecision <- nrow(negativeMatches) / nrow(negativeRelevant)
    neutralPrecision <- nrow(neutralMatches) / nrow(neutralRelevant)

    precision <- (positivePrecision + negativePrecision + neutralPrecision) / 3
    return (precision)
}
