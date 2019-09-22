source('server/common/algorithm/helper/algorithm_info.R', local = TRUE);

SentimentAnalysisPDPanel <- tabPanel(
    "Sentiment analysis", 
    fluidRow(
        column(
            12,
            h3("Sentiment calculation"),
            br(),
            fluidRow(
                column(
                    6,
                    sliderInput("iTrainTestRatio", "Train data percentage", 60, 90, 70, width = "90%")
                ),
                column(
                    6,
                    selectInput(
                        "iAlgorithmChoice", 
                        "Algorithm:", 
                        algorithmDictionary,
                        width = "90%"
                    ),
                    tags$style(
                        type='text/css', 
                        ".selectize-input { 
                            text-align: center; font-size: 20px; color: #777777; 
                            position: relative; top: 15px; }"
                    )
                )
            ),
            br(),
            actionButton("bCalculateSentimentPD", "Apply sentiment calculation", class = "btn-info"),
            br(),
            br(),
            HTML(
                '<img
                    id = "alg-loader" 
                    src = "loader.gif", 
                    height = "40px"
                    style = "display: none;"
                />
                <br><br>'
            )
        )
    ),
    fluidRow(
        column(
            6,
            DT::dataTableOutput("tablePreparedDatasetTweetsSentimentOverview")
        ),
        column(
            6,
            fluidRow(
                id = "sectionPreparedDatasetSentimentOverview",
                style = "display: none;",
                column(
                    12,
                    tabsetPanel(
                        id = "preparedDatasetSentimentTabs",
                        tabPanel(
                            "Results",
                            br(),
                            h4("Precision overall accuracy"),
                            textOutput("precisionAccuracyValue"),
                            br(),
                            h4("Recall overall accuracy"),
                            textOutput("recallAccuracyValue"),
                            br(),
                            h4("Fscore overall accuracy"),
                            textOutput("fscoreAccuracyValue"),
                            br(),
                            h4("Confusion matrix"),
                            tableOutput("confusionMatrixTablePD"),
                            fluidRow(
                                id = "summaryMatrix",
                                h4("Summary matrix"),
                                tableOutput("summaryMatrixTablePD")
                            )
                        ),
                        tabPanel(
                            "Distribution on pie chart",
                            br(),
                            h4("Defined sentiment values"),
                            plotOutput("pieChartSentimentAllPD"),
                            br(),
                            h4("Predicted sentiment values"),
                            plotOutput("pieChartSentimentAllPredictedPD")
                        ),
                        tabPanel(
                            "K-fold cross-validation",
                            br(),
                            sliderInput("iCrossValidationFolds", "Number of folds (k)", 3, 20, 4, width = "90%"),
                            actionButton("bCrossValidatePD", "Apply cross-validation", class = "btn-info"),
                            br(),
                            br(),
                            h4("Cross validation results"),
                            htmlOutput("crossValidationResults"),
                            br(),
                            h4("Mean accuracy"),
                            textOutput("crossValidationMeanAccuracy")
                        )
                    )
                )
            )
        )
    )
)
