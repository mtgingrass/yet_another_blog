---
title: Visual Resume
author: Mark Gingrass
date: '2019-01-05'
slug: visual-resume
categories:
  - Tools
  - self-improvement
tags:
  - resume
  - R
  - programming
  - fun
---

## Visual Resume Timeline
I came across this [Github](https://github.com/ndphillips/VisualResume) package by ndphillips and thought it was pretty cool and decided to make it even easier to setup. I really just wanted to play with it so here is my excuse. 

![My Visual Resume](VisualResume.png)


## Setup
Most people who have used R for a few weeks or months have probably already installed **devtools**. Just in case it isn't already installed, simply uncomment line 18 to install for the first time 

```{r setup, include=FALSE }
## Uncomment line 10 if you need to install "devtools"
#install.packages("devtools")

devtools::install_github("ndphillips/VisualResume")

library(VisualResume)
```

## Top Left
Fill in **Name**, **Designator**, **Title** and **Company/Office**
Then direclty below that, choose the size of each font

```{r}
## Top Left of Visual Resume
  titles_top_left = c("Mark Gingrass, MBA", ## Name, Designator
                  "Operations Researcher", ## Title
                  "FDA Office of Science / Regulatory Informatics") ## Company/Office
  ## Font sizes
  titles_top_left_font_sizes = c(4, ## Size of Name 
                      2, ## Size of Title
                      1) ## Size of Company/Office
```

## Top Right
Fill in **Personal Web Site**, **Email** and **Github** url. 
Then directly below that, choose the size of each font.

```{r}
  ## Top Right of Visual Resume
    titles_top_right = c("MarkGingrass.com", ## Personal Site
                     "mark.gingrass@gmail.com", ## Email
                     "github.com/mtgingrass") ## Github

    ## Font sizes
    titles_top_right_font_sizes = c(2, ## Size of Personal Site
                         2, ## Size of Email
                         1) ## Size of Github
```

## Timeline Labels
The top and bottom of timeline labels.

```{r}
timeline_top_label <- "Education"
timeline_bottom_lable <- "Career"

timeline_labels = c(timeline_top_label, timeline_bottom_lable)
```

## Timeline Data
Although you can create a timeline from any data range, there is only a finite amount of screen real estate to display it. Technically, you can create a **png** file that can fit larger ranges and display only parts of it at a time on the screen. The choice is yours. 

You can delete or add more entries - just follow the pattern. To add, simply cut and paste the last entry and add a new index value. 

```{r}
## Top and Bottom side of timeline placement
top_side = 1
bottom_side = 0

title_sub_start_end_side = list()

title_sub_start_end_side[[1]] <- (c("OK City Comm College",
                                  "Pre-Engineering, A.S.", 
                                  2006, 2007, top_side))

title_sub_start_end_side[[2]] <- (c("Southeastern OK State", 
                                  "BS Aviation Management", 
                                  2009, 2011, top_side))

title_sub_start_end_side[[3]] <- (c("Oklahoma City University", 
                                  "MBA", 
                                  2011, 2013, top_side))

title_sub_start_end_side[[4]] <- (c("Equipment Specialist", 
                                  "Turbo-Jet Engines", 
                                  2010, 2015, bottom_side))

title_sub_start_end_side[[5]] <- (c("Avionics Technician", 
                                  "Aircraft Electronic Test Equipment", 
                                  2006, 2010, bottom_side))

title_sub_start_end_side[[6]] <- (c("Avionics Test Station Tech", 
                                  "Active Duty Air Force", 
                                  2002, 2006, bottom_side))

title_sub_start_end_side[[7]] <- (c("Logistics Mngmt", 
                                  "USAF Supply Chain", 
                                  2015, 2016, bottom_side))

title_sub_start_end_side[[8]] <- (c("Operations Researcher", 
                                  "Data Science & Analysis Flight", 
                                  2016, 2018, bottom_side))

title_sub_start_end_side[[9]] <- (c("Operations Researcher", 
                                  "FDA Office of Science", 
                                  2018, 2019, bottom_side))
```


## Milestones!
Have any significant milestones in your career? Win the Nobel prize? Mark it as a milestone. 

```{r}
  milestones = data.frame(title = c("AS", "BS", "MBA"),
  
                          sub = c("Pre-Engineering", "Management", "Business"),
  
                          year = c(2007, 2010, 2013))
  
```

## Major Events

```{r}
  events = data.frame(year = c(2017.3, 2017, 2014, 2015, 2018),
  
                      title = c("Completed Army     Logistics               University's        OR/Systems       Analysis                for                Military Applications       Course",
  
                                "Supervisory     Development    Program               (SDP)",
  
                                "Created Blue Sky, the most potent methamphetamine ever produced.",
  
                                "Made first $1,000,000.",
  
                                "Made second $1,000,000"))
```

## Interests

```{r}
  interests = list("Programming" = c(rep("C++", 4),rep("R", 10), rep("Python", 1), rep("R", 2), "Data Science"),
  
                   "Machine Learning" = c(rep("Random Forrest", 10), rep("SVM", 5), rep("Regression", 3),rep("Neural Networks", 3)),
  
                   "Leadership" = c(rep("Commitment", 10), rep("Decision Making", 5), rep("Management", 30), rep("Innovation",10)))
  
  year.steps = 2
```


## Output PNG File
Due to the way I render and upload blogs, this will cause it to error on my end; however, if you should uncomment this chunk of code. 
```{r}
# png(filename = "VisualResume.png",
#     width = 1600, height = 800)
# 
#   VisualResume::VisualResume()
# 
# dev.off()
```