# Twitter Sentiment Analysis

Twitter sentiment analysis performed in R (web application)

#### **Application architecture**

<p >
  <br />
  <img src="/documentation/Application_architecture.png" width="450">
</p>

#### **Overview**

Represents a complete guide for a begginner sentiment analyst. Consisted of following **functionalities**:

* Real-time sentiment analysis
  * Twitter API communication
  * Lexicon-based algorithm implementation
* Sentiment analysis based on supervised learning
  * Supplied with multiple labeled datasets
  * Based on use of "e1071" and "RTextTools" libraries for different supervised learning algorithms
    * Naive Bayes
    * Maximum Entrophy
    * Support Vector Machines
    * Decision Tree
    * Random Forest
* Result validation and improvements
  * K-fold cross validation
  * Confussion matrix
  * Multiple accuracy metrics implemented:
    * Precission accuracy
    * Recall accuracy
    * F-score accuracy (as F1 mode - β = 1)
* Visualizations
  * Wordcloud
  * Bar plots
  * Pie charts
 
Total of **8 labeled datasets** are available in the application (comma-separated values files):

* [Apple](https://data.world/crowdflower/apple-twitter-sentiment)
* [Bitcoin](https://www.kaggle.com/skularat/bitcoin-tweets)
* [Cellphone brands](https://data.world/crowdflower/brands-and-product-emotions)
* [GOP presidental debate](https://www.kaggle.com/crowdflower/first-gop-debate-twitter-sentiment)
* [iOS](https://www.kaggle.com/harinav009/sentiment-analysis-of-tweetshar)
* [Self-driving cars](https://data.world/crowdflower/sentiment-self-driving-cars)
* [US airline](https://data.world/socialmediadata/twitter-us-airline-sentiment)
* [Weather](https://data.world/crowdflower/weather-sentiment-evaluated)

#### **Tweet transformation process**

<p>
  <img src="/documentation/Tweet_preprocessing_diagram.png" width="400">
</p>

#### **Code organization**

<p>
  <img src="/documentation/Code_organization.png" width="400"> 
  <br />
  <br />
  <img src="/documentation/Code_organization_common.png" width="400">
</p>

