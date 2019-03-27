---
author: mtgingrass
comments: true
date: 2017-10-05 22:15:10+00:00
layout: post
link: http://devgin.com/clean-data-r-programming/
slug: clean-data-r-programming
title: Clean Data Outliers Using R Programming -
wordpress_id: 305
categories:
- Programming
- R Statistics
---

### Using R to Extract and Delete Outliers in Data


Automate the extraction of outliers from your data-set using R programming and exclude the outliers.


### What to expect





 	
  * How to read in a *.csv file and store it as a data frame in R

 	
  * How to extract all rows of data that are equal to a certain string

 	
  * How to extract a single column of the specific data for analysis

 	
  * How to filter out outliers based on interquartile range




### Watch the video for a quick guide


[embed]https://youtu.be/Gmo3_jialcI[/embed]  



### What is an outlier?


An outlier is simply a  data point that is distinctly separate from the rest of the data. Some outliers are meant to be in the data, so be careful when excluding them. This R script is good for excluding what I call "hard broke" outliers.

For example, if the data is usually between 2 and 11, and you find a 12 or 13 in the data set, that may be just a small deviation that occurs every so often. However, if you end up with a 47 or a 100 or even a 0 in the data, it should be investigated. Do not just throw away outliers, bring them up and have it investigated.


### Interquartile Range


An outlier can take many forms and definitions. One such method of determining outliers is to define it as any data point more than 1.5 Interquartile Ranges(IQRs) below the first quartile or above the third quartile. What does that mean? Check out the Khan Academy explanation [here.](https://www.khanacademy.org/math/statistics-probability/summarizing-quantitative-data/box-whisker-plots/a/identifying-outliers-iqr-rule)


The code below shows the function that determines the outliers. It will first remove the NA's and the DIV/0 errors and then compute the ranges that are valid. Any invalid ranges are changed to NA's. Finally, the last statement, once again, deletes any NA's in the data. 




    
    <code> remove_outliers <- function(x, na.rm = TRUE, ...) {
      
      #find position of 1st and 3rd quantile not including NA's
      qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
      
      H <- 1.5 * IQR(x, na.rm = na.rm)
      
      y <- x
      y[x < (qnt[1] - H)] <- NA
      y[x > (qnt[2] + H)] <- NA
      x<-y
      
      #get rid of any NA's
      x[!is.na(x)]
    }
    </code>





### 
Common Mistakes




One other thing to watch out for when implementing this code on your own. When you cut and paste your address location of the file you want to read in, be sure to change all of the backslashes ("\") to foward slashes ("/").



    
    <code>WSData <- read.csv("C:/Users/canton/Desktop/read.csv", header = TRUE)</code>





### Entire Code Below



    
    <code>#Clear Variables
    rm(list = ls())
    
    #Load Raw Data from File
    WSData <- read.csv("C:/Users/canton/Desktop/read.csv", header = TRUE)
    attach(WSData)
    
    #Extract MDS only from the raw data
    A010A <- WSData[WSData[,3] == "A010A",]
    
    F015C <- WSData[WSData[,3] == "F015C",]
    F015D <- WSData[WSData[,3] == "F015D",]
    F015E <- WSData[WSData[,3] == "F015E",]
    F016C <- WSData[WSData[,3] == "F016C",]
    F016D <- WSData[WSData[,3] == "A016D",]
    T038A <- WSData[WSData[,3] == "T038C",]
    
    ###################################################################################
    #          Function to remove outliers based on Interquartile Range               #
    ###################################################################################
    remove_outliers <- function(x, na.rm = TRUE, ...) {
      
      #find position of 1st and 3rd quantile not including NA's
      qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
      
      H <- 1.5 * IQR(x, na.rm = na.rm)
      
      y <- x
      y[x < (qnt[1] - H)] <- NA
      y[x > (qnt[2] + H)] <- NA
      x<-y
      
      #get rid of any NA's
      x[!is.na(x)]
    }
    
    ###################################################################################
    #          End Functon                                                            #
    ###################################################################################
    
    
    #Extract just the Blah.19 column from Data
    A010A_SRT = subset(A010A, , c(Blah.19))
    
    #Convert to a vector (for use with outlier function)
    A010A_SRT = as.vector(A010A_SRT$Blah.19)
    
    
    #Test an obvious outliers
    A010A_SRT <- c(A010A_SRT, 234)
    A010A_SRT <- c(A010A_SRT, 55)
    
    
    #Prove outlier is in the vector
    A010A_SRT
    boxplot(A010A_SRT)
    
    #remove outliers
    cleaned_data = remove_outliers(A010A_SRT)
    
    #Prove Outliers are gone
    boxplot(cleaned_data)
    
    cleaned_data
    
    </code>







Check out a similar post about manipulating data and automating descriptive statistics with Excel and VBA [here.](http://devgin.com/manipulate-data-automate-descriptive-statistics-vba/)
