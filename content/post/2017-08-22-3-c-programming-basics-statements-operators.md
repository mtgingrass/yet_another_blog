---
author: mtgingrass
comments: true
date: 2017-08-22 19:16:51+00:00
layout: post
link: http://devgin.com/3-c-programming-basics-statements-operators/
slug: 3-c-programming-basics-statements-operators
title: 3. C++ Programming Basics (if statements and operators)
wordpress_id: 72
categories:
- C++
- Programming
tags:
- compare
- equality
- greater than
- if
- less than
- not-equal
---

[embed]https://youtu.be/VzmpwSKVtl8?list=PL0oBhq0tLsOBzIXpM98ezhrBHse5IJ776[/embed]

Using Visual Studio 2015 to create another C++ program.

This tutorial teaches the beginner programmer the basics of how to use **if** statements and comparison operators using C++. 

First by taking input from the keyboard and storing the user input into user defined variables. Next, printing the variables back to the output device, the screen, letting the user know if the numbers are equal, greater than, less than or not equal to each other. Get the code on the next page. <!-- more -->












    
    <code>//ConsoleApplication.cpp Defines the entry point for the console application.
    
    #include <stdafx.h>
    #include <iostream>
    
    int main()
    {
         int number1, number2;
    
    
         std::cout << "Enter two digits and I will tell you the relationship.\n";
         std::cin >> number1 >> number2
    
         if (number1 == number2)
         {
              std::cout << "EQUAL";
         }
    
         if (number1 > number2)
         {
              std::cout << "Number 1 is greater than number 2";
    
              'Bonus: Try un-commenting this line instead
              'std::cout << number1 << " is greater than " << number2;
         }
    
         if (number1 < number2)
         {
              std::cout << "Number 1 is less than number 2";
         }
    
    
         if (number1 != number2)
         {
              std::cout << "\nNumber 1 does not equal number 2";
         }
    
         //Pause Code
         int pause;
         std::cin >> pause;
     
         return 0;
    }</code>





[![](//a.impactradius-go.com/display-ad/3094-178129)](//partners.hostgator.com/c/418006/178129/3094)![](//partners.hostgator.com/i/418006/178129/3094)
