﻿Operation =1
Option =0
Where ="(((BRS_TransactionDW_Ext.SalesOrderNumber) Is Null))"
Begin InputTables
    Name ="Integration_comm_adjustment_Staging"
    Name ="BRS_TransactionDW_Ext"
End
Begin OutputColumns
    Expression ="Integration_comm_adjustment_Staging.FiscalMonth"
    Expression ="Integration_comm_adjustment_Staging.WSOGNO_original_line_number"
    Expression ="Integration_comm_adjustment_Staging.WSDCTO_order_type"
    Expression ="Integration_comm_adjustment_Staging.WSDOC__document_number"
    Expression ="Integration_comm_adjustment_Staging.WSDOCO_salesorder_number"
    Expression ="BRS_TransactionDW_Ext.SalesOrderNumber"
End
Begin Joins
    LeftTable ="Integration_comm_adjustment_Staging"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="Integration_comm_adjustment_Staging.WSDOC__document_number = BRS_TransactionDW_E"
        "xt.SalesOrderNumber"
    Flag =2
    LeftTable ="Integration_comm_adjustment_Staging"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="Integration_comm_adjustment_Staging.WSDCTO_order_type = BRS_TransactionDW_Ext.Do"
        "cType"
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
        dbText "Name" ="Integration_comm_adjustment_Staging.WSOGNO_original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSDCTO_order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSDOC__document_number"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3120"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSDOCO_salesorder_number"
        dbInteger "ColumnWidth" ="3195"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1407
    Bottom =937
    Left =-1
    Top =-1
    Right =1383
    Bottom =447
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =177
        Top =54
        Right =500
        Bottom =393
        Top =0
        Name ="Integration_comm_adjustment_Staging"
        Name =""
    End
    Begin
        Left =664
        Top =92
        Right =808
        Bottom =236
        Top =0
        Name ="BRS_TransactionDW_Ext"
        Name =""
    End
End
