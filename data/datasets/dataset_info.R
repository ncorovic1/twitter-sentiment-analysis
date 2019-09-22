# Author:
#   Nino Corovic
# Master thesis:
#   Sentiment analysis of comments from social networks

datasetDictionary <- c(
    "Apple" = "apple",
    "Bitcoin" = "bitcoin",
    "Cellphone brands" = "cellphone",
    "GOP presidental debate" = "debate",
    "IOS" = "ios",
    "Self-driving cars" = "cars", 
    "US Airline" = "airline",
    "Weather" = "weather"
)

datasetTitle <- c(
    "apple" = "Apple",
    "bitcoin" = "Bitcoin",
    "cellphone" = "Cellphone brands",
    "debate" = "GOP presidental debate",
    "ios" = "IOS",
    "cars" = "Self-driving cars", 
    "airline" = "US Airline",
    "weather" = "Weather"
)

datasetDescription <- c(
    "apple" = paste(
        "<b>Info:</b> A look into the sentiment around Apple, based on tweets containing #AAPL, @apple, etc. Contributors were given a tweet and asked whether the user was positive, negative, or neutral about Apple. (They were also allowed to mark 'the tweet is not about the company Apple, Inc.')", 
        "<b>Added:</b> November 22, 2016 by CrowdFlower | Data Rows: 3804",
        "<b>Link:</b> https://data.world/crowdflower/apple-twitter-sentiment", 
        sep = "<br/>"
    ),
    "bitcoin" = paste(
        "<b>Info:</b> CSV file containing all tweets accquired using the streaming tweepy python api to match for keyword 'bitcoin'.", 
        "<b>Added:</b> March 25, 2018 by Suran | Data Rows: 50859",
        "<b>Link:</b> https://www.kaggle.com/skularat/bitcoin-tweets", 
        sep = "<br/>"
    ),
    "cellphone" = paste(
        "<b>Info:</b> Contributors evaluated tweets about multiple brands and products. The crowd was asked if the tweet expressed positive, negative, or no emotion towards a brand and/or product. If some emotion was expressed they were also asked to say which brand or product was the target of that emotion.", 
        "<b>Added:</b> August 30, 2013 by Kent Cavender-Bares | Data Rows: 3704",
        "<b>Link:</b> https://data.world/crowdflower/brands-and-product-emotions", 
        sep = "<br/>"
    ),
    "debate" = paste(
        "<b>Info:</b> Tweets about the early August GOP debate in Ohio. Contributors were asked to do both sentiment analysis and data categorization. Contributors were asked if the tweet was relevant, which candidate was mentioned, what subject was mentioned, and then what the sentiment was for a given tweet. We've removed the non-relevant messages from the uploaded dataset.", 
        "<b>Added:</b> November 22, 2016 by Figure Eight | Data Rows: 13871",
        "<b>Link:</b> https://www.kaggle.com/crowdflower/first-gop-debate-twitter-sentiment", 
        sep = "<br/>"
    ),
    "ios" = paste(
        "<b>Info:</b> Tweets mentioning IOS devices labeled with sentiment value.", 
        "<b>Added:</b> June 9, 2018 by harish | Data Rows: 5421",
        "<b>Link:</b> https://www.kaggle.com/harinav009/sentiment-analysis-of-tweetshar", 
        sep = "<br/>"
    ),
    "cars" = paste(
        "<b>Info:</b> A simple Twitter sentiment analysis job where contributors read tweets and classified them as very positive, slightly positive, neutral, slightly negative, or very negative. They were also prompted asked to mark if the tweet was not relevant to self-driving cars.", 
        "<b>Added:</b> June 8, 2015 by CrowdFlower | Data Rows: 7015",
        "<b>Link:</b> https://data.world/crowdflower/sentiment-self-driving-cars", 
        sep = "<br/>"
    ),
    "airline" = paste(
        "<b>Info:</b> A sentiment analysis job about the problems of each major U.S. airline. Twitter data was scraped from February of 2015 and contributors were asked to first classify positive, negative, and neutral tweets, followed by categorizing negative reasons (such as \"late flight\" or \"rude service\").", 
        "<b>Added:</b> October 28, 2016 by CrowdFlower | Data Rows: 14640",
        "<b>Link:</b> https://data.world/socialmediadata/twitter-us-airline-sentiment", 
        sep = "<br/>"
    ),
    "weather" = paste(
        "<b>Info:</b> Here, contributors were asked if the crowd graded the sentiment of a particular tweet relating to the weather correctly. The original job (above this one, called simply 'Weather sentiment') involved 20 contributors noting the sentiment of weather-related tweets. In this job, we asked 10 contributors to check that original sentiment evaluation for accuracy. The button to the right is the aggregated data set. You can also download the non-aggregated, full data set.", 
        "<b>Added:</b> November 22, 2016 by CrowdFlower | Data Rows: 763",
        "<b>Link:</b> https://data.world/crowdflower/weather-sentiment-evaluated", 
        sep = "<br/>"
    )
)

datasetFileName <- c(
    "apple" = "Apple.csv",
    "bitcoin" = "Bitcoin.csv",
    "cellphone" = "Cellphone_Brands.csv",
    "debate" = "GOP_Presidental_Debate.csv",
    "ios" = "IOS.csv",
    "cars" = "Self-driving_Cars.csv", 
    "airline" = "US_Airline.csv",
    "weather" = "Weather.csv"
)
