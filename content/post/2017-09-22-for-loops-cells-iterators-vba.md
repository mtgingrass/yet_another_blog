---
author: mtgingrass
comments: true
date: 2017-09-22 01:31:17+00:00
layout: post
link: http://devgin.com/for-loops-cells-iterators-vba/
slug: for-loops-cells-iterators-vba
title: For Loops, Cells & Iterators with VBA
wordpress_id: 259
categories:
- Programming
- VBA
tags:
- cells
- debug
- for loop
- for loops
- iterator
- iterators
---

## Cells and for loops.




In this tutorial, we will take a lateral approach to _ranges_ and instead, use _cells_.

This quick 5 minute video will walk you through why _cells_ are easier to work with when iterating through loops; specifically, _for_ loops. In addition, this video shows you the value of the debugger when testing programs at runtime. 
In this tutorial you will learn the basics of:



 	
  * Cells instead of Range

 	
  * For Loops


Watch the Video for step by step instructions.

[embed]https://youtu.be/pVIa7bDYHeg[/embed]


## Code


Copy and paste the code below to get you started.<!-- more -->


![](//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=US&ASIN=B01JLH2MIU&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=dynamic-ranges-modifying-macros-1-20)![](//ir-na.amazon-adsystem.com/e/ir?t=dynamic-ranges-modifying-macros-1-20&l=am2&o=1&a=B01JLH2MIU)[![](//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=US&ASIN=B002OHDIWY&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=dynamic-ranges-modifying-macros-2-20)](https://www.amazon.com/gp/product/B002OHDIWY/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B002OHDIWY&linkCode=as2&tag=dynamic-ranges-modifying-macros-2-20&linkId=2e5cbc40f658d67d91e9458f64790e16)![](//ir-na.amazon-adsystem.com/e/ir?t=dynamic-ranges-modifying-macros-2-20&l=am2&o=1&a=B002OHDIWY)




    
    <code>
    Option Explicit
    
    Sub using_cells()
        Dim iterator as Integer
        iterator = 1
           
        For iterator = 1 to 13
             Cells(10, iterator).Value = ""
        Next
    
    End Sub</code>




