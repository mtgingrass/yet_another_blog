---
author: mtgingrass
comments: true
date: 2017-08-22 19:12:24+00:00
layout: post
link: http://devgin.com/2-c-programming-basics/
slug: 2-c-programming-basics
title: 2. C++ Programming Basics
wordpress_id: 69
categories:
- C++
tags:
- if
- if statements
- operators
---

[embed]https://youtu.be/k4r8I7qMU7w?list=PL0oBhq0tLsOBzIXpM98ezhrBHse5IJ776[/embed]

Now learn how to print to the screen and get user input from the keyboard in this tutorial!

Code is below just in case you get stuck or want to cut/paste into your own program.

<!-- more -->










    
    <code>//ConsoleApplication3.cpp : Defines the entry point for the program
    #include "stdafx.h"
    #include 
    
    int main()
    {
        int integer1 = 0, integer 2 = 0;
        
        std::cout << "Enter the first integer\n"; 
        std::cin << integer1;
    
        std::cout << "Enter second integers\n"; 
        std::cin >> integer2;
    
        //Pause Code
        int pause;
        std::cin >> pause;
        
        return 0;
    }
    
    </code>


Let's break the code down line by line once again. Notice I add a few more weird symbols in each of the successive tutorials. I do this on purpose to build one step at a time.

**Line 1 ** is a comment as before.
**Line 2-3** are pre-compiled headers to speed up compile time.
**Line 5** This defines a function (required function for that) called _main_. It is defined from bracket _{_ to bracket _}_. Everything between the open and closed bracket are part of that function and the functions scope.

Scope is just like the word sounds. It defines the boundaries of where things are defined and usable. Anything inside the function can be used within the function. Outside the brackets, and outside the function, all of the variables and code is not useable. More into that when we deal with functions that are users defined.

**Line 7** Notice we defined more than one integer value on the same line this time. You can use a comma to separate variable; however, they must all be of the same type, i.e. _integer_ values in this case. Also notice, not only did we declare multiple variables, we also _initialed_ them. We assigned values of _0_ for all variables.

**Line 9** This asks the user by printing to the screens one text. Remember the _<<_ is pushing the text to the "output device."
**Line 10** This reads input from the keyboard and pushes the input to the variable called _integer1_.


## Variable Names:


There are naming convections and rules to how you can name variables. Some of the rules are as follows:



 	
  1. Only Alphabetical, Digits and Underscores are permitted

 	
  2. Cannot start with a digit.

 	
  3. Reserved words cannot be used as a name.

 	
  4. Upper case and lower case letters are distinct.

 	
  5. Special Characters are not allowed.





[Next -> If Statements and Oprerators](http://devgin.com/3-c-programming-basics-statements-operators/)





[![](//a.impactradius-go.com/display-ad/3094-178129)](//partners.hostgator.com/c/418006/178129/3094)![](//partners.hostgator.com/i/418006/178129/3094)
