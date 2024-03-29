﻿Operation =1
Option =0
Begin InputTables
    Name ="fg_redeem_working"
End
Begin OutputColumns
    Expression ="fg_redeem_working.SalesOrderNumber"
    Expression ="fg_redeem_working.DocType"
    Alias ="MinOfID_source_ref"
    Expression ="Min(fg_redeem_working.ID_source_ref)"
    Alias ="buy_cnt"
    Expression ="Sum(IIf([src]=\"BUY\",1,0))"
    Alias ="get_cnt"
    Expression ="Sum(IIf([src]=\"GET\",1,0))"
    Alias ="redeem_cnt"
    Expression ="Sum(fg_redeem_working.fg_redeem_ind)"
End
Begin Groups
    Expression ="fg_redeem_working.SalesOrderNumber"
    GroupLevel =0
    Expression ="fg_redeem_working.DocType"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="fg_redeem_working.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="buy_cnt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="get_cnt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="redeem_cnt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="fg_redeem_working.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MinOfID_source_ref"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1564
    Bottom =918
    Left =-1
    Top =-1
    Right =1548
    Bottom =605
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =108
        Top =86
        Right =445
        Bottom =460
        Top =0
        Name ="fg_redeem_working"
        Name =""
    End
End
