# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

EnsurePackage <- function(package, source)
{
    # Installs package if it is not already installed.
    #
    # Args:
    #   package: Package to be checked and installed.
    #   source: Source used for fetching a missing package (CRAN or GITHUB)
    package <- as.character(package)
    
    if (!require(package, character.only = TRUE))
    {
        if (source == "CRAN") {
            install.packages(pkgs = package, repos = "http://cran.r-project.org")
        }
        if (source == "GH") {
            require(githubinstall)
            
            githubinstall(package)
        }
    }
}
