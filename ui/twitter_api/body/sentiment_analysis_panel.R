SentimentAnalysisPanel <- tabPanel(
    "Sentiment analysis", 
    fluidRow(
        column(
            12,
            h3("Sentiment calculation"),
            br(),
            actionButton("bCalculateSentiment", "Apply sentiment calculation", class = "btn-info"),
            br(),
            br()
        )
    ),
    fluidRow(
        column(
            6,
            DT::dataTableOutput("tableTweetsSentimentOverview")
        ),
        column(
            6,
            fluidRow(
                id = "sectionTwitterApiSentimentOverview",
                style = "display: none;",
                column(
                    12,
                    tabsetPanel(
                        tabPanel(
                            "Distribution on barplot",
                            br(),
                            plotOutput("barplotSentimentAll"),
                            plotOutput("barplotSentimentNegative"),
                            plotOutput("barplotSentimentPositive")
                        ),
                        tabPanel(
                            "Distribution on pie chart",
                            br(),
                            plotOutput("pieChartSentimentAll")
                        )
                    )
                )
            )
        )
    )
)
