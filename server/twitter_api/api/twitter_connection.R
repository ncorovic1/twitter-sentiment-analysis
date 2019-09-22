# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

TwitterConnection <- function() {
    # Establishes connection to Twitter via OAuth2
    require(ROAuth)
    
    # Set consumer key
    consumerKey <- "VMx4m1xDlicKnHhWTOK9YRYPX"
    # Set consumer secret
    consumerSecret <- "dUwDgReK7ZgZy67800AWrixKdz7E8J7K67lbC2T5N4rAJNHeY3"
    # Set access token
    accessToken <- "942435866785480704-2fNaUbTvrdyFY98IFLoYHxmKkqPYreB"
    # Set access token secret
    accessTokenSecret <- "pEaSogVAW4Ufv3yq6dnltlcBSONdTm8gZLHQSrNvYKKYL"
    
    # Authorize via OAuth2
    setup_twitter_oauth(
        consumerKey,
        consumerSecret,
        accessToken,
        accessTokenSecret
    )
}
