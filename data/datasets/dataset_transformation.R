this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

#######################################################################################################################################################
### APPLE
#######################################################################################################################################################

appleTweets = read.csv("pristine/Apple.csv", header = TRUE, check.names = FALSE)

appleTweets <- appleTweets[!(appleTweets$sentiment == "not_relevant"),]

appleTweets$date <- sapply(appleTweets$date, function(x) paste(substring(x, 1, 19), substring(x, 26, 30)))
columnsToKeep <- c("text", "sentiment", "sentiment:confidence", "date", "query")
appleTweets <- appleTweets[columnsToKeep]
colnames(appleTweets) <- c("Text", "Sentiment", "SentimentConfidence", "Date", "Query")

appleTweets$Sentiment <- 
  ifelse(as.character(appleTweets$Sentiment) < 3, 'negative',
         ifelse(as.character(appleTweets$Sentiment) == 3, 'neutral',
                ifelse(as.character(appleTweets$Sentiment) > 3, 'positive', 'none')))

write.csv(appleTweets, file = 'cleaned/Apple.csv', row.names = FALSE)

#######################################################################################################################################################
### BITCOIN
#######################################################################################################################################################

bitcoinTweets = read.csv("pristine/Bitcoin.csv", header = FALSE, check.names = FALSE,
                         col.names = c('date', 'text', 'user', 'delete1', 'delete2', 'terms', 'delete4', 'sentiment'))

bitcoinTweets$date <- sapply(bitcoinTweets$date, function(x) paste(substring(x, 1, 19), substring(x, 26, 30)))
bitcoinTweets$terms <- sapply(bitcoinTweets$terms, function(x) gsub("\\[u\'|\',|u\'|\'\\]","", as.character(x)))
bitcoinTweets$sentiment <- sapply(bitcoinTweets$sentiment, function(x) gsub("\\[\'|\'\\]","", as.character(x)))
columnsToKeep <- c('text', 'sentiment', 'date', 'user', 'terms')
bitcoinTweets <- bitcoinTweets[columnsToKeep]
colnames(bitcoinTweets) <- c('Text', 'Sentiment', 'Date', 'User', 'Terms')

write.csv(bitcoinTweets, file = 'cleaned/Bitcoin.csv', row.names = FALSE)

#######################################################################################################################################################
### US AIRLINE
#######################################################################################################################################################

usAirlineTweets = read.csv("pristine/US_Airline.csv", header = TRUE, check.names = FALSE)

usAirlineTweets$tweet_created <- sapply(usAirlineTweets$tweet_created, function(x) substring(x, 1, 22))
columnsToKeep <- c("text","airline_sentiment", "airline_sentiment_confidence", "tweet_created", "name", "tweet_location", "user_timezone")
usAirlineTweets <- usAirlineTweets[columnsToKeep]
colnames(usAirlineTweets) <- c("Text", "Sentiment", "SentimentConfidence", "Date", "User", "Location", "User_timezone")

write.csv(usAirlineTweets, file = 'cleaned/US_Airline.csv', row.names = FALSE)

#######################################################################################################################################################
### WEATHER
#######################################################################################################################################################

weatherTweets = read.csv("pristine/Weather.csv", header = TRUE, check.names = FALSE)

columnsToKeep <- c("tweet_text","sentiment", "what_emotion_does_the_author_express_specifically_about_the_weatherconfidence", "orig__last_judgment_at")
weatherTweets <- weatherTweets[columnsToKeep]
colnames(weatherTweets) <- c("Text", "Sentiment", "SentimentConfidence", "Date")

weatherTweets <- weatherTweets[!(weatherTweets$Sentiment == "I can't tell"),]
weatherTweets <- weatherTweets[!(weatherTweets$Sentiment == "Tweet not related to weather condition"),]

weatherTweets$Sentiment <- 
  ifelse(as.character(weatherTweets$Sentiment) == 'Negative', 'negative',
         ifelse(as.character(weatherTweets$Sentiment) == 'Neutral / author is just sharing information', 'neutral',
                ifelse(as.character(weatherTweets$Sentiment) == 'Positive', 'positive', 'none')))

write.csv(weatherTweets, file = 'cleaned/Weather.csv', row.names = FALSE)

#######################################################################################################################################################
### SELF-DRIVING CARS
#######################################################################################################################################################

selfDrivingCarsTweets = read.csv("pristine/Self-Driving_Cars.csv", header = TRUE, check.names = FALSE)

columnsToKeep <- c("text", "sentiment", "sentiment:confidence", "_last_judgment_at", "sentiment_gold_reason")
selfDrivingCarsTweets <- selfDrivingCarsTweets[columnsToKeep]
colnames(selfDrivingCarsTweets) <- c("Text", "Sentiment", "SentimentConfidence", "Date", "Relevance")

selfDrivingCarsTweets <- selfDrivingCarsTweets[!(selfDrivingCarsTweets$Sentiment=="not_relevant"),]

selfDrivingCarsTweets$Sentiment <- 
  ifelse(as.character(selfDrivingCarsTweets$Sentiment) < 3, 'negative',
         ifelse(as.character(selfDrivingCarsTweets$Sentiment) == 3, 'neutral',
                ifelse(as.character(selfDrivingCarsTweets$Sentiment) > 3, 'positive', 'none')))

write.csv(selfDrivingCarsTweets, file = 'cleaned/Self-Driving_Cars.csv', row.names = FALSE)

#######################################################################################################################################################
### IOS
#######################################################################################################################################################

iosTweets = read.csv("pristine/IOS.csv", header = TRUE, check.names = TRUE)

columnsToKeep <- c("Tweet", "Category")
iosTweets <- iosTweets[columnsToKeep]
colnames(iosTweets) <- c("Text", "Sentiment")

iosTweets <- iosTweets[!(iosTweets$Text == "Not Available"),]

# Row 5930 contained invalid value for sentiment (Tweet) so it needs to be removed and factorized
iosTweets <- iosTweets[!(iosTweets$Sentiment == "Tweet"),]
iosTweets$Sentiment <- factor(iosTweets$Sentiment)

write.csv(iosTweets, file = 'cleaned/IOS.csv', row.names = FALSE)

#######################################################################################################################################################
### CELLPHONE BRANDS
#######################################################################################################################################################

cellphoneBrandsTweets = read.csv("pristine/Cellphone_Brands.csv", header = TRUE, check.names = FALSE)

columnsToKeep <- c("tweet_text","is_there_an_emotion_directed_at_a_brand_or_product", "emotion_in_tweet_is_directed_at")
cellphoneBrandsTweets <- cellphoneBrandsTweets[columnsToKeep]
colnames(cellphoneBrandsTweets) <- c("Text", "Sentiment", "Sentiment_directed_at")

cellphoneBrandsTweets <- cellphoneBrandsTweets[!(cellphoneBrandsTweets$Sentiment == "No emotion toward brand or product"),]

cellphoneBrandsTweets$Sentiment <- 
  ifelse(as.character(cellphoneBrandsTweets$Sentiment) == 'Negative emotion', 'negative',
         ifelse(as.character(cellphoneBrandsTweets$Sentiment) == "I can't tell", 'neutral',
                ifelse(as.character(cellphoneBrandsTweets$Sentiment) == 'Positive emotion', 'positive', 'none')))

write.csv(cellphoneBrandsTweets, file = 'cleaned/Cellphone_Brands.csv', row.names = FALSE)

#######################################################################################################################################################
### GOP PRESIDENTAL DEBATE
#######################################################################################################################################################

GOPPresidentalDebateTweets = read.csv("pristine/GOP_Presidental_Debate.csv", header = TRUE, check.names = FALSE)

columnsToKeep <- c("text","sentiment", "sentiment_confidence", "tweet_created", "candidate", "name", "tweet_location", "user_timezone")
GOPPresidentalDebateTweets <- GOPPresidentalDebateTweets[columnsToKeep]
colnames(GOPPresidentalDebateTweets) <- c("Text", "Sentiment", "SentimentConfidence", "Date", "Candidate", "User", "Location", "User_timezone")

GOPPresidentalDebateTweets$Sentiment <- 
  ifelse(as.character(GOPPresidentalDebateTweets$Sentiment) == 'Negative', 'negative',
         ifelse(as.character(GOPPresidentalDebateTweets$Sentiment) == "Neutral", 'neutral',
                ifelse(as.character(GOPPresidentalDebateTweets$Sentiment) == 'Positive', 'positive', 'none')))

write.csv(GOPPresidentalDebateTweets, file = 'cleaned/GOP_Presidental_Debate.csv', row.names = FALSE)
