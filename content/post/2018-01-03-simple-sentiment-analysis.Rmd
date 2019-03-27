---
author: mtgingrass
comments: true
date: 2018-01-03 20:29:46+00:00
layout: post
link: http://devgin.com/simple-sentiment-analysis/
slug: simple-sentiment-analysis
title: Simple Sentiment Analysis
wordpress_id: 590
categories:
- Programming
- Python
tags:
- analysis
- github
- python
- R
- sentiment
- tweet
---










#### Sentiment Analysis




This is a very basic sentiment analysis based on the last 2000 Tweets about @realDonaldTrump (as of Jan 2 2018). 





The data for positive and negative words are in the files on this [repository.](https://github.com/mtgingrass/Sentiment1)




Or...Scrape your own Tweets by following this [guide,](http://devgin.com/r-programming-twitter-scraper/) or use the WordFreq.csv provided on the GitHub account.






















#### The Code


First, read in the negative and positive words. The WordFreq.csv file was created using R and tapping the Twitter API for specific Tweets. The R program also does a word frequency count

We lose a degree of freedom because we can't trace back the words to the article; however, this was just an exercise to start learning Python syntax and manipulating data. Still useful if you don't need to trace back.













    
    <code>
    negative_file = open('/Users/mark/Desktop/GitHub Projects/TweetRSentimentPython/negative.txt', 'r').read()
    positive_file = open('/Users/mark/Desktop/GitHub Projects/TweetRSentimentPython/positive.txt', 'r').read()
    
    my_data = open('/Users/mark/Desktop/GitHub Projects/TweetRSentimentPython/WordFreq.csv', 'r').read()
    
    # convert words into lists
    negative_words = negative_file.split('\n')
    positive_words = positive_file.split('\n')
    
    sentiment_data = my_data.split() # convert string to list
    
    sentiment_data.pop(0) # remove header row
    sentiment_data[0].replace('"','') #remove the quotes
    
    pos_counter = 0
    neg_counter = 0
    
    if 'trump' in positive_words:
        positive_words.remove('trump') # With "trump" being such a common word now 
                                       # that Trump is president, let's remove this from the list of positive words. 
    
    # strip the quotes and split the row into word, freq for each row
    for row_iter in sentiment_data:
        processed_row = row_iter.replace('"','')
        word, freq = processed_row.split(',')
        
        # count pos words
        if word in positive_words:
            pos_counter = pos_counter + int(freq)
            
        # count neg words
        if word in negative_words:
            neg_counter = neg_counter + int(freq)
    
    # Print only 2 decimal places and do not add an endline to string
    def printC(answer):
        print ("{:0.2f}".format(answer), end = '')
    
    print(pos_counter, "positive words.")
    print(neg_counter, "negative words\n")
    
    printC(pos_counter/(pos_counter + neg_counter)*100)
    print("% Positive")
    
    printC(neg_counter/(pos_counter + neg_counter)*100)
    print("% Negative")
    
    </code>






#### Results


593 positive words.
773 negative words.





<blockquote>43.41% Positive</blockquote>








<blockquote>56.59% Negative</blockquote>





#### Enhancements?



I'm interested in adding swear words to the negative.txt file to see how that changes the results.
Results can be skewed due to sarcasm or bigrams such as "not cool" is actually negative; even though "cool" will be counted as a positive. The general idea is that the "non" and other such words will balance each other out for positive and negative.
![](http://devgin.com/wp-content/uploads/2018/01/realdonaldtrump-1024x576.png)


#### Thanks




Thanks to the authors for contributing the positive and negative datasets:




Minqing Hu and Bing Liu. "Mining and Summarizing Customer Reviews." Proceedings of the ACM SIGKDD International Conference on Knowledge Discovery and Data Mining (KDD-2004), Aug 22-25, 2004, Seattle, Washington, USA, Bing Liu, Minqing Hu and Junsheng Cheng. "Opinion Observer: Analyzing and Comparing Opinions on the Web." Proceedings of the 14th International World Wide Web conference (WWW-2005), May 10-14, 2005, Chiba, Japan.







