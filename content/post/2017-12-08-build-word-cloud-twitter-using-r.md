---
author: mtgingrass
comments: true
date: 2017-12-08 04:24:50+00:00
layout: post
link: http://devgin.com/build-word-cloud-twitter-using-r/
slug: build-word-cloud-twitter-using-r
title: Build Word Cloud from Twitter Using R
wordpress_id: 459
categories:
- Programming
- R Statistics
tags:
- api
- corpi
- corpus
- data manipulation
- dm_map
- matrix
- sparce
- termdocumentmatrix
- tweet
- twitter
---

### How to create a WordCloud with Tweet data




This is a follow up of this [Twitter Scraper video](http://devgin.com/r-programming-twitter-scraper/) I posted last week. If you have to, review previous video before proceeding to data manipulation and WordClouds!


![](http://devgin.com/wp-content/uploads/2017/12/realdonaldtrump-1024x576.png)


In this video you will learn the essentials of:



	
  * How to [connect to the Twitter API](http://devgin.com/r-programming-twitter-scraper/)

	
  * What is a Corpus

	
  * What is a Term Document Matrix

	
  * Creating Word Clouds

        
  * Get the Code





[embed]https://youtu.be/WZ0iTSxz3I4[/embed]



    
    <code>### Libraries
    library(twitteR)
    library(ROAuth)
    library(tm)
    library(wordcloud)
    library(plyr)
    library(RColorBrewer)
    
    ### Set API Keys
    api_key <- "XXXXXXXXXXXXXXXXXXXX"
    api_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    access_token <- "xxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    access_token_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    
    ### Authorize Twitter API and Grab Latest Tweets
    setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)
    
    # Grab latest tweets
    tweets_trump = searchTwitter('@realDonaldTrump', n = 3000)
    
    tweets.text = twListToDF(tweets_trump)
    tweets.text = tweets.text[,1]
    
    ### Create a corpus
    tweet.corpus = Corpus(VectorSource(tweets.text))
    
    ##### Remove Certain Characters and Words
    #https://github.com/raredd/regex
    #http://www.gnu.org/software/grep/manual/html_node/Character-Classes-and-Bracket-Expressions.html
      tweet.removeURL = function(x) gsub("http[^[:space:]]*","",x)
      tweet.removeATUser = function(x) gsub("@[a-z,A-Z]*","",x)
      tweet.removeEmoji = function(x) gsub("\\p{So}|\\p{Cn}", "", x, perl = TRUE)
      tweet.removeSpecialChar = function(x) gsub("[^[:alnum:]///' ]", "", x)
    
    tweet.corpus = tm_map(tweet.corpus, content_transformer(tweet.removeURL))
    inspect(tweet.corpus[1:4])
    tweet.corpus = tm_map(tweet.corpus, content_transformer(tweet.removeATUser))
    inspect(tweet.corpus[1:4])
    tweet.corpus = tm_map(tweet.corpus, content_transformer(tweet.removeEmoji))
    tweet.corpus = tm_map(tweet.corpus, content_transformer(tweet.removeSpecialChar))
    tweet.corpus = tm_map(tweet.corpus, removePunctuation, preserve_intra_word_dashes = TRUE)
    tweet.corpus = tm_map(tweet.corpus, content_transformer(tolower))
    
    #words like "And" or "the" are removed.
    tweet.corpus=tm_map(tweet.corpus, removeWords, c(stopwords("english"), "realdonaldtrump", "RT", "rt"))
    tweet.corpus=tm_map(tweet.corpus, removeNumbers)
    tweet.corpus = tm_map(tweet.corpus, stripWhitespace)
    #converts things like "learns" to "learn" or "running" to "run" -Omitting for now
      #tweet.corpus = tm_map(tweet.corpus, stemDocument)
    
    
    ap.tdm <- TermDocumentMatrix(tweet.corpus)
    ap.m <- as.matrix(ap.tdm)
    dim(ap.m)
    ap.v <- sort(rowSums(ap.m),decreasing=TRUE)
    ap.d <- data.frame(word = names(ap.v),freq=ap.v)
    
    #https://cran.r-project.org/web/packages/RColorBrewer/RColorBrewer.pdf
    pal2 <- brewer.pal(8,"Dark2")
    png("realdonaldtrump.png", width=1920,height=1080)
      wordcloud(ap.d$word,ap.d$freq, scale=c(8,.2),min.freq=3,
                max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
      dev.off()
    </code>




