---
author: mtgingrass
comments: true
date: 2017-09-16 20:57:40+00:00
layout: post
link: http://devgin.com/dynamic-ranges-modifying-macros/
slug: dynamic-ranges-modifying-macros
title: Dynamic Ranges and Modifying Recorded Macros
wordpress_id: 239
categories:
- Programming
- VBA
tags:
- dynamic range
- formula
- range
- recoding macros
- selection
---

## Build Templates


In this tutorial, we will build upon the use of _ranges_ and combine recording macros with modifying your own macros.

In this tutorial you will learn the basics of:



 	
  * Adding formulas from VBA to Excel

 	
  * Dynamic Ranges

 	
  * Modifying Recorded Macros

 	
  * Selection object


Watch the Video for step by step instructions.

[embed]https://youtu.be/q8u4BlB2D2g[/embed]


## Code


Copy and paste the code below to get you started.<!-- more -->


![](//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=US&ASIN=B01JLH2MIU&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=dynamic-ranges-modifying-macros-1-20)![](//ir-na.amazon-adsystem.com/e/ir?t=dynamic-ranges-modifying-macros-1-20&l=am2&o=1&a=B01JLH2MIU)[![](//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=US&ASIN=B002OHDIWY&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=dynamic-ranges-modifying-macros-2-20)](https://www.amazon.com/gp/product/B002OHDIWY/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B002OHDIWY&linkCode=as2&tag=dynamic-ranges-modifying-macros-2-20&linkId=2e5cbc40f658d67d91e9458f64790e16)![](//ir-na.amazon-adsystem.com/e/ir?t=dynamic-ranges-modifying-macros-2-20&l=am2&o=1&a=B002OHDIWY)




    
    <code>
    Option Explicit
    
    Sub template_builder()
        Range("A1").Value = "Mark G"
        Range("A2").Value = "=today()"
        Range("A2").Select    
        Range(Selection, Selection.End(xlDown)).Select
        Selection.NumberFormat = "0.00"
    End Sub</code>




## Adding Formulas,


Changing a cells value with _Range.Value_ method works with formulas as well as regular inputs. Try _Range("A2").Value = "=now()"_ or _Range("A6").Value = "=B2 + B3"_


## Dynamic Ranges


Hard coding Ranges will limit the use of the _Range_ object. Remember, every key-stroke can be recorded via the macro recorder. If you know a shortcut key to select all, or navigate to a certain position, etc. Then it can be automated via VBA.

Watch the tutorial video to see a great example of this.


## Modifying Recorded Macros


Probably the most useful tool in our toolkit at the moment is recording macros. If you don't know the code, just record a macro and let the code be giving to you. It's that easy.

The hard part is the modification of the macros to suit a dynamic need. Recorded macros should be modified to suit your needs.

