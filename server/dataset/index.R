source('data/datasets/dataset_info.R', local = TRUE);
source('server/common/algorithm/helper/algorithm_info.R', local = TRUE);

# checkboxes for preprocessing purpose
cbPreprocessingListPD <- c(
    "cbRemoveNonEnglishTweetsPD", "cbRemovePunctuationPD", "cbRemoveWordsPD", "cbRemoveURLPD", 
    "cbRemoveAtPeoplePD", "cbRemoveAloneDigitsPD", "cbStripWhitespacePD", "cbStemPD", 
    "cbRemoveSingleLettersPD"
)

# On dataset change:
#   Show dataset description
output$oDatasetDescription <- renderUI({ 
    HTML(datasetDescription[input$iDatasetChoice])
})

# On dataset confirmation:
#   Show grid and populate with data from chosen dataset
observeEvent(input$bConfirmDatasetChoice, {
    shinyjs::hide("bConfirmDatasetChoice")
    shinyjs::show("pd-loader")

    datasetFilePath <- paste('data/datasets/cleaned/', datasetFileName[input$iDatasetChoice], sep = "")
    dataPreparedDataset.df <<- read.csv(datasetFilePath, header = TRUE, check.names = FALSE)

    # Set proper encoding and resolve uncommon characters
    dataPreparedDataset.df$Text <- sapply(dataPreparedDataset.df$Text, function(row) {
        iconv(row, "latin1", "ASCII", sub = "")
        gsub("â€™", "'", row)
        gsub("â€", "", row)
    })

    output$tableDatasetTweetsOverview <- DT::renderDataTable(DT::datatable(dataPreparedDataset.df, options = list(pageLength = 10)))

    shinyjs::hide("pd-loader")
    shinyjs::hide("sectionDatasetSelectionExpanded")
    shinyjs::show("sectionDatasetSelectionCollapsed")
    shinyjs::show("sectionPreparedDatasetBody")
    shinyjs::show("bExpandSectionDatasetSelection")
    shinyjs::show("bReloadDataset")
})

# On dataset selection expand button click:
#   Collapse dataset confirmation button and body section
#   Expand dataset selection and confirmation button
observeEvent(input$bExpandSectionDatasetSelection, {
    shinyjs::hide("bExpandSectionDatasetSelection")
    shinyjs::hide("bReloadDataset")
    shinyjs::hide("sectionPreparedDatasetBody")

    setCheckboxes(cbPreprocessingListPD, FALSE)
    
    shinyjs::show("sectionDatasetSelectionExpanded")
    shinyjs::show("bConfirmDatasetChoice")
})

# On reload dataset button click:
#   Reset data to original raw format
observeEvent(input$bReloadDataset, {
    datasetFilePath <- paste('data/datasets/cleaned/', datasetFileName[input$iDatasetChoice], sep = "")
    dataPreparedDataset.df <<- read.csv(datasetFilePath, header = TRUE, check.names = FALSE)
    output$tableDatasetTweetsOverview <- DT::renderDataTable(DT::datatable(dataPreparedDataset.df, options = list(pageLength = 10)))

    setCheckboxes(cbPreprocessingListPD, FALSE)
})

# On select all button click:
#   Tick all checkboxes
observeEvent(input$bMarkAllPD, {
    setCheckboxes(cbPreprocessingListPD, TRUE)
})

# On refresh button click:
#   Apply preprocessing of tweets
observeEvent(input$bRefreshPD, {
    if(!exists("TweetsCleansing", mode = "function")) {
        source("server/common/transformation/tweets_cleansing.R", local = TRUE)
    }

    require(textcat)

    transformations <- TweetsCleansing()

    if (input$cbRemoveNonEnglishTweetsPD) {
        dataPreparedDataset.textcat <- textcat(dataPreparedDataset.df$Text)
        dataPreparedDataset.df.english <- dataPreparedDataset.df[dataPreparedDataset.textcat == "english", ]
        dataPreparedDataset.df.scots <- dataPreparedDataset.df[dataPreparedDataset.textcat == "scots", ]
        dataPreparedDataset.df <- rbind(dataPreparedDataset.df.english, dataPreparedDataset.df.scots)
        # Remove rows with NA values (issue with textcat)
        dataPreparedDataset.df <- na.omit(dataPreparedDataset.df)
        dataPreparedDataset.df <<- na.omit(dataPreparedDataset.df)
        shinyjs::disable("cbRemoveNonEnglishTweetsPD")
    }

    require(tm)

    # Tm package requirement is to have doc_id and text columns
    dataPreparedDataset.tm <- data.frame(doc_id = rownames(dataPreparedDataset.df), text = as.character(dataPreparedDataset.df$Text))
    # remove non-ASCII characters (due to problems with R packages when non-ASCII character is encountered)
    dataPreparedDataset.tm$text <- sapply(dataPreparedDataset.tm$text, function(row) iconv(row, "latin1", "ASCII", sub=""))
    
    dataPreparedDataset.corpus <- Corpus(DataframeSource(dataPreparedDataset.tm))
    dataPreparedDataset.corpus <- tm_map(dataPreparedDataset.corpus, tolower)

    if (input$cbRemoveURLPD) {
        dataPreparedDataset.corpus <- tm_map(dataPreparedDataset.corpus, transformations$removeURL)
        shinyjs::disable("cbRemoveURLPD")
    }

    if (input$cbRemovePunctuationPD) {
        dataPreparedDataset.corpus <- tm_map(dataPreparedDataset.corpus, removePunctuation)
        shinyjs::disable("cbRemovePunctuationPD")
    }

    if (input$cbRemoveAtPeoplePD) {
        dataPreparedDataset.corpus <- tm_map(dataPreparedDataset.corpus, transformations$removeAtPeople)
        shinyjs::disable("cbRemoveAtPeoplePD")
    }

    if (input$cbRemoveWordsPD) {
        dataPreparedDataset.corpus <- tm_map(dataPreparedDataset.corpus, transformations$removeStopWords)
        shinyjs::disable("cbRemoveWordsPD")
    }

    if (input$cbRemoveAloneDigitsPD) {
        dataPreparedDataset.corpus <- tm_map(dataPreparedDataset.corpus, transformations$removeAloneDigits)
        shinyjs::disable("cbRemoveAloneDigitsPD")
    }

    if (input$cbStripWhitespacePD) {
        dataPreparedDataset.corpus <- tm_map(dataPreparedDataset.corpus, stripWhitespace)
        shinyjs::disable("cbStripWhitespacePD")
    }

    if (input$cbRemoveSingleLettersPD) {
        dataPreparedDataset.corpus <- tm_map(dataPreparedDataset.corpus, transformations$removeSingle)
        shinyjs::disable("cbRemoveSingleLettersPD")
    }

    if (input$cbStemPD) {
        stemCompletion2 <- function(x, dictionary) {
            # split each word and store it    
            x <- unlist(strsplit(as.character(x), " "))
            # stemCompletion completes an empty string toa word in dictionary. Remove empty string to avoid issue.
            x <- x[x != ""]
            # This uses Dr. Martin Porter's stemming algorithm and the C libstemmer library generated by Snowball
            x <- stemCompletion(x, dictionary = dictionary, type = "prevalent")
            x <- paste(x, sep = "", collapse = " ")
            PlainTextDocument(stripWhitespace(x))
        }
        dataPreparedDataset.corpus.copy <- dataPreparedDataset.corpus
        dataPreparedDataset.corpus <- tm_map(dataPreparedDataset.corpus, stemDocument) 
        dataPreparedDataset.corpus <- lapply(dataPreparedDataset.corpus, stemCompletion2, dataPreparedDataset.corpus.copy)
        dataPreparedDataset.corpus <- as.VCorpus(dataPreparedDataset.corpus)  
        shinyjs::disable("cbStemPD")
    }

    dataPreparedDataset.tm.corpus <- data.frame(text = sapply(dataPreparedDataset.corpus, as.character), stringsAsFactors = FALSE)
    dataPreparedDataset.df$Text <- dataPreparedDataset.tm.corpus$text
    dataPreparedDataset.df$Text <- sapply(dataPreparedDataset.df$Text, function(row) gsub("â€™", "'", row))
    dataPreparedDataset.df$Text <<- sapply(dataPreparedDataset.df$Text, function(row) gsub("â€", "", row))
    output$tableDatasetTweetsOverview <- DT::renderDataTable(DT::datatable(dataPreparedDataset.df, options = list(pageLength = 10)))
})

# On generate wordcloud button click:
observeEvent(input$bGenerateWordcloudPD, {
    if(!exists("GenerateWordcloud2", mode = "function")) {
        source("server/common/plot/generate_wordcloud2.R", local = TRUE)
    }

    output$wordcloudPreparedDataset <- renderWordcloud2(
        GenerateWordcloud2(dataPreparedDataset.df, input$iWordcloudWordsCountPD) 
    )
})

# On download wordcloud button click, png image is downloaded:
output$dbDownloadWordcloudPD <- downloadHandler(
    paste(datasetTitle[input$iDatasetChoice], "wordcloud.png", sep = " - "),
    # Content is a function with file as an argument. Content writes the plot to the device
    content = function(file) {
        if(!exists("GenerateWordcloud", mode = "function")) {
            source("server/common/plot/generate_wordcloud.R", local = TRUE)
        }

        # Open the png device
        png(file, width = 600, height = 600) 
        GenerateWordcloud(dataPreparedDataset.df, input$iWordcloudWordsCountPD)
        # Turn the device off
        dev.off()  
    },
    contentType = 'png'
)

# On calculate sentiment button click:
observeEvent(input$bCalculateSentimentPD, {
    shinyjs::show("alg-loader")

    if(!exists("BagOfWords", mode = "function")) {
        source("server/common/algorithm/bag_of_words.R", local = TRUE)
    }

    if(!exists("NaiveBayes", mode = "function")) {
        source("server/common/algorithm/naive_bayes.R", local = TRUE)
    }

    if(!exists("SupervisedLearning", mode = "function")) {
        source("server/common/algorithm/supervised_learning.R", local = TRUE)
    }

    chosenAlgorithm <- algorithmCode[input$iAlgorithmChoice]
    chosenRatio <- input$iTrainTestRatio

    switch (
        chosenAlgorithm,
        "BAGGING" = {
            shinyjs::hide("summaryMatrix")
            hideTab(inputId = "preparedDatasetSentimentTabs", target = "K-fold cross-validation")

            algResult <- BagOfWords(dataPreparedDataset.df$Text)
            predicted <-
                ifelse(as.character(algResult$Score) < 3, 'negative',
                    ifelse(as.character(algResult$Score) == 3, 'neutral',
                        ifelse(as.character(algResult$Score) > 3, 'positive', 'none')))
        
            result <<- cbind(dataPreparedDataset.df[, 1 : 2], SentimentPredicted = predicted)

            if (ncol(dataPreparedDataset.df) > 3)
                result <<- cbind(result, dataPreparedDataset.df[, 3 : ncol(dataPreparedDataset.df)])
        },
        "NBAYES" = {
            shinyjs::show("summaryMatrix")
            hideTab(inputId = "preparedDatasetSentimentTabs", target = "K-fold cross-validation")

            algResult <- NaiveBayes(dataPreparedDataset.df, chosenRatio / 100)
            result <<- algResult$predictedData
        },
        {
            shinyjs::show("summaryMatrix")
            showTab(inputId = "preparedDatasetSentimentTabs", target = "K-fold cross-validation")

            algResult <- SupervisedLearning(chosenAlgorithm, dataPreparedDataset.df, chosenRatio / 100)
            result <<- algResult$predictedData
        }
    )

    # Main data grid table
    output$tablePreparedDatasetTweetsSentimentOverview <- DT::renderDataTable(
        DT::datatable(result[, 1 : 3], options = list(pageLength = 25))
    )

    if(!exists("PrecisionAccuracy", mode = "function")) {
        source("server/common/algorithm/helper/precision_accuracy.R", local = TRUE)
    }

    if(!exists("RecallAccuracy", mode = "function")) {
        source("server/common/algorithm/helper/recall_accuracy.R", local = TRUE)
    }

    if(!exists("FscoreAccuracy", mode = "function")) {
        source("server/common/algorithm/helper/fscore_accuracy.R", local = TRUE)
    }

    # Precision, recall and fscore overall accuracy
    precision <- PrecisionAccuracy(result[, 2 : 3])
    recall <- RecallAccuracy(result[, 2 : 3])
    fscore <- FscoreAccuracy(precision, recall, 1)

    output$precisionAccuracyValue <- renderText({ precision })
    output$recallAccuracyValue <- renderText({ recall })
    output$fscoreAccuracyValue <- renderText({ fscore })

    labeledSentiment <- result$Sentiment
    predictedSentiment <- result$SentimentPredicted

    # Confusion matrix table
    output$confusionMatrixTablePD <- renderTable(
        { 
            as.data.frame.matrix(
                table(
                    as.factor(labeledSentiment), 
                    as.factor(predictedSentiment)
                )
            ) 
        },
        rownames = TRUE
    ) 

    # Summary matrix table (precision, recall and fscore per sentiment category)
    if (chosenAlgorithm != "BAGGING") {
        output$summaryMatrixTablePD <- renderTable(
            { 
                tableData <- algResult$summaryMatrix
                rownames(tableData) <- c("negative", "neutral", "positive")
                return(tableData)
            },
            rownames = TRUE
        ) 
    }

    shinyjs::show("sectionPreparedDatasetSentimentOverview")

    # Pie Chart tab drawings
    require("RColorBrewer")

    if(!exists("GeneratePieChart", mode = "function")) {
        source("server/common/plot/generate_pie_chart.R", local = TRUE)
    }

    output$pieChartSentimentAllPD <- renderPlot({
        GeneratePieChart(
            sum(result$Sentiment == "negative"),
            sum(result$Sentiment == "neutral"),
            sum(result$Sentiment == "positive")            
        )
    })

    output$pieChartSentimentAllPredictedPD <- renderPlot({
        GeneratePieChart(
            sum(result$SentimentPredicted == "negative"),
            sum(result$SentimentPredicted == "neutral"),
            sum(result$SentimentPredicted == "positive")            
        )
    })

    shinyjs::hide("alg-loader")
})

# On cross validation button click:
observeEvent(input$bCrossValidatePD, {
    # Library containing k-fold cross-validation implementation
    require("RTextTools")

    numberOfFolds = input$iCrossValidationFolds
    chosenAlgorithm <- algorithmCode[input$iAlgorithmChoice]

    dataMatrix <- as.matrix(create_matrix(dataPreparedDataset.df[, 1], language = "english"))
    trainCount <- floor(length(dataPreparedDataset.df[, 1]) * input$iTrainTestRatio / 100)

    dataContainer <- create_container(
        dataMatrix, 
        as.numeric(as.factor(dataPreparedDataset.df[, 2])),
        trainSize = 1 : trainCount, 
        testSize = (trainCount + 1) : nrow(dataPreparedDataset.df), 
        virgin = FALSE
    )

    crossValidationResult <- cross_validate(dataContainer, numberOfFolds, chosenAlgorithm)

    foldResults <- crossValidationResult[[1]]
    meanAccuracy <- crossValidationResult[[2]]

    output$crossValidationResults <- renderUI({
        resultsForPrint <- ''

        i <- 1
        for (foldResult in foldResults) {
            resultsForPrint <- paste(
                resultsForPrint, "<br/>", "Fold ", i, " Out of Sample Accuracy:", round(foldResult, 2),
                sep = " "
            )
            i <- i + 1
        }

        HTML(resultsForPrint)
    })

    output$crossValidationMeanAccuracy <- renderText({ meanAccuracy })
})

# Sets given checkboxes to the given state 
setCheckboxes <- function(cbList, state) {
    for (cb in cbList) {
        shinyjs::enable(cb)
        updateCheckboxInput(session, cb, value = state)
    }
}