source('ui/twitter_api/index.R', local = TRUE);
source('ui/dataset/index.R', local = TRUE);

library(shiny)
library(shinythemes)
library(shinyjs)
library(shinyWidgets)

ui <- fluidPage(
    # Predefined theme from "shinythemes" selection
    theme = shinytheme("journal"),

    # Shiny Widget slider skin chosen
    chooseSliderSkin("Square"),

    # Shiny JS included
    useShinyjs(),

    # Navbar definition
    navbarPage(
        # Upper-left corner TITLE definition
        "TWITTER Sentiment Analysis",
        
        # Navbar panels definition
        TwitterAPI,
        PreparedDataset
    ),

    # Set label css globally
    tags$head(
        tags$style(
            HTML("label { font-size: 18px; margin-bottom: 15px; }")
        )
    )
    
    #hr(style = "border: none; height: 1px; background-color: #eee; border-radius:20px;")
)
