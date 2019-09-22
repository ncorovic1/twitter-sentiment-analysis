PreprocessingDPPanel <- tabPanel(
    "Preprocessing",
    fluidRow(
        column(
            12,
            h3("Following options are available for preprocessing (refresh to apply changes)")
        )
    ),
    br(),
    br(),
    fluidRow(
        align = "left",
        column(
            3,
            offset = 2,
            checkboxInput(
                inputId = "cbRemoveNonEnglishTweetsPD",
                label = "Remove Non-english words",
                value = F
            )
        ),
        column(
            3,
            checkboxInput(
                inputId = "cbRemoveURLPD",
                label = "Remove URLs",
                value = F
            )
        ),
        column(
            3,
            checkboxInput(
                inputId = "cbRemoveAtPeoplePD",
                label = "Remove @People",
                value = F
            )
        )
    ),
    br(),
    br(),
    fluidRow(
        align = "left",
        column(
            3,
            offset = 2,
            checkboxInput(
                inputId = "cbRemovePunctuationPD",
                label = "Remove punctuation",
                value = F
            )
        ),
        column(
            3,
            checkboxInput(
                inputId = "cbRemoveWordsPD",
                label = "Remove stop words",
                value = F
            )
        ),
        column(
            3,
            checkboxInput(
                inputId = "cbRemoveAloneDigitsPD",
                label = "Remove alone digits",
                value = F
            )
        )
    ),
    br(),
    br(),
    fluidRow(
        align = "left",
        column(
            3,
            offset = 2,
            checkboxInput(
                inputId = "cbStripWhitespacePD",
                label = "Strip whitespace",
                value = F
            )
        ),
        column(
            3,
            checkboxInput(
                inputId = "cbStemPD",
                label = "Apply stemming",
                value = F
            )
        ),
        column(
            3,
            checkboxInput(
                inputId = "cbRemoveSingleLettersPD",
                label = "Remove single letters",
                value = F
            )
        )
    ),
    br(),
    br(),
    fluidRow(
        column(
            12,
            actionButton("bMarkAllPD", "Mark All", class = "btn-info"),
            actionButton("bRefreshPD", "Refresh", class = "btn-info")
        )
    )
)
