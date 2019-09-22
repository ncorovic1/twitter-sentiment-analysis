source('data/datasets/dataset_info.R', local = TRUE);

DatasetBrowseSection <- fluidRow(
    align = "center",
    column(
        12,
        fluidRow(
            id = "sectionDatasetSelectionExpanded",
            column(
                10,
                offset = 1,
                style = "background-color: #F5F5F5;",
                h1("Prepared Dataset"),
                br(),
                selectInput(
                    "iDatasetChoice", 
                    "Dataset:", 
                    datasetDictionary,
                    width = "80%"
                ),
                tags$style(
                    type='text/css', 
                    ".selectize-input { text-align: center; font-size: 20px; color: #777777; }",
                    ".selectize-dropdown-content { max-height: 250px; }"
                ),
                column(
                    12, 
                    align = "justify",
                    br(),
                    span(htmlOutput("oDatasetDescription"), style = "font-size: 20px;"),
                    br()
                ),
                br(),
                actionButton("bConfirmDatasetChoice", "Confirm", class = "btn-info", width = "50%"),
                tags$style(type="text/css", "#bConfirmDatasetChoice { text-align: center; font-size: 20px; }"),
                br(),
                br(),
                HTML(
                    '<img
                        id = "pd-loader" 
                        src = "loader.gif", 
                        height = "40px"
                        style = "display: none; position: relative; top: -40px;"
                    />'
                )
            )
        ),
        fluidRow(
            # not visible on start up
            id = "sectionDatasetSelectionCollapsed",
            style = "display: none;",
            column(
                8,
                offset = "2",
                actionButton("bExpandSectionDatasetSelection", "Browse other datasets", class = "btn-default"),
                actionButton("bReloadDataset", "Refresh dataset to raw form", class = "btn-default"),
                br(),
                br()
            )
        )
    )
)
