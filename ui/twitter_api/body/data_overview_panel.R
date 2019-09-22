DataOverviewPanel <- tabPanel(
    "Tweets overview",
    fluidRow(
        column(
            12,
            h3("Tweets overview")
        ),
        DT::dataTableOutput("tableTweetsOverview")
    )
)
