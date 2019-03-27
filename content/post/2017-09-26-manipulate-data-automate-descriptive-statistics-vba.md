---
author: mtgingrass
comments: true
date: 2017-09-26 01:23:20+00:00
layout: post
link: http://devgin.com/manipulate-data-automate-descriptive-statistics-vba/
slug: manipulate-data-automate-descriptive-statistics-vba
title: Manipulate Data and Automate Descriptive Statistics with VBA
wordpress_id: 266
tags:
- automate
- data analsis
- descriptive statistics
- manipulate
- stats
- VBA
---

[embed]https://youtu.be/L2GoeXv_Ro0[/embed]


## Get the code below and automate your work!



Watch video and learn how you can manipulate data into multiple tabs with VBA automaticall. Draft version below. Stay tuned for updates as this progresses. 


    
    <code>Option Explicit
    
    Sub Initialize_Data()
        Application.ScreenUpdating = False
        Call DefBusRules
        Call flat_file_to_tabs
        Call IndexIt
        Call format_raw_Data
        Call desc_stats(10)
        
        Worksheets("Def & Bus Rules & Overview").Select
        Range("A1").Select
        Application.ScreenUpdating = True
        
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
        int_HeaderRow = InputBox("Header Row (0 for none): ")
        int_StartingRow = InputBox("Starting Row of Data: ")
        int_StartingCol = InputBox("Column of Interest (Numerica Value a=1, b=2, ...): ")
        
    
    
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
                str_CurrentMDS = Cells(r1, int_StartingCol)
                Call copy_paste_row(int_HeaderRow, r1, str_CurrentMDS)
            End If
        Next
         Application.ScreenUpdating = True
         CopyPasteHeader (int_HeaderRow)
    End Sub
    
    Sub copy_paste_row(int_HeaderRow As Long, int_RowToCopy As Long, str_TabName As String)
        Application.ScreenUpdating = False
        
        Dim lng_LastRow As Long
        Dim wsTest As Worksheet
        Dim offset As Integer
        
        offset = 10
        
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
            Rows(offset).Select
            Selection.Font.Bold = True
            
        End If
        
        'Raw Data sheet should be active
        'paste row to the sheet
        Worksheets("Raw Data").Select
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
    
    Sub IndexIt()
        Dim Ws As Worksheet, WsInd As Worksheet, lStartRow%, lStartCol, sBackRange As String
         '##1: Where should the back-to-index-page link be, change if necessary
        sBackRange = "A1"
         
        lStartRow = 3
        lStartCol = 1
         
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
    
    Sub CopyPasteHeader(int_HeaderRow As Integer)
    '
    ' CopyPasteHeader Macro
    '
    
    '
        Worksheets("Raw Data").Select
        Cells(int_HeaderRow, 1).Select
        Range(Selection, Selection.End(xlToRight)).Select
        Selection.Copy
        
        Worksheets("Def & Bus Rules & Overview").Activate
        Range("B24").Select
        Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, SkipBlanks:= _
            False, Transpose:=True
    End Sub
    
    
    Sub desc_stats(int_HeaderRow As Integer)
    'this function will traverse all tabs, find the numeric columns and average them at the bottom
        Application.ScreenUpdating = False
        Dim current_ws As Worksheet
        Dim WS_Count As Integer
        Dim I As Integer
        Dim lng_LastRow As Long
        Dim lng_lastCol As Long
            
        'Count number of worksheets
        WS_Count = ActiveWorkbook.Worksheets.Count
        
                            Application.EnableEvents = False
                        Application.DisplayAlerts = False
        '********************************************************************************************************************
        'Loop through each worksheet.
        For I = 1 To WS_Count
            
            'Exclude "Def & Bus Rules & Overview" tab.
            If (ActiveWorkbook.Worksheets(I).Name <> "Def & Bus Rules & Overview" And ActiveWorkbook.Worksheets(I).Name <> "Raw Data") Then
                Worksheets(I).Activate
                
                lng_LastRow = Cells(Rows.Count, 1).End(xlUp).Row
    
                Dim index_row As Long
                Dim index_col As Long
                Dim pos_counter As Long
                
                pos_counter = -1
                'Get number of columns
                Range("B" & int_HeaderRow).Select
                Selection.End(xlToRight).Select
                Selection.End(xlToRight).Select
                Selection.End(xlToLeft).Select
                lng_lastCol = ActiveCell.Column
                
                '*************************************************************************************************************
                'Interate through all the columns and rows
                For index_col = 1 To lng_lastCol
                
                    'If the first row of values has #N/A or is empty, consider it a numeric just in case other values below are
                    If IsNumeric(Cells(int_HeaderRow + 1, index_col)) Or _
                        IsEmpty(Cells(int_HeaderRow + 1, index_col)) Or IsError(Cells(int_HeaderRow + 1, index_col)) Then
                        
        
                        'Get Range
                        Dim current_col_range As String
                        current_col_range = Col_Letter(index_col) & (int_HeaderRow) & ":" & Col_Letter(index_col) & lng_LastRow
                        
                        'third quartile
                        Cells(int_HeaderRow - 5, index_col).Value = "=QUARTILE.INC(" _
                        & Col_Letter(index_col) & (int_HeaderRow + 1) & ":" & Col_Letter(index_col) & lng_LastRow & ",3)"
    
                        'First Quartile
                        Cells(int_HeaderRow - 6, index_col).Value = "=QUARTILE.INC(" _
                        & Col_Letter(index_col) & (int_HeaderRow + 1) & ":" & Col_Letter(index_col) & lng_LastRow & ",1)"
                        'Upper Bound
                        Cells(int_HeaderRow - 7, index_col).Value = "=QUARTILE.INC(" _
                        & Col_Letter(index_col) & (int_HeaderRow + 1) & ":" & Col_Letter(index_col) & lng_LastRow & ",3)*1.5"
                        
                        'Lower Bound
                        Cells(int_HeaderRow - 4, index_col).Value = "=QUARTILE.INC(" _
                        & Col_Letter(index_col) & (int_HeaderRow + 1) & ":" & Col_Letter(index_col) & lng_LastRow & ",1)*.5"
    
                        Dim my_range As String
                        my_range = Col_Letter(index_col) + CStr((int_HeaderRow)) + ":" + Col_Letter(index_col) + CStr((lng_LastRow))
                        
                        
                        pos_counter = pos_counter + 1
                        Application.Run "ATPVBAEN.XLAM!Descr", ActiveSheet.Range(my_range), _
                        ActiveSheet.Range("$B$" & CStr(lng_LastRow + 3 + pos_counter * 20)), "C", True, True, 1, 1, 95
            
                        Call InsertScatterPlot(ActiveWorkbook.Worksheets(I).Name, current_col_range, "F" & (lng_LastRow + 3 + pos_counter * 20))
                        Call CondFormat(current_col_range)
                    End If
                    
                Next
                '*************************************************************************************************************
            End If 'if not defintions tab, cycle through them
            
            If (ActiveWorkbook.Worksheets(I).Name <> "Def & Bus Rules & Overview" And ActiveWorkbook.Worksheets(I).Name <> "Raw Data") Then
                Call beautify_temp
            End If
            pos_counter = 0
            Range("A1").Select
        Next I 'cycling through each worksheet
        '********************************************************************************************************************
        
        Application.EnableEvents = True
        Application.DisplayAlerts = True
                        
        
    End Sub
    
    Function Col_Letter(lngCol As Long) As String
        Dim vArr
        vArr = Split(Cells(1, lngCol).Address(True, False), "$")
        Col_Letter = vArr(0)
    End Function
    
    
    Sub CondFormat(my_range As String)
    '
    ' CondFormat Macro
    '
    
    '
        Range(my_range).Select
        Selection.FormatConditions.Add Type:=xlCellValue, Operator:=xlBetween, _
            Formula1:="=$" & Left(my_range, 1) & "$3", Formula2:="=$" & Left(my_range, 1) & "$6"
        Selection.FormatConditions(Selection.FormatConditions.Count).SetFirstPriority
        With Selection.FormatConditions(1).Font
            .Color = -16752384
            .TintAndShade = 0
        End With
        With Selection.FormatConditions(1).Interior
            .PatternColorIndex = xlAutomatic
            .Color = 13561798
            .TintAndShade = 0
        End With
        Selection.FormatConditions(1).StopIfTrue = False
    
    End Sub
    
    
    
    Sub beautify_temp()
    Application.ScreenUpdating = False
    
        Columns("A:A").Select
        Selection.Insert Shift:=xlToRight
        Range("A3").Select
        ActiveCell.FormulaR1C1 = "Upper Bound"
        Range("A4").Select
        ActiveCell.FormulaR1C1 = "1st Quartile"
        Range("A5").Select
        ActiveCell.FormulaR1C1 = "3rd Quartile"
        Range("A6").Select
        ActiveCell.FormulaR1C1 = "Lower Bound"
    
        Range("A9").Select
        Columns("A:A").EntireColumn.AutoFit
        Range("A3:A6").Select
        Selection.Font.Bold = True
        Range("A3,A6").Select
        Range("A6").Activate
        With Selection.Font
            .Color = -16776961
            .TintAndShade = 0
        End With
        Range("3:3,6:6").Select
        Range("A6").Activate
        With Selection.Font
            .Color = -16776961
            .TintAndShade = 0
        End With
        Range("A8").Select
        Selection.Font.Bold = True
        Range("D6").Select
        Range("A1").Select
        
        Columns.AutoFit
        Application.ScreenUpdating = True
        
    End Sub
    
    
    Sub InsertScatterPlot(Sheet_Name As String, Chart_Range As String, Chart_Position As String)
    '
    ' InsertScatterPlot Macro
    '
    
        With ActiveSheet.ChartObjects.Add _
            (Left:=Range(Chart_Position).Left, Width:=375, Top:=Range(Chart_Position).Top, Height:=225)
            With .Chart
                .ChartType = xlXYScatterLines
                .SetSourceData Source:=Sheets(Sheet_Name).Range(Chart_Range)
                .Parent.Name = "My Chart2"
            End With
        End With
    End Sub
    
    
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
        Range("B1").Select
        ActiveCell.FormulaR1C1 = Application.UserName
        Range("C1").Select
        ActiveCell.FormulaR1C1 = "=Today()"
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
        ActiveCell.FormulaR1C1 = "Findings and Further Analysis"
        Range("B23").Select
        ActiveCell.FormulaR1C1 = "Raw Data Key"
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
        Range("A2").Select
        ActiveCell.FormulaR1C1 = "Tab Index"
        Range("A2").Select
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
    
    End Sub
    
    
    Sub format_raw_Data()
    '
    ' Macro7 Macro
    '
    
    '
        Worksheets("Def & Bus Rules & Overview").Activate
        Range("B24").Select
        Range(Selection, Selection.End(xlDown)).Select
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
        Range("C24:C26").Select
        Selection.AutoFill Destination:=Range("C24:C223")
        Range("C24:C223").Select
        Range("B24").Select
        Selection.End(xlDown).Select
        Selection.End(xlDown).Select
        Selection.End(xlUp).Select
        Range("C47").Select
        Range(Selection, Selection.End(xlDown)).Select
        Selection.ClearContents
        Range("A1").Select
        Columns("B:B").EntireColumn.AutoFit
    End Sub
    
    </code>






    
    
    </p
