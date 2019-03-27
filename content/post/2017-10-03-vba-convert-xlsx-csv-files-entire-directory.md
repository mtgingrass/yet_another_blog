---
author: mtgingrass
comments: true
date: 2017-10-03 02:11:49+00:00
layout: post
link: http://devgin.com/vba-convert-xlsx-csv-files-entire-directory/
slug: vba-convert-xlsx-csv-files-entire-directory
title: VBA Convert XLSX to CSV Files - Entire Directory
wordpress_id: 287
categories:
- Programming
- VBA
---

## Convert File Extensions.




Sometimes, you find yourself converting one file extension to another for various reasons. Many software programs will not read files such as a **.xlsx** or **.xlsm** Excel file. They will, however, easily read a .csv file. 



In this tutorial, I will show you how to use an already created macro to convert an entire directory of files to a new file extensions almost instantly. Saves a tremendous amount of time using macros for this. 

In this tutorial you will learn:



 	
  * How to convert XLSX file extensions to .csv

 	
  * How to convert any file extension to another

 	
  * How to open a dialog box for user input (folder selection)


Watch the Video for a step by step guide on how to use this macro. 

[embed]https://youtu.be/Pzk1Iq5jSxo[/embed]


## Code


Copy and paste the code below to get you started.<!-- more -->


![](//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=US&ASIN=B01JLH2MIU&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=dynamic-ranges-modifying-macros-1-20)![](//ir-na.amazon-adsystem.com/e/ir?t=dynamic-ranges-modifying-macros-1-20&l=am2&o=1&a=B01JLH2MIU)[![](//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=US&ASIN=B002OHDIWY&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=dynamic-ranges-modifying-macros-2-20)](https://www.amazon.com/gp/product/B002OHDIWY/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B002OHDIWY&linkCode=as2&tag=dynamic-ranges-modifying-macros-2-20&linkId=2e5cbc40f658d67d91e9458f64790e16)![](//ir-na.amazon-adsystem.com/e/ir?t=dynamic-ranges-modifying-macros-2-20&l=am2&o=1&a=B002OHDIWY)




    
    <code>
    Option Explicit
    
    Sub ConvertToCsv()
        Dim wb As Workbook
        Dim sh As Worksheet
        Dim myPath As String
        Dim myFile As String
        Dim myExt As String
        Dim NewWBName As String
        Dim ChooseFolder As FileDialog
        
        'Optimize
          Application.ScreenUpdating = False
          Application.EnableEvents = False
          Application.Calculation = xlCalculationManual
        
        'Retrieve Target Folder Path From User
        Set ChooseFolder = Application.FileDialog(msoFileDialogFolderPicker)
        
        ChooseFolder.Title = "Select Target Path"
        ChooseFolder.AllowMultiSelect = False
                
        If ChooseFolder.Show <> -1 Then GoTo NextCode
            myPath = ChooseFolder.SelectedItems(1) & "\"
        
        'Cancel
    NextCode:
        myPath = myPath
        If myPath = "" Then Exit Sub
        
        'File Ext to Change
        myExt = "*.xls*"
        
        'Target Path with Ending Extention
        myFile = Dir(myPath & myExt)
        
        'Loop through each Excel file in folder
        Do While myFile <> ""
            'Set variable equal to opened workbook
            Set wb = Workbooks.Open(Filename:=myPath & myFile)
            NewWBName = myPath & Left(myFile, InStr(1, myFile, ".") - 1) & ".csv"
            ActiveWorkbook.SaveAs Filename:=NewWBName, FileFormat:=xlCSV
            ActiveWorkbook.Close savechanges:=True
            'Get next file name
            myFile = Dir
        Loop
        
        'Reset Macro Optimization Settings
        Application.ScreenUpdating = True
        Application.EnableEvents = True
        Application.Calculation = xlCalculationAutomatic
    End Sub</code>




