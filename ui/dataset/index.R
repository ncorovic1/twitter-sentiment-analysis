source('ui/dataset/header/dataset_browse_section.R', local = TRUE);
source('ui/dataset/body/data_overview_panel.R', local = TRUE);
source('ui/dataset/body/preprocessing_panel.R', local = TRUE);
source('ui/dataset/body/wordcloud_panel.R', local = TRUE);
source('ui/dataset/body/sentiment_analysis_panel.R', local = TRUE);

PreparedDataset <- tabPanel(
    ##############################################################################
    ### Prepared dataset panel
    ##############################################################################
    
    # Title
    "Prepared Dataset",

    # Form section (button when collapsed)
    DatasetBrowseSection,
    
    # Tabset area
    fluidRow(
        # not visible on start up
        id = "sectionPreparedDatasetBody",
        style = "display: none;",
        align = "center",
        column(
            12,
            align="center",
            tabsetPanel(
                DataOverviewDPPanel,
                PreprocessingDPPanel,
                WordcloudDPPanel,
                SentimentAnalysisPDPanel
            )
        )
    )
)
