---
author: mtgingrass
comments: true
date: 2017-09-21 03:16:48+00:00
layout: post
link: http://devgin.com/turn-flat-file-tabular-indexed-sections-data-manipulation-beta/
slug: turn-flat-file-tabular-indexed-sections-data-manipulation-beta
title: Turn Flat File into tabular indexed sections (data manipulation beta)
wordpress_id: 254
categories:
- Programming
- VBA
---

Watch the video on  how I take a raw data file with almost 4,000 rows and convert them into tabular sections of data based on a certain column/header value.


I created this today to complete a work tasking but plan on modifying it in the coming days/weeks to be much more user friendly. Despite, this is very useful code for anyone. 


[embed]https://youtu.be/2d4L-hmdSmk[/embed]
Feel free to modify to your liking and share. I will write up better explanations as this matures so please check back. 

Copy/paste code into your macro:


[![](//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=US&ASIN=B074XV4FTV&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=dynamic-ranges-modifying-macros-2-20)](https://www.amazon.com/gp/product/B074XV4FTV/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B074XV4FTV&linkCode=as2&tag=dynamic-ranges-modifying-macros-2-20&linkId=1c43b6e9fabebe5e83c06bb01c992fa7)![](//ir-na.amazon-adsystem.com/e/ir?t=dynamic-ranges-modifying-macros-2-20&l=am2&o=1&a=B074XV4FTV)




    
    <code>
    'Mark Gingrass (beta 1)
    'Watch how I take a raw data file with almost 4,000 rows and convert them into tabular sections of data
    'based on a certain column/header value. I created this today to complete a work tasking but plan on
    'modifying it in the coming days/weeks to be much more user friendly. Despite, this is very useful code for anyone.
    'Feel free to modify to your liking and share.
    Option Explicit
    
    Sub Initialize_Data()
        Call DefBusRules
        Call flat_file_to_tabs
        Call IndexIt
    End Sub
    
    Sub flat_file_to_tabs()
    
        'Declaration of Variables
        Dim lng_LastRow As Long
        Dim r1 As Long
        Dim int_StartingRow As Integer
        Dim int_StartingCol As Integer
        Dim str_CurrentMDS As String
        Dim int_HeaderRow As Long
        
        Worksheets("Raw Data").Activate
        'Inititializers
        int_StartingRow = InputBox("Starting Row of Data: ")
        int_StartingCol = InputBox("Column of Interest: ")
        int_HeaderRow = InputBox("Header Row (0 for none): ")
    
    
        'Get row count
        lng_LastRow = Cells(Rows.Count, int_StartingCol).End(xlUp).Row
        
        'Get first MDS
        str_CurrentMDS = Cells(int_StartingRow, int_StartingCol).Value
           
        'Loop through rows finding unique MDS's
        For r1 = int_StartingRow To lng_LastRow
            If Cells(r1, int_StartingCol).Value = str_CurrentMDS Then
                Call copy_paste_row(int_HeaderRow, r1, str_CurrentMDS)
            Else
            'insert blank row on top - may need to add more blanks for late ruse
                str_CurrentMDS = Cells(r1 + 1, int_StartingCol)
            End If
        Next
         Application.ScreenUpdating = True
    End Sub
    
    Sub copy_paste_row(int_HeaderRow As Long, int_RowToCopy As Long, str_TabName As String)
        Application.ScreenUpdating = False
        
        Dim lng_LastRow As Long
        Dim wsTest As Worksheet
        Dim offset As Integer
        
        offset = 5
        
        'test to see if tab already exists
        Set wsTest = Nothing
            On Error Resume Next
        Set wsTest = ActiveWorkbook.Worksheets(str_TabName)
        On Error GoTo 0
         
        'if tab does not exist, create one and insert header
        If wsTest Is Nothing Then
            Worksheets.Add.Name = str_TabName
            Worksheets("Raw Data").Activate
            Rows(int_HeaderRow).Select
            Selection.Copy
            Worksheets(str_TabName).Activate
            Rows(offset).Select
            ActiveSheet.Paste
        End If
        
        'Raw Data sheet should be active
        'paste row to the sheet
        Rows(int_RowToCopy).Select
        Selection.Copy
        
        'go back to sheet
        Worksheets(str_TabName).Activate
        lng_LastRow = Cells(Rows.Count, 1).End(xlUp).Row
        Rows(lng_LastRow + 1).Select
        ActiveSheet.Paste
        Sheets(str_TabName).Select
        Application.CutCopyMode = False
        
        'Go back to original sheet
        Sheets("Raw Data").Select
    End Sub
    
    Option Explicit
    
    Sub DefBusRules()
    '
    ' DefBusRules Macro
    '
    
    '
    'test to see if tab already exists
        Dim wsTest As Worksheet
        
        Set wsTest = Nothing
            On Error Resume Next
        Set wsTest = ActiveWorkbook.Worksheets("Def & Bus Rules & Overview")
        On Error GoTo 0
         
        'if tab does not exist, create one and insert header
        If wsTest Is Nothing Then
            Worksheets.Add.Name = "Def & Bus Rules & Overview"
            Worksheets("Def & Bus Rules & Overview").Activate
        End If
        
        Sheets("Def & Bus Rules & Overview").Select
        Sheets("Def & Bus Rules & Overview").Name = "Def & Bus Rules & Overview"
        ActiveCell.FormulaR1C1 = "POC"
        Range("C1").Select
        ActiveCell.FormulaR1C1 = "9/20/2017"
        Range("D1").Select
        ActiveCell.FormulaR1C1 = "Email: "
        Range("B3").Select
        ActiveCell.FormulaR1C1 = "Definitions and Business Rules"
        Columns("B:B").Select
        Selection.ColumnWidth = 27.43
        Range("B5").Select
        ActiveCell.FormulaR1C1 = "Data Source"
        Range("B6").Select
        ActiveCell.FormulaR1C1 = "Data Pull Date"
        Range("B8").Select
        ActiveCell.FormulaR1C1 = "Data Source"
        Range("B9").Select
        ActiveCell.FormulaR1C1 = "Data Pull Date"
        Range("B12").Select
        ActiveCell.FormulaR1C1 = "Generic Rules Applied"
        Range("B13").Select
        ActiveCell.FormulaR1C1 = "Outliers"
        Range("B14").Select
        ActiveCell.FormulaR1C1 = "#NA"
        Range("B15").Select
        ActiveCell.FormulaR1C1 = "Blanks"
        Range("B16").Select
        ActiveCell.FormulaR1C1 = "Zeros"
        Range("B18").Select
        ActiveCell.FormulaR1C1 = "Raw Data Key"
        Range("B23").Select
        ActiveCell.FormulaR1C1 = "Findings and Further Analysis"
        Range("C3").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C5").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C6").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C8").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C9").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C12").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C13").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C14").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C15").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C16").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C19").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C20").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C21").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C24").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C25").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("C26").Select
        ActiveCell.FormulaR1C1 = "'---"
        Range("B3,B12,B18,B23").Select
        Range("B23").Activate
        Selection.Font.Size = 12
        Selection.Font.Size = 14
        Selection.Font.Size = 16
        Selection.Font.Size = 14
        Selection.Font.Bold = True
        Range("B5:B9,B13:B16,B19:B22,B24:B26").Select
        Range("B24").Activate
        With Selection
            .HorizontalAlignment = xlRight
            .VerticalAlignment = xlBottom
            .WrapText = False
            .Orientation = 0
            .AddIndent = False
            .IndentLevel = 0
            .ShrinkToFit = False
            .ReadingOrder = xlContext
            .MergeCells = False
        End With
        With Selection.Interior
            .Pattern = xlSolid
            .PatternColorIndex = xlAutomatic
            .Color = 15773696
            .TintAndShade = 0
            .PatternTintAndShade = 0
        End With
        With Selection.Font
            .ThemeColor = xlThemeColorDark1
            .TintAndShade = 0
        End With
        Range("C3:C26").Select
        With Selection
            .HorizontalAlignment = xlCenter
            .VerticalAlignment = xlBottom
            .WrapText = False
            .Orientation = 0
            .AddIndent = False
            .IndentLevel = 0
            .ShrinkToFit = False
            .ReadingOrder = xlContext
            .MergeCells = False
        End With
        ActiveWindow.SmallScroll Down:=-12
        Range("M1").Select
        ActiveCell.FormulaR1C1 = "Tab Index"
        Range("M1").Select
        With Selection.Interior
            .Pattern = xlSolid
            .PatternColorIndex = xlAutomatic
            .Color = 15773696
            .TintAndShade = 0
            .PatternTintAndShade = 0
        End With
        With Selection
            .HorizontalAlignment = xlRight
            .VerticalAlignment = xlBottom
            .WrapText = False
            .Orientation = 0
            .AddIndent = False
            .IndentLevel = 0
            .ShrinkToFit = False
            .ReadingOrder = xlContext
            .MergeCells = False
        End With
        Selection.Font.Bold = True
        Columns("M:M").ColumnWidth = 12.43
        Range("M5").Select
        
        Columns("C:C").EntireColumn.AutoFit
        Columns("D:D").ColumnWidth = 72.14
        
        
        
        Call Add_Borders
    End Sub
    
    
    
    
    Sub Add_Borders()
    '
    ' Macro3 Macro
    '
    
    '
        Range("B5").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B6").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B7").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B8").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B9").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B13").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B14").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B15").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B19").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B20").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B21:B22").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B21:B22").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B21").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B24").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
        Range("B25").Select
        Selection.Borders(xlDiagonalDown).LineStyle = xlNone
        Selection.Borders(xlDiagonalUp).LineStyle = xlNone
        With Selection.Borders(xlEdgeLeft)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeTop)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeBottom)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        With Selection.Borders(xlEdgeRight)
            .LineStyle = xlContinuous
            .ThemeColor = 1
            .TintAndShade = 0
            .Weight = xlThin
        End With
        Selection.Borders(xlInsideVertical).LineStyle = xlNone
        Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
    End Sub
    
    Sub IndexIt()
        Dim Ws As Worksheet, WsInd As Worksheet, lStartRow%, lStartCol, sBackRange As String
         '##1: Where should the back-to-index-page link be, change if necessary
        sBackRange = "A1"
         
        lStartRow = 2
        lStartCol = 13
         
        Set WsInd = Worksheets("Def & Bus Rules & Overview")
    
         
         'Add the links
        For Each Ws In Worksheets
            If Ws.Name <> WsInd.Name Then
                WsInd.Hyperlinks.Add WsInd.Cells(lStartRow, lStartCol), "", "'" & Ws.Name & "'!A1"
                WsInd.Cells(lStartRow, lStartCol).Value = Ws.Name
                lStartRow = lStartRow + 1
                 
                 '##2: Add link back to index, comment the following 2 lines if you don't want this part
                Ws.Hyperlinks.Add Ws.Range(sBackRange), "", "'" & WsInd.Name & "'" & "!A1"
                Ws.Range(sBackRange).Value = "Back to Index"
            End If
        Next Ws
         
        WsInd.Activate
    End Sub
    
    </code>






