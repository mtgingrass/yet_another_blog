---
author: mtgingrass
comments: true
date: 2017-08-20 20:24:53+00:00
layout: post
link: http://devgin.com/1-first-c-program-using-visual-studio-2015/
slug: 1-first-c-program-using-visual-studio-2015
title: 1. First C++ Program using Visual Studio 2015
wordpress_id: 24
categories:
- C++
- Programming
---

[embed]https://www.youtube.com/watch?v=_iHMXDzyrhk&t;=621s&index;=1&list;=PL0oBhq0tLsOBzIXpM98ezhrBHse5IJ776[/embed]

Your very first C++ program using a free version of [Visual Studio 2015. ](https://www.amazon.com/gp/product/1119068053/ref=as_li_tl?ie=UTF8&tag=hatro-20&camp=1789&creative=9325&linkCode=as2&creativeASIN=1119068053&linkId=0bcd7a73db3170ad9756da36f691d7c5).  I increase font size in the later videos to help with readability.


Don't have Visual Studio or want to choose other alternatives? No problem. [This post](http://devgin.com/1-1-first-c-program-online-compiler-devc-and-downloading-microsoft-visual-studio/) will show you how to get started using an Online compiler, DevC++ (free) and how to download Visual Studio Community 2015.



I highly recommend any of the Deitel & Deitel books like this one linked: http://amzn.to/2vASq6Y.

Read on for the code to cut/paste if you prefer. I also break down each line with descriptions.<!-- more -->

You can always buy a previous edition to save money. Clicking the link helps me create videos like this.












    
    <code>//MyFirstProgramisCoo.cpp : Devines the entry point for the console application. 
    //This is a comment
    //More comments
    
    #include "stdafx.h"
    #include 
    
    int main()
    {
    
        std::cout << "Hello world!";
        std::cout << "more stuff";    
     
        int pause;    
        pause = 0;    
        std::cin >> pause;
    
        return 0;
    }</code>


**Lines 1 - 3** are comment lines. Anything you put after the double forward slash _//_ will not be compiled as code. Use this to add readability to your code. Once the code is compiled, these lines are ignored and they are not part of your final program.

**Line 5** is a unique line required for Visual Studio only. If you are not using Visual Studio, delete line 5. All this is doing is helping compile time by including precompile headers.What this means is that it takes a lot of processing time to generate a basic C++ program. Instead of waiting, Microsoft has included a way to speed up the time by "pre-compiling" parts of the program. This does add some bloat to the program, but for now, as a beginner, it is best to just use it.

**Line 11-12** are printing to the designated output, the screen. Think of std::cout as "Standard See Out," as in, "Seeing out to the screen. "C-Out." The two less than symbols is basically a way to push the text to the right of it, to the _output_ object - _cout._ This will become more clear later. Next is the text wrapped in quotes that you want printed. Finally, a semicolon will end the statement.

**Line 14** tells the compiler that you want to store an integer variable. It creates space in memory and assigns it the variable name "pause." At this point, "pause" is not initialized, it has not been assigned a value. This is dangerous because we might try to use this variable without ever assigning it anything leading to unpredictable values - after all, how do we know the memory location assigned to "pause" didn't have data in there already?

**Line 15** will assign the variable "pause" to a value of "0."

**Line 16** is the opposite of the _std::cout._ It is "See In" or _C-In._ Can you guess what it does? It's sees in an input to the input device, i.e. your keyboard and it assigns the input to the variable "pause." Notice the two greater than signs _>>._ Think of that as pushing things to the right into that variable. It pushes the keystroke from keyboard into the variable _pause._

The pause portion of this is important for this reason. C++ is going to do exactly what we, as programmers, tell it. Without the pause, the program will appear on the screen, print things to the screen, then close. We never told it to stay open, or display for seconds then do something else. Without the pause portion, it simply shuts the program down after execution and the user/customer never gets to see the display. 

Finally, the "return 0" statement. This tells the operating system that it has ended the program. The "O" is a parameter that can mean many different things. For now, since you are using Windows anyways, a return 0 means exit successfully. 

[Next -> how to print to the screen and get input from keyboard.](http://devgin.com/2-c-programming-basics/)

Comment below with any questions or tips you want to add. I'm sure I will get some comments about the use of the shopping operations "::" and std. Let's hear it!
