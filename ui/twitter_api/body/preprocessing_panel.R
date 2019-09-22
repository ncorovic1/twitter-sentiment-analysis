PreprocessingPanel <- tabPanel(
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
                inputId = "cbRemoveNonEnglishTweets",
                label = "Remove Non-english words",
                value = F
            )
        ),
        column(
            3,
            checkboxInput(
                inputId = "cbRemoveURL",
                label = "Remove URLs",
                value = F
            )
        ),
        column(
            3,
            checkboxInput(
                inputId = "cbRemoveAtPeople",
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
                inputId = "cbRemovePunctuation",
                label = "Remove punctuation",
                value = F
            )
        ),
        column(
            3,
            checkboxInput(
                inputId = "cbRemoveWords",
                label = "Remove stop words",
                value = F
            )
        ),
        column(
            3,
            checkboxInput(
                inputId = "cbRemoveAloneDigits",
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
                inputId = "cbStripWhitespace",
                label = "Strip whitespace",
                value = F
            )
        ),
        column(
            3,
            checkboxInput(
                inputId = "cbStem",
                label = "Apply stemming",
                value = F
            )
        ),
        column(
            3,
            checkboxInput(
                inputId = "cbRemoveSingleLetters",
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
            actionButton("bMarkAll", "Mark All", class = "btn-info"),
            actionButton("bRefresh", "Refresh", class = "btn-info")
        )
    )
)
