# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

PreparePackages <- function()
{
    # Defines and installs set of packages needed for application
    source("server/common/initialization/ensure_package.R", local = TRUE)

    # for timestamp to date time conversion
    EnsurePackage("anytime", "CRAN")
    # for base64 encoding
    EnsurePackage("base64enc", "CRAN")
    # for wordcloud2 library prerequirement
    EnsurePackage("devtools", "CRAN")
    # for interactive data tables
    EnsurePackage("DT", "CRAN")
    # for Naive Bayes algorithm
    EnsurePackage("e1071", "CRAN")
    # for big integer numbers to hexadecimal conversion
    EnsurePackage("gmp", "CRAN")
    # for including an option to install package directly from git repostiory
    EnsurePackage("githubinstall", "CRAN")
    # for color palletes access
    EnsurePackage("RColorBrewer", "CRAN")
    # for OAuth2 authentication
    EnsurePackage("ROAuth", "CRAN")
    # for shiny applications
    EnsurePackage("shiny", "CRAN")
    # for predefined themes access
    EnsurePackage("shinythemes", "CRAN")
    # for front end JS manipulation
    EnsurePackage("shinyjs", "CRAN")
    # for customised widgets access
    EnsurePackage("shinyWidgets", "CRAN")
    # for snowball
    EnsurePackage("SnowballC", "CRAN")
    # for classification algorithms
    EnsurePackage("RTextTools", "CRAN")
    # for string manipulations
    EnsurePackage("stringr", "CRAN")
    # for text categorization purpose
    EnsurePackage("textcat", "CRAN")
    # for text mining purpose
    EnsurePackage("tm", "CRAN")
    # for twitter API authentication
    EnsurePackage("twitteR", "CRAN")
    # for wordcloud download
    EnsurePackage("wordcloud", "CRAN")
    # for wordcloud plot
    EnsurePackage("wordcloud2", "GH")
}
