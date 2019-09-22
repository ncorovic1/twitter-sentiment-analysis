# hard coded signal variable that decides if twitter API will be called or cached file read
useCachedData <- FALSE

# checkboxes for preprocessing purpose
cbPreprocessingList <- c(
    "cbRemoveNonEnglishTweets", "cbRemovePunctuation", "cbRemoveWords", "cbRemoveURL", 
    "cbRemoveAtPeople", "cbRemoveAloneDigits", "cbStripWhitespace", "cbStem", "cbRemoveSingleLetters"
)

# On tweets search button click:
#   Establish twitter connection and fetch tweets (apply column filtering and transformation)
#   Collapse form and expand processing section
observeEvent(input$bSearchTweets, {
    shinyjs::hide("bSearchTweets")
    shinyjs::show("ta-loader")

    if(useCachedData) {
        load(file = "server/twitter_api/cached_response/cachedRawDataDF.RData")
    }
    else {
        if(!exists("TwitterSearch", mode = "function")) {
            source("server/twitter_api/api/twitter_search.R", local = TRUE)
        }

        cachedRawData <- TwitterSearch(input$iTweetsQuery, input$iTweetsCount)

        # remove non-ASCII characters (due to problems with R packages when non-ASCII character is encountered)
        cachedRawData$text <- sapply(cachedRawData$text, function(row) {
            iconv(row, "latin1", "ASCII", sub = "")
            gsub("â€™", "'", row)
            gsub("â€", "", row)
        })

        # following line solves bug with last row having NULL as value
        cachedRawData <- cachedRawData[1:(length(cachedRawData) - 1)]
        cachedRawData.df <- twListToDF(cachedRawData)
        
        if(!exists("TweetsColumnFilter", mode = "function")) {
            source("server/common/transformation/tweets_column_filter.R", local = TRUE)
        }

        cachedRawData.df <- TweetsColumnFilter(cachedRawData.df) 
        save(cachedRawData.df, file = "server/twitter_api/cached_response/cachedRawDataDF.RData")
    }
    
    dataTwitterApi.df <<- cachedRawData.df
    output$tableTweetsOverview <- DT::renderDataTable(DT::datatable(dataTwitterApi.df, options = list(pageLength = 10)))

    shinyjs::hide("ta-loader")
    shinyjs::hide("sectionTwitterApiExpanded")
    shinyjs::show("sectionTwitterApiCollapsed")
    shinyjs::show("sectionTwitterApiBody")
    shinyjs::show("bExpandSectionTwitterApi")
    shinyjs::show("bLoadCachedRawData")
})

# On form expand button click:
#   Collapse form expand button and body section
#   Expand form and tweets search button
observeEvent(input$bExpandSectionTwitterApi, {
    shinyjs::hide("bExpandSectionTwitterApi")
    shinyjs::hide("bLoadCachedRawData")
    shinyjs::hide("sectionTwitterApiBody")

    setCheckboxes(cbPreprocessingList, FALSE)
    
    shinyjs::show("sectionTwitterApiExpanded")
    shinyjs::show("bSearchTweets")
})

# On load raw data button click:
#   Reset data to original raw format
observeEvent(input$bLoadCachedRawData, {
    load(file = "server/twitter_api/cached_response/cachedRawDataDF.RData")
    dataTwitterApi.df <<- cachedRawData.df
    output$tableTweetsOverview <- DT::renderDataTable(DT::datatable(dataTwitterApi.df, options = list(pageLength = 10)))

    setCheckboxes(cbPreprocessingList, FALSE)
})

# On select all button click:
#   Tick all checkboxes
observeEvent(input$bMarkAll, {
    setCheckboxes(cbPreprocessingList, TRUE)
})

# On refresh button click:
#   Apply preprocessing of tweets
observeEvent(input$bRefresh, {
    if(!exists("TweetsCleansing", mode = "function")) {
        source("server/common/transformation/tweets_cleansing.R", local = TRUE)
    }

    require(textcat)

    transformations <- TweetsCleansing()

    if (input$cbRemoveNonEnglishTweets) {
        dataTwitterApi.textcat <- textcat(dataTwitterApi.df$Text)
        dataTwitterApi.df.english <- dataTwitterApi.df[dataTwitterApi.textcat == "english", ]
        dataTwitterApi.df.scots <- dataTwitterApi.df[dataTwitterApi.textcat == "scots", ]
        dataTwitterApi.df <<- rbind(dataTwitterApi.df.english, dataTwitterApi.df.scots)
        shinyjs::disable("cbRemoveNonEnglishTweets")
    }

    require(tm)
   
    # Tm package requirement is to have doc_id and text columns
    dataTwitterApi.tm <- data.frame(doc_id = rownames(dataTwitterApi.df), text = as.character(dataTwitterApi.df$Text))
    # remove non-ASCII characters (due to problems with R packages when non-ASCII character is encountered)
    dataTwitterApi.tm$text <- sapply(dataTwitterApi.tm$text, function(row) iconv(row, "latin1", "ASCII", sub = ""))
    
    dataTwitterApi.corpus <- Corpus(DataframeSource(dataTwitterApi.tm))
    dataTwitterApi.corpus <- tm_map(dataTwitterApi.corpus, tolower)

    if (input$cbRemoveURL) {
        dataTwitterApi.corpus <- tm_map(dataTwitterApi.corpus, transformations$removeURL)
        shinyjs::disable("cbRemoveURL")
    }

    if (input$cbRemovePunctuation) {
        dataTwitterApi.corpus <- tm_map(dataTwitterApi.corpus, removePunctuation)
        shinyjs::disable("cbRemovePunctuation")
    }

    if (input$cbRemoveAtPeople) {
        dataTwitterApi.corpus <- tm_map(dataTwitterApi.corpus, transformations$removeAtPeople)
        shinyjs::disable("cbRemoveAtPeople")
    }

    if (input$cbRemoveWords) {
        dataTwitterApi.corpus <- tm_map(dataTwitterApi.corpus, transformations$removeStopWords)
        shinyjs::disable("cbRemoveWords")
    }

    if (input$cbRemoveAloneDigits) {
        dataTwitterApi.corpus <- tm_map(dataTwitterApi.corpus, transformations$removeAloneDigits)
        shinyjs::disable("cbRemoveAloneDigits")
    }

    if (input$cbStripWhitespace) {
        dataTwitterApi.corpus <- tm_map(dataTwitterApi.corpus, stripWhitespace)
        shinyjs::disable("cbStripWhitespace")
    }

    if (input$cbRemoveSingleLetters) {
        dataTwitterApi.corpus <- tm_map(dataTwitterApi.corpus, transformations$removeSingle)
        shinyjs::disable("cbRemoveSingleLetters")
    }

    if (input$cbStem) {
        stemCompletion2 <- function(x, dictionary) {
            # split each word and store it    
            x <- unlist(strsplit(as.character(x), " "))
            # stemCompletion completes an empty string to a word in dictionary. Remove empty string to avoid issue.
            x <- x[x != ""]
            # This uses Dr. Martin Porter's stemming algorithm and the C libstemmer library generated by Snowball
            x <- stemCompletion(x, dictionary=dictionary, type = "prevalent")
            x <- paste(x, sep = "", collapse = " ")
            PlainTextDocument(stripWhitespace(x))
        }
        dataTwitterApi.corpus.copy <- dataTwitterApi.corpus
        dataTwitterApi.corpus <- tm_map(dataTwitterApi.corpus, stemDocument) 
        dataTwitterApi.corpus <- lapply(dataTwitterApi.corpus, stemCompletion2, dataTwitterApi.corpus.copy)
        dataTwitterApi.corpus <- as.VCorpus(dataTwitterApi.corpus)  
        shinyjs::disable("cbStem")
    }

    dataTwitterApi.tm.corpus <- data.frame(text = sapply(dataTwitterApi.corpus, as.character), stringsAsFactors = FALSE)
    dataTwitterApi.df$Text <<- dataTwitterApi.tm.corpus$text
    dataTwitterApi.df$Text <- sapply(dataTwitterApi.df$Text, function(row) gsub("â€™", "'", row))
    dataTwitterApi.df$Text <- sapply(dataTwitterApi.df$Text, function(row) gsub("â€", "", row))
    output$tableTweetsOverview <- DT::renderDataTable(DT::datatable(dataTwitterApi.df, options = list(pageLength = 10)))
})

# On generate wordcloud button click:
observeEvent(input$bGenerateWordcloud, {
    if(!exists("GenerateWordcloud2", mode = "function")) {
        source("server/common/plot/generate_wordcloud2.R", local = TRUE)
    }

    output$wordcloudTwitterApi <- renderWordcloud2(
        GenerateWordcloud2(dataTwitterApi.df, input$iWordcloudWordsCount) 
    )
})

# On download wordcloud button click, png image is downloaded:
output$dbDownloadWordcloud <- downloadHandler(
    paste(input$iTweetsQuery, "- wordcloud.png", sep = " "),
    # Content is a function with file as an argument. Content writes the plot to the device
    content = function(file) {
        if(!exists("GenerateWordcloud", mode = "function")) {
            source("server/common/plot/generate_wordcloud.R", local = TRUE)
        }

        # Open the png device
        png(file, width = 600, height = 600) 
        GenerateWordcloud(dataTwitterApi.df, input$iWordcloudWordsCount)
        # Turn the device off
        dev.off()  
    },
    contentType = 'png'
)

# On calculate sentiment button click:
observeEvent(input$bCalculateSentiment, {
    if(!exists("BagOfWords", mode = "function")) {
        source("server/common/algorithm/bag_of_words.R", local = TRUE)
    }

    resultOfBagOfWords <- BagOfWords(dataTwitterApi.df$Text)
    output$tableTweetsSentimentOverview <- DT::renderDataTable(
        DT::datatable(resultOfBagOfWords, options = list(pageLength = 25))
    )

    shinyjs::show("sectionTwitterApiSentimentOverview")

    if(!exists("GenerateBarplot", mode = "function")) {
        source("server/common/plot/generate_barplot.R", local = TRUE)
    }

    require("RColorBrewer")

    output$barplotSentimentAll <- renderPlot({
        GenerateBarplot(
            resultOfBagOfWords$Score, 
            "Score distribution",
            "Score value",
            "Count"
        )
        axis(2)
    })

    output$barplotSentimentNegative <- renderPlot({
        GenerateBarplot(
            resultOfBagOfWords[resultOfBagOfWords$Score < 0, ]$Score, 
            "Negative sentiment distribution",
            "Negative value",
            "Count"
        )
        axis(2)
    })

    output$barplotSentimentPositive <- renderPlot({
        GenerateBarplot(
            resultOfBagOfWords[resultOfBagOfWords$Score > 0, ]$Score, 
            "Positive sentiment distribution",
            "Positive value",
            "Count"
        )
        axis(2)
    })

    if(!exists("GeneratePieChart", mode = "function")) {
        source("server/common/plot/generate_pie_chart.R", local = TRUE)
    }

    output$pieChartSentimentAll <- renderPlot({
        GeneratePieChart(
            sum(resultOfBagOfWords$Score < 0),
            sum(resultOfBagOfWords$Score == 0),
            sum(resultOfBagOfWords$Score > 0)
        )
    })
})

# Sets given checkboxes to the given state 
setCheckboxes <- function(cbList, state) {
    for (cb in cbList) {
        shinyjs::enable(cb)
        updateCheckboxInput(session, cb, value = state)
    }
}
