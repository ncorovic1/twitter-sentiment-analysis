# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

if(!exists("PreparePackages", mode="function")) {
    source("server/common/initialization/prepare_packages.R", local = TRUE)
    PreparePackages()
}

server <- function(input, output, session) {
    # Creates a server function needed for back end (server) part of application
    #
    # Args:
    #   input: Reference on input values (check box, radio button, ...).
    #   output: Reference on output values (histogram, wordcloud, ...).
    #   session: Reference on session object.
    #
    # Returns:
    #   Server object requested by application for back end (processing) purpose
    require("DT")

    source("server/twitter_api/index.R", local = TRUE)
    source("server/dataset/index.R", local = TRUE)
}
