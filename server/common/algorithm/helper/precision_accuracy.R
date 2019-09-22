# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

PrecisionAccuracy <- function(data, .progress = 'none') {
    # Calculates precision accuracy based on given predicted data.
    #
    # Args:
    #   data: Tweets given as input data in form of labeled and predicted sentiment value.
    #   .progress: Enabling or disabling progress print.
    #
    # Returns:
    #   Precision accuracy for the given data (mean for all sentiment values)

    epsilon <- 0.0000001

    positiveMatches <- data[(data$Sentiment == "positive" & data$SentimentPredicted == "positive"), ]
    negativeMatches <- data[(data$Sentiment == "negative" & data$SentimentPredicted == "negative"), ]
    neutralMatches <- data[(data$Sentiment == "neutral" & data$SentimentPredicted == "neutral"), ]

    positiveRelevant <- data[(data$SentimentPredicted == "positive"), ]
    negativeRelevant <- data[(data$SentimentPredicted == "negative"), ]
    neutralRelevant <- data[(data$SentimentPredicted == "neutral"), ]

    positivePrecision <- (nrow(positiveMatches) + epsilon) / (nrow(positiveRelevant) + epsilon)
    negativePrecision <- (nrow(negativeMatches) + epsilon) / (nrow(negativeRelevant) + epsilon)
    neutralPrecision <- (nrow(neutralMatches) + epsilon) / (nrow(neutralRelevant) + epsilon)

    delimiter <- (ncol(positiveRelevant) > 1) + (ncol(negativeRelevant) > 1) + (ncol(neutralRelevant) > 1)
    precision <- (positivePrecision + negativePrecision + neutralPrecision) / delimiter

    return (precision)
}
