---
author: mtgingrass
comments: true
date: 2017-11-21 17:07:51+00:00
layout: post
link: http://devgin.com/r-programming-twitter-scraper/
slug: r-programming-twitter-scraper
title: R Programming Twitter Scraper
wordpress_id: 394
categories:
- Programming
- R Statistics
tags:
- api
- programming
- R
- scrape
- scraper
- token
- tweet
- twitter
---

Create a Twitter Scrapper using R programming language in these very simple steps:

[embed]https://youtu.be/1_K01qD4Exw[/embed]



Follow these simple steps to start srapping:





 	
  1. Create Twitter API Application first: [https://apps.twitter.com/](https://apps.twitter.com/).

 	
  2. Copy the code below into an R script.

        
  3. Install packages "twitteR" and "ROAuth" if required.
 	
  4. Change the search terms to your liking.





    
    <code>
    library(twitteR)
    library(ROAuth)
    
    # Set API Keys
    api_key <- "XXXXXXXXXXXXXXXXXXXX"
    api_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    
    access_token <- "xxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    access_token_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    
    setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)
    
    # Grab latest tweets
    tweets_trump = searchTwitter('from:realDonaldTrump', n=50)
    tweets_trump2 = searchTwitter('@realDonaldTrump', n = 200)
    tweets_trump3 = searchTwitter('morning+bacon', n=100)
    
    # Transform tweets list into a data frame
    tweets.df <- twListToDF(tweets_trump)
    tweets.df2 = twListToDF(tweets_trump2)
    tweets.df3 = twListToDF(tweets_trump3)
    
    write.csv(tweets.df, file = "tweets.csv", row.names = FALSE)
    write.csv(tweets.df2, file = "tweets2.csv", row.names = FALSE)
    write.csv(tweets.df3, file = "tweets3.csv", row.names = FALSE)
    </code>






    
    





Example Output Files here:


[tweets](http://devgin.com/wp-content/uploads/2017/11/tweets.csv)

[tweets2](http://devgin.com/wp-content/uploads/2017/11/tweets2.csv)

[tweets3](http://devgin.com/wp-content/uploads/2017/11/tweets3.csv)



When dealing with Corpi and text, you may encounter an issue as I had in this [post](http://devgin.com/r-tm_maptweet-corpus-content_transformertolower-error-solved/) involving putting the  text to lowercase. An odd error but [solved!](http://devgin.com/r-tm_maptweet-corpus-content_transformertolower-error-solved/)
