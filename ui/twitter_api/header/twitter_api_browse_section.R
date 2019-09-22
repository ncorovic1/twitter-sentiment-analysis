TwitterAPIBrowseSection <- fluidRow(
    align = "center",
    column(
        12,
        fluidRow(
            id = "sectionTwitterApiExpanded",
            column(
                10,
                offset = 1,
                style = "background-color: #F5F5F5;",
                h1("Twitter API"),
                br(),
                textInput("iTweetsQuery", "Query word:", "Trump", width = "80%"),
                tags$style(type="text/css", "#iTweetsQuery { text-align: center; font-size: 20px; }"),
                br(),
                sliderInput("iTweetsCount", "Number of tweets:", 50, 10000, 51, width = "80%"),
                br(),
                actionButton("bSearchTweets", "Search tweets", class = "btn-info", width = "50%"),
                tags$style(type="text/css", "#bSearchTweets { text-align: center; font-size: 20px; }"),
                br(),
                br(),
                HTML(
                    '<img
                        id = "ta-loader" 
                        src = "loader.gif", 
                        height = "40px"
                        style = "display: none; position: relative; top: -40px;"
                    />'
                )
            )
        ),
        fluidRow(
            # not visible on start up
            id = "sectionTwitterApiCollapsed",
            style = "display: none;",
            column(
                8,
                offset = "2",
                actionButton("bExpandSectionTwitterApi", "Browse other tweets", class = "btn-default"),
                actionButton("bLoadCachedRawData", "Refresh data to raw form", class = "btn-default"),
                br(),
                br()
            )
        )
    )
)
