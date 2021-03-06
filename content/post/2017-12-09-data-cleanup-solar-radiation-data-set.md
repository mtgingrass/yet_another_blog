---
author: mtgingrass
comments: true
date: 2017-12-09 20:50:34+00:00
layout: post
link: http://devgin.com/data-cleanup-solar-radiation-data-set/
slug: data-cleanup-solar-radiation-data-set
title: Data Cleanup with Solar Radiation Data Set
wordpress_id: 499
categories:
- Programming
- R Statistics
tags:
- blog
- clean data
- kaggle
- publish
- scrape
- scraping
- word cloud
- wordcloud
---

#### Purpose





Before you can run a statistical analysis, you may have to clean data. This post is all about using some techniques to clean data. This is not necessarily the best way, or even the correct way to do this; however, it is mean to generate your own ideas for cleaning data in the future. 





#### Data Location





The data comes from the Kaggle site [here](http://www.kaggle.com). It contains over 32,000 observations of Solar Radiation data.





#### The Goal





The goal is to use historical data from multiple input parameters to correctly predict levels of solar radiation. We can get a glimpse of the data and data types using the _head_ function. The following list shows the 11 column names and corresponding data type from the raw data file. 







  * Parameters



    *  UNIXTime (int) - Number of seconds since Jan 1, 1970  



    *  Data (fctr) - MM/DD/YYY 12:00:00 AM


    *  Time (fctr) - Hawaii time (HH:MM:SS)


    *  Radiation (dbl) - watts/〖meter〗2


    *  Temperature (int) - degrees Fahrenheit


    *  Pressure (dbl) - unknown


    *  Humidity (int) - percent


    *  WindDireciton.Degrees. (dbl) degrees


    *  Speed (dbl) - miles/hour


    *  TimeSunRise (fctr) - Hawaii time (HH:MM:SS)


    *  TimeSunSet (fctr) - Hawaii time (HH:MM:SS)







#### Code and Explanations





First, we want to set up the enviornment to make things a big easier. 





In this post, I will descirbe the sections that do not seem obvious only. Read the comments within the code to get some insight as to what is going on. 





##### Start / Stop Clock





_StartTime_ is simply a variable to keep track of how long it takes to run this code. More for curiosity than anything else. You will see how this get's calculated at the end. 




    
    #####################################################################
    #Set Up of Enviornment
    #####################################################################
    StartTime = Sys.time()
    





##### Create Logger File





It is sometimes important to log big events. I created this just to get some practice with logging. This chuck of code will create a log file called "SOLAR_LOGGER" and append today's date. This way, everything you log will be captured in today's log file only. Tomorrow, a new log file will be created if you run the code. This can help keep track of changes. 




    
    #Set up a logger file system
    LoggerFile = 'SOLAR_LOGGER'
    
    #Create a log file using LoggerFile + Append today's Date
    fileDate = paste(LoggerFile, Sys.Date(), sep = " ")
    fileDate = paste(fileDate, ".txt")
    
    #Create Daily Log File
    if (!file.exists(fileDate)){
      write("Solar Logger File Created ", 
            fileDate)
    } else {
      if (existsFunction("function.logger")){
        function.logger("File overwrite denied!",2)
      } else {
        warning("function.logger() Not Executed Yet")
      }
    }
    





Note that the above code only created the actual file. 





##### Logger Function





Now, we will create the logger function. Feel free to to change the _typeError_ messages to suit your needs. 




    
    #Logger Function
    function.logger = function(logInput = "No Input Defined", typeError = 1) {
      lineAppend = paste(Sys.time() , logInput, sep = " ")
    
      if (typeError == 1){
        message("See Logger")
      }
      if(typeError == 2){
        warning("See Logger")
      }
      if (typeError == 3){
        stop("EXECUTION STOPPED: See Logger")
      }
    
      write(lineAppend, file = fileDate, append = TRUE)
    }
    




    
    function.logger("LOGGER FILE")
    




    
    <code>## See Logger
    </code>





The logger file has been created. You should see a **LOGGERFILE** text file in the working directory now. 





##### Import Data





Next we import the data, if it exists. It's available on the kaggle site an later I will upload it to this post for direct download as well. The name of the file is "SolarPrediction.csv" and it has a header. 




    
    #####################################################################
    #Import Data / Add Libraries
    #####################################################################
    
    SolarCSV = "SolarPrediction.csv"
    if (file.exists(SolarCSV)){
      Solar=read.csv(file="SolarPrediction.csv", header=TRUE)
    } else {
      function.logger("File missing. stop() called.", 3)
    }
    





##### Column Names





Now that the Solar data frame is created, click on the enviornment variable to view the header and contents. Notice the "Data" column should really read "Date." Let's change that. 




    
    #Rename "Data" field to 'Date' for readability
    names(Solar)[names(Solar) == 'Data'] = 'Date'
    function.logger("Renamed Data column to Date")
    
    attach(Solar)
    





##### Libraries





Install proper libraries.




    
    #Libraries
    if(!require(chron)){ 
      install.packages("chron") 
      library(chron)
      function.logger("Installed chron package.", 1)
    }
    
    if(!require(tseries)){ install.packages("tseries")
      library(tseries)
      function.logger("Installed tseries package.", 1)
    }
    
    if(!require(data.table)){ install.packages("data.table")
      library(data.table) 
      function.logger("Installed data.table package.", 1)
    }
    





Drop redundant data, convert time into _chron_ time objects and create new variables _Hour_, _Minute_, and _DayLength_




    
    #####################################################################
    #Clean Data
    #####################################################################
    
    drops <- c("UNIXTime") #List of items to drop from Data.Frame
    Solar = Solar[ , !(names(Solar) %in% drops)]
    function.logger("Removed UNIXTime from Data.")
    
    #Convert date/times to date/time objects
    Solar$TimeSunRise = chron(times = as.character(TimeSunRise))
    Solar$TimeSunSet = chron(times = as.character(TimeSunSet))
    Solar$Hour = as.numeric(format(strptime(Time,"%H:%M:%S"),'%H')) #Show just the Hour
    Solar$Minute = format(strptime(Time, "%H:%M:%S"), '%M') #Show just the Minute
    Solar$Date = as.character(Solar$Date)
    Solar$Date = substr(Solar$Date,1, nchar(Solar$Date)-12)
    Solar$Date = chron(date = Solar$Date, #Strip time off - invalid data   ######FLAG
                       format = "m/d/y") #Time component not valid, removed
    
    #Calculate Length of Day
    Solar$DayLength = Solar$TimeSunSet - Solar$TimeSunRise
    





I never used this chuck but it may be useful. 




    
    #Assignments for Averages Data
    RadH = (aggregate( Radiation ~ Hour, Solar, mean ))
    HumH=(aggregate( Humidity ~ Hour, Solar, mean ))
    PresH=(aggregate( Pressure ~ Hour, Solar, mean ))
    WinH=(aggregate( WindDirection.Degrees. ~ Hour, Solar, mean ))
    SpeedH=(aggregate( Speed ~ Hour, Solar, mean ))
    





##### Wind Direction





Having wind directions of say, 359 degrees an 2 degrees are vastly different numerically; however, they are essentially the same thing as saying "North." The next chuck simply converts wind direction numerics into factors of N, E, W, and S.





Even though I converted these, I did not use them in analysis yet. How should I average directions over an hour's period? Or over a week? Based on frequeny of occurance? I have't had time to figure that out yet, perhaps you can find a good use for it.




    
    #Convert Wind Direction into Factors N, E, W, S based on values
    function.WindDirToFactors = function(degVect){
      result = "ERROR"
      if (degVect >= 315 || degVect < 45) { result = "N" }
      if (degVect >= 45 && degVect < 135) { result = "E" }
      if (degVect >= 135 && degVect < 225){ result = "S" }
      if (degVect >= 225 && degVect < 315){ result = "W" }
    
      if (result == "Error"){
        function.logger("Wind Direction out of Range", 1)
      }
    
      return(result)
    }
    





##### Week Number





I wanted to look at weekly averages so this function helps convert dates into the actual week number of the year, 1-52. 




    
    #Convert Date to the Numbered Week of the Year
    function.weekofyear <- function(dt) {
      as.numeric(format(as.Date(dt), "%W"))
    }
    
    #Calculate Week Number and Assign Wind Directions to Data
    WeekNum = rep(0, length(Solar$Date))
    WindDirection.Factors = rep(0, length(Solar$WindDirection.Degrees.)) #Place Holder
    for (i in 1:length(WindDirection.Factors)){
      WindDirection.Factors[i] = function.WindDirToFactors(Solar$WindDirection.Degrees.[i])
      WeekNum[i] = function.weekofyear(Solar$Date[i])
    }
    
    #Create New Column "WeekNum" and attach
    Solar$WeekNumber = WeekNum
    function.logger("Added WeekNumber column.", 1)
    
    WindDirection.Factors = as.factor((WindDirection.Factors))
    Solar$WndDirFact = WindDirection.Factors #add wind dir factors to original data.frame
    function.logger("Added WndDirFact column.", 1)
    
    #Reattach Solar for use of new columns without scoping
    detach(Solar)
    attach(Solar)
    





##### Grouping Data





I highly recommend using **Data Tables** rather than **Data Frames** for this next chunk of code. Data Tables allow SQL type queires direclty in the column or row areas of the brackets. It automatically groups them by grp_cols and applies whatever function you want to the parameters.





In the first case, we group by mean values of the actual DATE and HOUR. This way, we can see, by the hour what the averages are. The other groupings are similar. 





Finally, I order the data by date. 




    
    #####################################################################
    #Aggregate Data
    #####################################################################
    
    #Using data.table for aggregtion features
    Solar.dt = data.table(Solar)
    Solar.dt.byweek = data.table(Solar)
    Solar.dt.byWkHr = data.table(Solar)
    
    #Group DATE with HOUR
    grp_cols = c(names(Solar)[11] , names(Solar[1])) #Columns to Group By
    Solar.dt = Solar.dt[,list(RadMean = mean(Radiation), 
                              PresMean = mean(Pressure),
                              TempMean = mean(Temperature), 
                              HumMean = mean(Humidity),
                              SpeedMean = mean(Speed),
                              WeekNumMean = mean(WeekNumber)),
                        by = grp_cols]
    
    #Group by WEEK
    grp_cols = c(names(Solar[14])) #Columns to Group By
    Solar.dt.byweek = Solar.dt.byweek[,list(RadMean = mean(Radiation), 
                                            PresMean = mean(Pressure),
                                            TempMean = mean(Temperature), 
                                            HumMean = mean(Humidity),
                                            SpeedMean = mean(Speed)),
                                      by = grp_cols]
    
    #Group by WEEK-HOUR
    grp_cols = c(names(Solar[14]), names(Solar[11])) #Columns to Group By
    Solar.dt.byWkHr = Solar.dt.byWkHr[,list(RadMean = mean(Radiation), 
                                            PresMean = mean(Pressure),
                                            TempMean = mean(Temperature), 
                                            HumMean = mean(Humidity),
                                            SpeedMean = mean(Speed)),
                                      by = grp_cols]
    
    
    #####################################################################
    #Order Data
    #####################################################################
    
    #Order Data
    Solar = Solar[order(Date),]
    Solar.dt = Solar.dt[order(Solar.dt$WeekNumMean),]
    Solar.dt.byweek = Solar.dt.byweek[order(Solar.dt.byweek$WeekNumber),]
    Solar.dt.byWkHr = Solar.dt.byWkHr[order(Solar.dt.byWkHr$WeekNumber, Solar.dt.byWkHr$Hour),]
    





##### Output Files





I chose to create output files for various ways the data was manipulated. Mainly because I am going to work as a team for the analysis portion of this possibly. I want to be able to send just the data to teammates and not let them worry about cleaning. 




    
    #####################################################################
    #Output .csv Files for Statistics
    #####################################################################
    write.csv(Solar, file = "Solar1.csv", row.names = FALSE)
    write.csv(Solar.dt, file = "Solar2.csv", row.names = FALSE)
    write.csv(Solar.dt.byweek, file = "Solar3.csv", row.names = FALSE)
    write.csv(Solar.dt.byWkHr, file = "Solar4.csv", row.names = FALSE)
    
    function.logger("Created Solar1.csv - Cleaned Version of Original", 1)
    function.logger("Created Solar2.csv - Average Values by Hour", 1)
    function.logger("Created Solar3.csv - Average Values by Week", 1)
    function.logger("Created Solar4.csv - Average Values by Week-Hour", 1)
    





##### Runtime Stats





This is the part of the code that can give us an idea of how long the cleansing process took. 




    
    #####################################################################
    #Runtime Statistics - Goes at END OF FILE
    #####################################################################
    detach(Solar)
    EndTime = Sys.time()
    TotalTime = EndTime - StartTime
    
    RunTime = paste("Total Run Time = ", round(TotalTime,4), "seconds.")
    function.logger(RunTime)
    
    plot(Solar.dt$RadMean[1:120], ylab = "SolarRadiation Mean", xlab = "Hour", col = "blue")
    





![plot of chunk unnamed-chunk-5](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAfgAAAH4CAYAAACmKP9/AAAEDWlDQ1BJQ0MgUHJvZmlsZQAAOI2NVV1oHFUUPrtzZyMkzlNsNIV0qD8NJQ2TVjShtLp/3d02bpZJNtoi6GT27s6Yyc44M7v9oU9FUHwx6psUxL+3gCAo9Q/bPrQvlQol2tQgKD60+INQ6Ium65k7M5lpurHeZe58853vnnvuuWfvBei5qliWkRQBFpquLRcy4nOHj4g9K5CEh6AXBqFXUR0rXalMAjZPC3e1W99Dwntf2dXd/p+tt0YdFSBxH2Kz5qgLiI8B8KdVy3YBevqRHz/qWh72Yui3MUDEL3q44WPXw3M+fo1pZuQs4tOIBVVTaoiXEI/MxfhGDPsxsNZfoE1q66ro5aJim3XdoLFw72H+n23BaIXzbcOnz5mfPoTvYVz7KzUl5+FRxEuqkp9G/Ajia219thzg25abkRE/BpDc3pqvphHvRFys2weqvp+krbWKIX7nhDbzLOItiM8358pTwdirqpPFnMF2xLc1WvLyOwTAibpbmvHHcvttU57y5+XqNZrLe3lE/Pq8eUj2fXKfOe3pfOjzhJYtB/yll5SDFcSDiH+hRkH25+L+sdxKEAMZahrlSX8ukqMOWy/jXW2m6M9LDBc31B9LFuv6gVKg/0Szi3KAr1kGq1GMjU/aLbnq6/lRxc4XfJ98hTargX++DbMJBSiYMIe9Ck1YAxFkKEAG3xbYaKmDDgYyFK0UGYpfoWYXG+fAPPI6tJnNwb7ClP7IyF+D+bjOtCpkhz6CFrIa/I6sFtNl8auFXGMTP34sNwI/JhkgEtmDz14ySfaRcTIBInmKPE32kxyyE2Tv+thKbEVePDfW/byMM1Kmm0XdObS7oGD/MypMXFPXrCwOtoYjyyn7BV29/MZfsVzpLDdRtuIZnbpXzvlf+ev8MvYr/Gqk4H/kV/G3csdazLuyTMPsbFhzd1UabQbjFvDRmcWJxR3zcfHkVw9GfpbJmeev9F08WW8uDkaslwX6avlWGU6NRKz0g/SHtCy9J30o/ca9zX3Kfc19zn3BXQKRO8ud477hLnAfc1/G9mrzGlrfexZ5GLdn6ZZrrEohI2wVHhZywjbhUWEy8icMCGNCUdiBlq3r+xafL549HQ5jH+an+1y+LlYBifuxAvRN/lVVVOlwlCkdVm9NOL5BE4wkQ2SMlDZU97hX86EilU/lUmkQUztTE6mx1EEPh7OmdqBtAvv8HdWpbrJS6tJj3n0CWdM6busNzRV3S9KTYhqvNiqWmuroiKgYhshMjmhTh9ptWhsF7970j/SbMrsPE1suR5z7DMC+P/Hs+y7ijrQAlhyAgccjbhjPygfeBTjzhNqy28EdkUh8C+DU9+z2v/oyeH791OncxHOs5y2AtTc7nb/f73TWPkD/qwBnjX8BoJ98VVBg/m8AAEAASURBVHgB7J0JvE1V+8d/ykzGiJBZhUQpVK+oCMVbkaLBlEJRhiYqpQkl0USTSoM0kSGpNxqp+BsKKUmUFGWqjNn/9durc+85997DHc6wz96/9fmce/feZ5+91vqutdezhmc9Tz7HBCiIgAiIgAiIgAj4isBhvsqNMiMCIiACIiACIuASkIBXRRABERABERABHxKQgPdhoSpLIiACIiACIiABrzogAiIgAiIgAj4kIAHvw0JVlkRABERABERAAl51QAREQAREQAR8SEAC3oeFqiyJgAiIgAiIgAS86oAIiIAIiIAI+JCABLwPC1VZEgEREAEREAEJeNUBERABERABEfAhAQl4HxaqsiQCIiACIiACEvCqAyIgAiIgAiLgQwIS8D4sVGVJBERABERABCTgVQdEQAREQAREwIcEJOB9WKjKkgiIgAiIgAhIwKsOiIAIiIAIiIAPCUjA+7BQlSUREAEREAERkIBXHRABERABERABHxKQgPdhoSpLIiACIiACIiABrzogAiIgAiIgAj4kIAHvw0JVlkRABERABERAAl51QAREQAREQAR8SEAC3oeFqiyJgAiIgAiIgAS86oAIiIAIiIAI+JCABLwPC1VZEgEREAEREAEJeNUBERABERABEfAhAQl4HxaqsiQCIiACIiACEvCqAyIgAiIgAiLgQwIS8D4sVGVJBERABERABCTgVQdEQAREQAREwIcEJOB9WKjKkgiIgAiIgAhIwKsOiIAIiIAIiIAPCUjA+7BQlSUREAEREAERkIBXHRABERABERABHxKQgPdhoSpLIiACIiACIiABrzogAiIgAiIgAj4kIAHvw0JVlkRABERABERAAl51QAREQAREQAR8SEAC3oeFqiyJgAiIgAiIgAS86oAIiIAIiIAI+JCABLwPC1VZEgEREAEREAEJeNUBERABERABEfAhAQl4Hxaq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CUeuCEVABERABEQg/gQk4OPPWDGIgAiIgAiIQMIJSMAnHLkiFAEREAEREIH4E5CAjz9jxSACIiACIiACCScgAZ9w5IpQBERABERABOJPQAI+/owVgwiIgAiIgAgknIAEfMKRK0IREAEREAERiD8BCfj4M1YMIiACIiACIpBwAhLwCUeuCEVABERABEQg/gQk4OPPWDGIgAiIgAiIQMIJSMAnHLkiFAEREAEREIH4E5CAjz9jxSACIiACIiACCScgAZ9w5IpQBERABERABOJPQAI+/owVgwiIgAiIgAgknIAEfMKRK0IREAEREAERiD8BCfj4M1YMIiACIiACIpBwAp4T8Pv378fWrVsTDkIRioAIiIAIiICfCHhCwO/duxdDhw5FlSpVULBgQZQpUwbFihVD/fr1MWnSJD/xVl5EQAREQAREICEE8icklkNE0r9/f2zatAmzZs1CjRo1XOG+Y8cOrFy5EjfccAN2796Nvn37HuIp+loEREAEREAERCBEwBMj+Llz52LixIlo0KABihcvjnz58qFkyZJo1qwZxo0bh2nTpoXSq/8iIAIiIAIiIALZIOAJAc+p+Hnz5mWZ3JkzZ6JcuXJZfqeLIiACIiACIiACWRPwxBT9iBEj0LVrV4wdOxY1a9ZEiRIlsH37dqxatQpUups9e3bWqddVERABERABERCBLAl4QsA3atQIS5YswYIFC7Bu3Tp3PZ6jdq67N2/e3J2yzzL1uigCIiACIiACIpAlAU8IeKascOHCaNmypTti37lzJ0qXLp1lgnVRBERABERABETg0AQ8sQavbXKHLijdIQIiIAIiIAI5IeCJEXystsm98cYbUdfrFy5ciKOOOionbHSvCIiACIiACKQsAU8IeG6T4/p7hQoV0kCGb5MbPnx4tvbBc4qf6/lZhbvvvhvcW68gAiIgAiIgAkEg4AkBH9om16VLl0zMc7JNjhbw+MkqlCpVyjWYk9V3uiYCIiACIiACfiPgCQGvbXJ+q1bKjwiIgAiIQLIJeELAZ7VNrmzZsujWrRvatGmjbXLJriWKXwREQASSTMCs4hpbKTDOyAAzIYunnrL/k5wsT0fvCS16ro0/+uijeOihh1CtWjXUq1cPw4YNwyWXXIJrrrkGf/75p6chKnEiIAIiIALxI7B6NXDLLcDttwPGuKkxjAZceimMXlX84vTDkz0h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3X3Q/q/xmXPIffB8D4466qjMXwbkCt8B2oIIsk2QX375BRUrVky5EpeAT7kiU4JFQAREQARE4NAEgjk0OzQX3SECIiACIiACKU1AAj6li0+JFwEREAEREIGsCUjAZ81FV0VABERABEQgpQlIwKd08SnxIiACIiACIpA1AQn4rLnoqgiIgAiIgAikNAEJ+JQuPiVeBERABERABLImIAGfNRddFQEREAEREIGUJiABn9LFp8SLgAiIQGwI0LATDfsEOezbt89X2ZeAz6I477//fjRo0ADVq1cHj4MQXnnlFZx11lk48cQTcfnll2PVqlVp2Q4Sjx07dqBq1ap4//330/I/f/58nHHGGW59uPDCC13rdmlf+ujg888/R+PGjVGvXj2cf/75gasDP/30E6644go0bNgQbdu2xYcffphWun6vAxs2bHDr/dq1a9PyTAt2nTt3Ru3atXHCCSfgs88+S/vOjzzYBjZr1iwtjzxI+XbR9NgUwghMnTrVOf30051t27Y5xjyhYwSeM3v27LA7/HfIfBpTnM6mTZvczD377LNO69at3eOg8ejRo4dTqlQp57333nPzv3nzZseYqHSWLVvmGPPFzsCBAx3e47ewe/dup0aNGs6CBQvcrJmGzenYsaN7HJQ6cNVVVzn33Xefm+cvv/zS5WFGdI7f68DTTz/t1KxZ0ylQoICzZs2atKp98cUXO3fffbdz4MABZ968eW4b8ffff/uOxx9//OFce+21Trly5ZyTTjopLf9+aBc1go/orwFz5sxxR7C0v12hQgV06dIFb731Voa7/HVqXmCYRjzN3jZH8aHeepB4TJs2zbW3XadOnbQCXrRoEY4//nh3Rsc0gOjfvz/efPPNtO/9cmA6sahVqxaaNm2K7du349JLL8Xrr7/uZi8odcAIchQsWNDN8xFHHAHT4cU///wDP9cB+tzgu8/yNx3biOrMcu/Xrx/y5cuHFi1aoHLlyvjkk098x+N///sfihYtiueffz4i/35oFyXgI4oUWL9+fYRTAQr5X3/9NcNd/jo9+uij0bx587RMPfnkkzjvvPPc86DwoEMRM1rByJEj0zjwIGP+6XSEAnDPnj0R96X6yY8//ug6VmI9MCMZmBEdVqxY4WYrIwO/vhP33HMPnnrqKXTq1AmtWrXC448/jkKFCvm6DrBD8+677yK8U8tC5/Q863i4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)




    
    plot(Solar.dt.byWkHr$RadMean[1:24], col = "red", ylab = "Mean Rad week-hr", xlab = "Hour of Day")
    





![plot of chunk unnamed-chunk-5](data:image/png;base64,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oFABAnyhPKxEAAEEEEDAnwIEeH/WG7lGwBMC+/fv1w8//OCJvJAJBBCIFCDAR3owh4BnBbp06aKHH344In+bNm2SZVnau3dvxPIjMZOZmak6deqoc+fOys3NDR9y+/btbp6qVq0q86lWrZrOOOMMvfjii+Ft+IIAAiUvUKbkD8EREEAgGQVeffVVjRo1SrfcckvU4m3YsMEN7ib4v/POO+rXr5/KlSunSy65JOr2LEQAgcQK0IJPrCepIVCqAiaQ9ujRQzVr1lT37t21ZcsWNz///Oc/9fjjj4fzNn78eE2ePNmdb9eune6++263Nf7GG2+EtzFfQqGQHn30UbVs2VL169fXHXfc4S4z25sWubmicPPNN0fsc/BMmTJldP7552vo0KG677773NU///yzBg0a5KZp8nrFFVdo165dmj9/vi6//PJwEubHwVlnnaVt27aFl/EFAQTiE6AFH58TWyHgCYFXXnlF2dnZ4bzs3r07/P3bb79Vt27dNHHiRDfwjh49WgMGDNC8efPc++TBYDC87ffff69A4Nff9998842OOuooPfXUU24gD2/kfHnsscc0adIkPf300+5l+KuvvtoNyn/961/15Zdf6tRTT9WNN96Yf5eY308//XQ99NBD7nqTxzVr1mjZsmXasWOHm+8ZM2aoV69e7g+UjRs3usdZtGiRypYtq6OPPjpmuqxAAIHoArTgo7uwFAFPCti27bagTcs675OX0dmzZ6t58+YyQbhBgwa688473RZxPJ3ghg0bJnOP39xTzz89//zzuu6663T22WerdevWbtrTpk1ThQoV3MBbsWJFmU88U7169dxgbsrQp08fPfvsszrmmGNUvnx5nXDCCe7VhsqVK6tTp04yP2TM9NJLL7lBP5702QYBBCIFCPCRHswh4GkBc/ndtILzPuPGjQvnd926dWrVqlV4vkmTJm7L13TEO9TUsGHDqJuYNNPT08PrzPd40gvvkO/L+vXr3Va56RSYlpYmcxUgr5Pe6tWrlXeFwbTiZ86c6c6/9tprEZfs8yXHVwQQOIQAAf4QQKxGwC8CtWrVUlZWVji7mzdvlunRfvzxx7uX4/ft2xdet3Xr1vB388UE3GiTSXPFihXhVeayfKNGjcLzRfny+uuvh38smPvv5t67SW/58uXuFQLTsjeTacF//vnnMtuffPLJMi1/JgQQKLoAAb7oZuyBgCcFLrroIr333ntuQDaX76dMmaJmzZq5PdlNS/mjjz6SCaIm8L/99ttxlcGk+cILL2jnzp3ujwVzyfyPf/xjXPuae+vmB8bXX3/t9gl47rnnNHLkSHdf02nu3HPPdS/Rf/fdd1qwYIEOHDjgrjOX7M3tgjFjxujKK6+M61hshAACBQXoZFfQhCUI+FLA9Da//fbb3daw6ZRmxp/n3cs2Q9T+/e9/u5fIzfKOHTvGVcaMjAx3eJu5CmB6w3fo0EFmWTyT2cdM5r5606ZN3fvpZ555prvMdAAcMWKEHnnkEfdHx6WXXipzmT5v6t27t/vD4rLLLstbxL8IIFBEAcv5Rf/rdbEi7sjmCCDgTQEztMy0uKP1PDeX5mvXrl3kjOfk5Lg97U3nukRN5k+Pacmb2wAHT+by/JNPPikz1p4JAQSKJ0CAL54beyGAQAkImKBvxtXPmjXLveJgLuMzIYBA8QS4B188N/ZCAIESEDA97E2nOvMQHoJ7CQCTZEoJ0IJPqeqmsAgggAACqSJACz5VappyIoAAAgiklAABPqWqm8IigAACCKSKAAE+VWqaciKAAAIIpJQAAT6lqpvCIoAAAgikigABPlVqmnIigAACCKSUAAE+paqbwiKAAAIIpIoAAT5VappyIoAAAgiklAABPqWqm8IigAACCKSKAAE+VWqaciKAAAIIpJQAAT6lqpvCIoAAAgikigABPlVqmnIigAACCKSUAAE+paqbwiKAAAIIpIoAAT5VappyIoAAAgiklAABPqWqm8IigAACCKSKwP8D0IChzpLnEYMAAAAASUVORK5CYII=)




    
    #####################################################################
    





##### Next Steps





To be honest, this is rather crude and I am sure there is a lot of wasted steps and more elegant ways of doing this. As I learn the R language, I hope to improve naturally. Sometimes you just have to get things done though. 





There are some hours with 0 observations, we may want to impute or discard that data. Just note that their are still some problems with this data. I will expand this post if I end up cleaning it up a bit more. 





