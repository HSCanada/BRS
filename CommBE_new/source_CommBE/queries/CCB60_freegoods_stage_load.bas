﻿Operation =1
Option =0
Begin InputTables
    Name ="Integration_comm_freegoods_Staging"
End
Begin OutputColumns
    Expression ="Integration_comm_freegoods_Staging.FiscalMonth"
    Expression ="Integration_comm_freegoods_Staging.SalesOrderNumber"
    Expression ="Integration_comm_freegoods_Staging.original_line_number"
    Expression ="Integration_comm_freegoods_Staging.ShipTo"
    Expression ="Integration_comm_freegoods_Staging.PracticeName"
    Expression ="Integration_comm_freegoods_Staging.Item"
    Expression ="Integration_comm_freegoods_Staging.ItemDescription"
    Expression ="Integration_comm_freegoods_Staging.Supplier"
    Expression ="Integration_comm_freegoods_Staging.ExtFileCostCadAmt"
    Expression ="Integration_comm_freegoods_Staging.SourceCode"
    Expression ="Integration_comm_freegoods_Staging.ID"
    Expression ="Integration_comm_freegoods_Staging.DocType"
    Expression ="Integration_comm_freegoods_Staging.status_code"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.ItemDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.status_code"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =987
    Bottom =555
    Left =-1
    Top =-1
    Right =963
    Bottom =264
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =167
        Top =17
        Right =449
        Bottom =219
        Top =0
        Name ="Integration_comm_freegoods_Staging"
        Name =""
    End
End