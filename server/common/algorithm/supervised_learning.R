# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

SupervisedLearning <- function(algorithm, data, trainProportion, .progress = 'none') {
    # Creates model based on labeled data while using given supervised algorithm.
    #
    # Args:
    #   algorithm: Supervised algorithm used for classifier creation ("MAXENT", "SVM", "RF", "TREE")
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

    dataContainer <- create_container(
        dataMatrix, 
        as.numeric(as.factor(dataSorted[, 2])),
        trainSize = 1 : nrow(dataTrain), 
        testSize = (nrow(dataTrain) + 1) : nrow(dataSorted), 
        virgin = FALSE
    )

    # Library containing supervised algorithm implementation
    require("RTextTools")

    # Train the model
    classifier <- train_models(dataContainer, algorithms = c(algorithm))

    # Predict sentiment
    prediction <- classify_models(dataContainer, classifier)

    # Analytics data
    summaryMatrix <- create_precisionRecallSummary(dataContainer, prediction)

    sentimentPredicted <- 
        ifelse(as.character(prediction[, 1]) == 1, 'negative',
            ifelse(as.character(prediction[, 1]) == 2, 'neutral',
                ifelse(as.character(prediction[, 1]) == 3, 'positive', 'none')))

    # Test data along with predicted sentiment column placed on 3rd place
    predictedData <- cbind(dataTest[, 1 : 2], SentimentPredicted = sentimentPredicted)

    if (ncol(dataTest) > 3)
        predictedData <- cbind(predictedData, dataTest[, 3 : ncol(dataTest)])

    return(
        list(
            predictedData = predictedData, 
            summaryMatrix = summaryMatrix  
        )
    )
}
