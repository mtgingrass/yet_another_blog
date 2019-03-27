---
author: mtgingrass
comments: true
date: 2017-12-16 23:59:34+00:00
layout: post
link: http://devgin.com/scrape-twitter-text-manipuplate-autopost-wordpress/
slug: scrape-twitter-text-manipuplate-autopost-wordpress
title: Scrape Twitter, Text Manipulate, Autopost to WordPress
wordpress_id: 546
categories:
- Programming
- R Statistics
tags:
- auto
- generate content
- programming
- publish
- R
- text
- twitter
- wordpress
- wp
---

### Tweet, Scrape, Manip, Publish




It is highly recommended to watch this [short video](https://youtu.be/ioNIAqZa3go) before working with these files. The video explains how each file works and how to run this for your own site.





I will also publish these on my [GitHub site here. ](https://github.com/mtgingrass/Tweet2WordPress.git) What is a GitHub you say? See previous post [here for quick 5 minute tutorial](http://devgin.com/five-minute-github-tutorial-rstudio-simple/)





#### Watch Video First


[embed]https://youtu.be/ioNIAqZa3go[embed]
  


Note that the below code has R Markdown language in it which makes publishing this particular post difficult. I'm using R Markdown in an R Notepad in order to convert R source code into pretty source code on the web and make it publisher friendly. It's like posting a program on how to program a program....it just gets confusing fast!! 




The best way to get the files is to actually download them from [GitHub](https://github.com/mtgingrass/Tweet2WordPress.git) instead. 

  



Note, this WordPress site utilizes _Crayon Syntax Highlighter_ and _Table of Contents Plus Plugins_




Note, each code segment is an Notepad (Rmd) chunk of code. 


***********************************
START OF NEW FILE HERE
THE BACK END FILE
***********************************

#### Scrape Twitter and Create Word Cloud



#### Auto Publish to WordPress
The following code is what I call the BackEnd. This code will call the Twitter API, Scrape, then manipulate the texts and create a wordcloud.

This code is part of a three file collection.
  -BackEnd.Rmd
  -FrontEnd.Rmd
  -WPPublishWeb.Rmd



#### Libraries


    
    ### Libraries
    library(twitteR)
    library(ROAuth)
    library(tm)
    library(wordcloud)
    library(plyr)
    library(RColorBrewer)
    



##### Twitter API and Search Chunk

    
    ### Set API Keys
    api_key <- "XXXXXXXXXXXXXXXXXXXX"
    api_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    access_token <- "xxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    access_token_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    
    
    ### Authorize Twitter API and Grab Latest Tweets
    setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)
    




    
    # Grab latest tweets
    tweets_trump = searchTwitter('#NetNeutrality', n = 1000)
    
    #coming soon
    #today_trends = getTrends(2364559)
    



##### Text Cleanup 1


    
    #Convert Tweets to d.f. and keep only the first column of data (actual tweet messages)
    tweets.text = twListToDF(tweets_trump)
    tweets.text = tweets.text[,1]
    
    ### Create a corpus
    tweet.corpus = Corpus(VectorSource(tweets.text))
    
    ##### Remove Certain Characters and Words
    #Found a few helper functions and created a few of my own for stripping texts
      #https://github.com/raredd/regex
      #http://www.gnu.org/software/grep/manual/html_node/Character-Classes-and-Bracket-Expressions.html
    tweet.removeURL = function(x) gsub("http[^[:space:]]*","",x)
    tweet.removeATUser = function(x) gsub("@[a-z,A-Z]*","",x)
    tweet.removeEmoji = function(x) gsub("\\p{So}|\\p{Cn}", "", x, perl = TRUE)
    tweet.removeSpecialChar = function(x) gsub("[^[:alnum:]///' ]", "", x)
    
    tweet.corpus = tm_map(tweet.corpus, content_transformer(tweet.removeURL))
    tweet.corpus = tm_map(tweet.corpus, content_transformer(tweet.removeATUser))
    tweet.corpus = tm_map(tweet.corpus, content_transformer(tweet.removeEmoji))
    tweet.corpus = tm_map(tweet.corpus, content_transformer(tweet.removeSpecialChar))
    tweet.corpus = tm_map(tweet.corpus, removePunctuation, preserve_intra_word_dashes = TRUE)
    tweet.corpus = tm_map(tweet.corpus, content_transformer(tolower))
    



##### Text Cleanup 2

Removing words needs work to become more dynamic. I'm removing some words manually based on what my search terms are. For example, if I am looking up the word "Trump", obviously, that word will be the most frequent so why do an analysis on that word? Strip it out! Work in progress.


    
    #words like "And" or "the" are removed.
    tweet.corpus=tm_map(tweet.corpus, removeWords, c(stopwords("english"), "NetNeutrality", "RT", "rt"))
    tweet.corpus=tm_map(tweet.corpus, removeNumbers)
    tweet.corpus = tm_map(tweet.corpus, stripWhitespace)
    tweet.corpus=tm_map(tweet.corpus, removeWords, c(stopwords("english"), "NetNeutrality","netneutrality", "RT", "rt"))
    tweet.corpus = tm_map(tweet.corpus, stripWhitespace) #removing stop words creates more white space
    
    #converts things like "learns" to "learn" or "running" to "run" -Omitting for now
    #tweet.corpus = tm_map(tweet.corpus, stemDocument)
    



##### Text Analysis


    
    ap.tdm <- TermDocumentMatrix(tweet.corpus)
    ap.m <- as.matrix(ap.tdm)
    
    ap.v <- sort(rowSums(ap.m),decreasing=TRUE)
    ap.d <- data.frame(word = names(ap.v),freq=ap.v)
    freqterms = findFreqTerms(ap.tdm, 15)
    



##### WordCloud Generator


    
    #https://cran.r-project.org/web/packages/RColorBrewer/RColorBrewer.pdf
    pal2 <- brewer.pal(8,"Dark2")
    png("realdonaldtrump.png", width=1920,height=1080)
    wordcloud(ap.d$word,ap.d$freq, scale=c(8,.2),min.freq=15,
              max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
    dev.off()
    




    
    <code>## quartz_off_screen 
    ##                 2
    </code>





***********************************
START OF NEW FILE HERE
THE FRONT END FILE
***********************************



##### Word Cloud of the Day!

Top five words used are attorneys, congress, general, vote, every.


    
    library(wordcloud)
    wordcloud(ap.d$word,ap.d$freq,min.freq=10,
          max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
    





![plot of chunk unnamed-chunk-4](https://i.imgur.com/MtRKVKn.png)



# The Ad Code actually goes here as text - hard to publish ad code as code and use this
# script to upload. I am not one to mess with escape characters!!!


***********************************
START OF NEW FILE HERE
PUBLISH TO WORDPRESS FILE
***********************************


    
    if (!require('RWordPress'))
      install.packages('RWordPress', repos = 'http://www.omegahat.org/R', type = 'source')
    library(RWordPress)
    library(knitr)
    library(XMLRPC)
    
    options(WordpressLogin = c(username = ''), WordpressURL = 'http://therealdonaldtrump2020.com/xmlrpc.php')
    
    opts_knit$set(upload.fun = imgur_upload, base.url = NULL)  # upload all images to imgur.com
    opts_chunk$set(fig.width = 7, fig.height = 7, cache = TRUE)
    




    
    knit2wpCrayon <- function(input, title="A post from knitr", ...,
                              action=c("newPost", "editPost", "newPage"),
                              postid, encoding=getOption("encoding"),
                              upload=FALSE, publish=FALSE, write=TRUE)
    {
        out <- knit(input, encoding=encoding)
        on.exit(unlink(out))
        con <- file(out, encoding=encoding)
        on.exit(close(con), add=TRUE)
        content <- knitr:::native_encode(readLines(con, warn=FALSE))
        content <- paste(content, collapse="\n")
        content <- markdown::markdownToHTML(text=content, fragment.only=TRUE)
        content <- gsub("<pre><code class=\"([[:alpha:]]+)\">(.+?)</code></pre>",
                        "<pre class=\"lang:\\1 decode:true\">\\2</pre>",
                        content)
        content=knitr:::native_encode(content, "UTF-8")
        title=knitr:::native_encode(title, "UTF-8")
        if (write){
            writeLines(text=content,
                       con=gsub(x=out, pattern="\\.md$", replacement=".html"))
        }
        if (upload){
            action=match.arg(action)
            WPargs=list(content=list(description=content, title=title, 
                                     ...), publish=publish)
            if (action=="editPost") 
                WPargs=c(postid=postid, WPargs)
            do.call("library", list(package="RWordPress", character.only=TRUE))
            print(do.call(action, args=WPargs))
        }
    }
    




    
    knit2wpCrayon("BackEnd.Rmd", 
            title = "Word of the day!",
            categories = c("Mark"), 
            publish = FALSE, upload = TRUE)
    




    
    <code>## 
      |                                                                       
      |                                                                 |   0%
      |                                                                       
      |.....                                                            |   8%
    ##   ordinary text without R code
    ## 
    ## 
      |                                                                       
      |..........                                                       |  15%
    ## label: unnamed-chunk-7 (with options) 
    ## List of 1
    ##  $ warning: logi FALSE
    ## 
    ## 
      |                                                                       
      |...............                                                  |  23%
    ##   ordinary text without R code
    ## 
    ## 
      |                                                                       
      |....................                                             |  31%
    ## label: unnamed-chunk-8 (with options) 
    ## List of 1
    ##  $ warning: logi FALSE
    ## 
    ## 
      |                                                                       
      |.........................                                        |  38%
    ##   ordinary text without R code
    ## 
    ## 
      |                                                                       
      |..............................                                   |  46%
    ## label: unnamed-chunk-9 (with options) 
    ## List of 1
    ##  $ warning: logi FALSE
    ## 
    ## 
      |                                                                       
      |...................................                              |  54%
    ##   ordinary text without R code
    ## 
    ## 
      |                                                                       
      |........................................                         |  62%
    ## label: unnamed-chunk-10 (with options) 
    ## List of 1
    ##  $ warning: logi FALSE
    ## 
    ## 
      |                                                                       
      |.............................................                    |  69%
    ##   ordinary text without R code
    ## 
    ## 
      |                                                                       
      |..................................................               |  77%
    ## label: unnamed-chunk-11 (with options) 
    ## List of 1
    ##  $ warning: logi FALSE
    ## 
    ## 
      |                                                                       
      |.......................................................          |  85%
    ##   ordinary text without R code
    ## 
    ## 
      |                                                                       
      |............................................................     |  92%
    ## label: unnamed-chunk-12 (with options) 
    ## List of 1
    ##  $ warning: logi FALSE
    </code>




    
    <code>## 
      |                                                                       
      |.................................................................| 100%
    ##   ordinary text without R code
    ## 
    ## 
    ## [1] "798"
    ## attr(,"class")
    ## [1] "WordpressPostId"
    </code>













For scraper specific post, click [here.](http://devgin.com/build-word-cloud-twitter-using-r/)
For building a WordCloud specific post, [this post](click here. </a> 
Having issues with the lowercase function? Check <a href=) out to try an fix it. 

