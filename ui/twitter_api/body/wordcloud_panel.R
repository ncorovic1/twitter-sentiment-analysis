WordcloudPanel <- tabPanel(
    "Wordcloud",
    fluidRow(
        column(
            12,
            h3("Distribution on wordcloud")
        ),
        sliderInput("iWordcloudWordsCount", "", 30, 200, 80, width = "80%"),
        actionButton("bGenerateWordcloud", "Generate", class = "btn-info"),
        downloadButton(outputId = "dbDownloadWordcloud", label = "Download")
    ),
    br(),
    br(),
    fluidRow(
        column(
            12,
            wordcloud2Output("wordcloudTwitterApi", width = "100%")
        )
    )
)
