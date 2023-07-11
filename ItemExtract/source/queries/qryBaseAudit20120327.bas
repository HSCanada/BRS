Operation =1
Option =0
Begin InputTables
    Name ="STAGE_F56013R_U"
    Name ="ItemPrice20120327-Post-Trans"
End
Begin OutputColumns
    Expression ="STAGE_F56013R_U.[Ref #]"
    Expression ="STAGE_F56013R_U.[Item #]"
    Expression ="STAGE_F56013R_U.[Qty Break]"
    Expression ="STAGE_F56013R_U.[New Price]"
    Expression ="[ItemPrice20120327-Post-Trans].[JDE Sell Prc Brk]"
    Expression ="STAGE_F56013R_U.[Item Leader]"
    Expression ="STAGE_F56013R_U.[Curr Price]"
    Expression ="STAGE_F56013R_U.[Curr Price Eff Date]"
    Expression ="STAGE_F56013R_U.[Curr Price Exp Date]"
    Expression ="STAGE_F56013R_U.[Curr File Cost]"
    Expression ="STAGE_F56013R_U.[New GP%]"
    Expression ="STAGE_F56013R_U.[Cost Currency]"
    Expression ="STAGE_F56013R_U.Status"
    Expression ="STAGE_F56013R_U.[Err Code]"
    Expression ="STAGE_F56013R_U.[Message Desc]"
    Expression ="STAGE_F56013R_U.id"
End
Begin Joins
    LeftTable ="STAGE_F56013R_U"
    RightTable ="ItemPrice20120327-Post-Trans"
    Expression ="STAGE_F56013R_U.[Item #] = [ItemPrice20120327-Post-Trans].[HSI Item#]"
    Flag =2
    LeftTable ="STAGE_F56013R_U"
    RightTable ="ItemPrice20120327-Post-Trans"
    Expression ="STAGE_F56013R_U.[Qty Break] = [ItemPrice20120327-Post-Trans].[JDE Sell Qty Brk]"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="STAGE_F56013R_U.id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[ItemPrice20120327-Post-Trans].[JDE Sell Prc Brk]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.[Ref #]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.[Item #]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.[Qty Break]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.[New Price]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.[Item Leader]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.[Curr Price]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.[Curr Price Eff Date]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.[Curr Price Exp Date]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.[Curr File Cost]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.[New GP%]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.[Cost Currency]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.Status"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.[Err Code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_F56013R_U.[Message Desc]"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1464
    Bottom =1013
    Left =-1
    Top =-1
    Right =1419
    Bottom =699
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="STAGE_F56013R_U"
        Name =""
    End
    Begin
        Left =240
        Top =12
        Right =384
        Bottom =156
        Top =0
        Name ="ItemPrice20120327-Post-Trans"
        Name =""
    End
End
