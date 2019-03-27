---
author: mtgingrass
comments: true
date: 2017-12-07 05:18:33+00:00
layout: post
link: http://devgin.com/r-tm_maptweet-corpus-content_transformertolower-error-solved/
slug: r-tm_maptweet-corpus-content_transformertolower-error-solved
title: R Lowercase Function in Corpus Error Solved
wordpress_id: 447
categories:
- Programming
- R Statistics
tags:
- content_transofmer
- diamond
- error
- FUN
- question mark
- scrape
- special character
- tm_map
- tolower
- Trump
- twitter
---

In my last video [ tutorial](http://devgin.com/r-programming-twitter-scraper/), I demonstrated the steps to tap into the power of the Twitter API to download Tweets based on search terms and import them into R. My plan was to make a follow up video showing how to clean the  twitter data and run a Word Cloud on common terms. 




However, I ran into a slight snag early on.





The code was supposed to be simple and quick. Everything was going smooth until I dared to change all of the text in the Corpus to lowercase! I've created many functions and used many functions in all kinds of programming languages to accomplish this task. However, today was different. I ran this line of code specifically on a Macbook Pro and received an error I couldn't explain.



    
    <code>tweet.corpus = tm_map(tweet.corpus, content_transformer(tolower))</code>




The error:





<blockquote>Error in FUN(content(x), ...) : 
  invalid input ,</blockquote>





After many searches in the documentation, the Google's, and the Interwebs, I came up with nothing to fix this error. I thought it was a punctuation problem, then an Emoji problem, then a Mac specific problem. I restarted R Studio. I downloaded the latest packages (from the source and compiled). Nothing seemed to work!





Normally, when I struggle for an hour on something seemingly simple, I realize it's not the computer or the programming language, it's me. There is a point in time at night when a missing semi-colon or a unbalanced parenthesis isn't worth the chase. 

Finally, I examined the Tweets closer and found these characters I describe as "question marks with a black diamond around them."





���������� 





Turns out, this is a special character (a space holder). Not a symbol. Not an emoji. Not a number. Not a alpha or numeric. A SPECIAL character.





This "special" character costs me almost an hour of research!. Anyway, to solve this issue here is the code I used:




    
    <code>
    #Grab latest tweets
    tweets_trump = searchTwitter('@realDonaldTrump', n = 1000)
    tweets.text = laply(tweets_trump,function(t)t$getText())
    
    #Remove characters functions
    tweet.removeEmoji = function(x) gsub("\\p{So}|\\p{Cn}", "", x, perl = TRUE)
    tweet.removeSpecialChar = function(x) gsub("[^[:alnum:]///' ]", "", x)
    
    #Followed by the tm_map calls:
    tweet.corpus = tm_map(tweet.corpus, content_transformer(tweet.removeEmoji))
    tweet.corpus = tm_map(tweet.corpus, content_transformer(tweet.removeSpecialChar))</code>





Notice this is still in text format. I create the corpus AFTER I remove the characters. If you haven't seen the previous video on how to create your own Twitter API account free, click the [link here](http://devgin.com/r-programming-twitter-scraper/). Happy scraping!





