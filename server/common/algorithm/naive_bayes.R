# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

NaiveBayes <- function(data, trainProportion, .progress = 'none') {
    # Creates model based on labeled data while using Naive Bayes algorithm.
    #
    # Args:
    #   data: Tweets given as input data in form of text and labeled sentiment.
    #   trainProportion: Proportion between amoung of data used for training and data used for test
    #   .progress: Enabling or disabling progress print.
    #
    # Returns:
    #   List with data used for testing purpose, along with summary matrix.

    source("server/common/transformation/tweets_partitioning.R", local = TRUE)
   
    # Partition tweets in train and test group
    tweets <- TweetsPartitioning(data, trainProportion)
    dataSorted <- tweets$data
    dataTrain <- tweets$train
    dataTest <- tweets$test

    # Build document-term matrix
    dataMatrix <- as.matrix(create_matrix(dataSorted[, 1], language = "english"))
    dataMatrixTrain <- dataMatrix[1 : nrow(dataTrain), ]
    dataMatrixTest <- dataMatrix[(nrow(dataTrain) + 1) : nrow(dataSorted), ]

    # Library containing Naive Bayes algorithm implementation
    require("e1071")

    # Train the model
    classifier <- naiveBayes(dataMatrixTrain, as.factor(dataTrain[, 2]) )

    predicted <- predict(classifier, dataMatrixTest)

    dataContainer <- create_container(
        dataMatrix, 
        as.numeric(as.factor(dataSorted[, 2])),
        trainSize = 1 : nrow(dataTrain), 
        testSize = (nrow(dataTrain) + 1) : nrow(dataSorted), 
        virgin = FALSE
    )

    # Fake prediction object in order to satisfy analytics creation functions
    # Needs to have column named after one of the algorithms used in RTextTools
    # BAGGING_PROB is present to satisfy method needs (arbitrary value chosen)
    prediction <- as.data.frame(cbind(BAGGING_LABEL = predicted, BAGGING_PROB = 0.5))

    # Analytics data (column labels need to be set to match naive bayes not bagging)
    summaryMatrix <- create_precisionRecallSummary(dataContainer, prediction)
    colnames(summaryMatrix) <- c("NBAYES_PRECISION", "NBAYES_RECALL", "NBAYES_FSCORE")

    # Test data along with predicted sentiment column placed on 3rd place
    predictedData <- cbind(dataTest[, 1 : 2], SentimentPredicted = predicted)

    if (ncol(dataTest) > 3)
        predictedData <- cbind(predictedData, dataTest[, 3 : ncol(dataTest)])

    return(
        list(
            predictedData = predictedData, 
            summaryMatrix = summaryMatrix 
        )
    )
}
