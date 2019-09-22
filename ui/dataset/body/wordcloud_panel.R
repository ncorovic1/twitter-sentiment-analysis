WordcloudDPPanel <- tabPanel(
    "Wordcloud",
    fluidRow(
        column(
            12,
            h3("Distribution on wordcloud")
        ),
        sliderInput("iWordcloudWordsCountPD", "", 30, 200, 80, width = "80%"),
        actionButton("bGenerateWordcloudPD", "Generate", class = "btn-info"),
        downloadButton(outputId = "dbDownloadWordcloudPD", label = "Download")
    ),
    br(),
    br(),
    fluidRow(
        column(
            12,
            wordcloud2Output("wordcloudPreparedDataset", width = "100%")
        )
    )
)
