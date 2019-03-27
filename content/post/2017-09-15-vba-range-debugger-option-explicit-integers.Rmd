---
author: mtgingrass
comments: true
date: 2017-09-15 22:29:57+00:00
layout: post
link: http://devgin.com/vba-range-debugger-option-explicit-integers/
slug: vba-range-debugger-option-explicit-integers
title: Useful Excel Template Building with VBA Range Methods and Objects!
wordpress_id: 216
categories:
- Programming
- VBA
tags:
- attributes
- dubug
- Excel
- integer
- method
- object
- option
- properties
- range
- VBA
---

## Learn practical code now!


Begin using this code immediately in the workforce! This tutorial will guide you through the use of _ranges_ and how to extract _values_ from cells and input _values_ into cells.

In this tutorial you will learn the basics of:



 	
  * Option Explicit - Why use it?

 	
  * Range - Useful for template building and more.

 	
  * Objects - What are they and tell me more!

 	
  * Debugger - Intro on how to troubleshoot with the debugger.

 	
  * Integer Variables - Storing data outside of Excel.


Watch the Video for step by step instructions.

[embed]https://youtu.be/jgwDwl3PjFA[/embed]


## Code


Copy and paste this code to get you started.

    
    <code>
    Option Explicit
    'Range Object
    'Debugger
    'What is an object
    'Quick Intro to Integer Variable
    
    Sub my_range()
        Range("A5").Value = 158
        Range("A6").Value = "Hello World"
        Range("A1").Select
        
        Dim my_cool_int As Integer
        
        my_cool_int = Range("A5").Value
        
        Range("D10").Value = my_cool_int
        
        Range("A1:D4").Value = 0
        
    End Sub</code>




## Range,


Use Range to return a _Range_ **object** that represents a single Excel cell or a range of cells. Once a Range object is created, you can extract data from cells or input data into cells with ease.

There are many other types of options for Range objects as well; such as, making it bold, italics, changing font style or size, or even locking the cell for example.</P


[![](//a.impactradius-go.com/display-ad/3094-178129)](//partners.hostgator.com/c/418006/178129/3094)![](//partners.hostgator.com/i/418006/178129/3094)





## Objects


Visual Basic is an Object-Oriented (OO) language. What is an **object**? An object is just as it sounds, only in a coded language. A television is an object, a basketball is an object, and a car is an object.

Objects have _methods_ and _properties_ (sometimes referred to as _attributes_).

A _method_ is a "do something" action. Turn the television on, change the station, set a timer, or change input methods are examples of _methods_ of an **object**.

Objects have _attributes_ as well. An _attribute_ is asking the object, "what color are you," or, "how tall are you, " or things such as, "how many miles can you run," or "what are you holding on to?"


## Using Objects


Properties of objects are referenced through the "dot" operator. Simply type the name of the object and an actual "dot" after it.

Example, a Television object might have a property such as **my_TV.**_Return_Channel_; where my_TV is a television **object** and _Return_Channel_ is a _property_ of that object. The properties name is "Return_Channel."

**my_TV.**_Set_Volume_ might be a television **object** called **my_TV** and a _method_ _Set_Volume_ that actually sets the televisions volume.


## Share and Click Links


Thank you for watching this tutorial. Stay tuned for more VBA tutorials.

Click the Link Below if you want to host yourname.com or check out the books!


[![](//a.impactradius-go.com/display-ad/3094-178142)](//partners.hostgator.com/c/418006/178142/3094)![](//partners.hostgator.com/i/418006/178142/3094)







