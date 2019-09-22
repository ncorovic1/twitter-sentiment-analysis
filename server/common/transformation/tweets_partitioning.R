# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

TweetsPartitioning <- function(data, trainProportion, .progress = 'none') {
    # Partitions data into train and test data
    #
    # Args:
    #   data: Tweets given as input data in form of text and labeled sentiment.
    #   trainProportion: Proportion between amoung of data used for training and data used for test
    #   .progress: Enabling or disabling progress print.
    #
    # Returns:
    #   Data partitioned into train and test data

    dataPositive <- data[(data$Sentiment == "positive"),]
    dataNegative <- data[(data$Sentiment == "negative"),]
    dataNeutral <- data[(data$Sentiment == "neutral"),]

    # Split positive train and test tweets
    dataPositiveCount <- nrow(dataPositive)
    dataPositiveTrain <- dataPositive[1 : floor(dataPositiveCount * trainProportion),]
    dataPositiveTest <- dataPositive[(nrow(dataPositiveTrain) + 1) : dataPositiveCount,]

    # Split negative train and test tweets
    dataNegativeCount <- nrow(dataNegative)
    dataNegativeTrain <- dataNegative[1 : floor(dataNegativeCount * trainProportion),]
    dataNegativeTest <- dataNegative[(nrow(dataNegativeTrain) + 1) : dataNegativeCount,]

    # Split neutral train and test tweets
    dataNeutralCount <- nrow(dataNeutral)
    dataNeutralTrain <- dataNeutral[1 : floor(dataNeutralCount * trainProportion),]
    dataNeutralTest <- dataNeutral[(nrow(dataNeutralTrain) + 1) : dataNeutralCount,]

    # Define train and test data
    dataTrain <- rbind(dataPositiveTrain, dataNegativeTrain, dataNeutralTrain)
    dataTest <- rbind(dataPositiveTest, dataNegativeTest, dataNeutralTest)
    dataPartitioned <- rbind(dataTrain, dataTest)

    return(list(data = dataPartitioned, train = dataTrain, test = dataTest))
}
