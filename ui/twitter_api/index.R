source('ui/twitter_api/header/twitter_api_browse_section.R', local = TRUE);
source('ui/twitter_api/body/data_overview_panel.R', local = TRUE);
source('ui/twitter_api/body/preprocessing_panel.R', local = TRUE);
source('ui/twitter_api/body/wordcloud_panel.R', local = TRUE);
source('ui/twitter_api/body/sentiment_analysis_panel.R', local = TRUE);

TwitterAPI <- tabPanel(
    ##############################################################################
    ### Twitter API panel
    ##############################################################################
    
    # Title
    "Twitter API",
    
    # Form section
    TwitterAPIBrowseSection,
    
    # Tabset area
    fluidRow(
        # not visible on start up
        id = "sectionTwitterApiBody",
        style = "display: none;",
        align = "center",
        column(
            12,
            align="center",
            tabsetPanel(
                id="twitterApiPanel",
                DataOverviewPanel,
                PreprocessingPanel,
                WordcloudPanel,
                SentimentAnalysisPanel
            )
        )
    )
)
