Operation =1
Option =0
Where ="(((BRS_TransactionDW_Ext.SalesOrderNumber) Is Null)) OR (((BRS_ItemHistory.Item)"
    " Is Null)) OR (((BRS_CustomerFSC_History.Shipto) Is Null)) OR (((BRS_ItemSupplie"
    "r.Supplier) Is Null)) OR (((Integration_comm_freegoods_Staging.status_code)<>0))"
Begin InputTables
    Name ="Integration_comm_freegoods_Staging"
    Name ="BRS_TransactionDW_Ext"
    Name ="BRS_ItemSupplier"
    Name ="BRS_ItemHistory"
    Name ="BRS_CustomerFSC_History"
End
Begin OutputColumns
    Expression ="Integration_comm_freegoods_Staging.FiscalMonth"
    Expression ="Integration_comm_freegoods_Staging.DocType"
    Expression ="Integration_comm_freegoods_Staging.ItemDescription"
    Expression ="Integration_comm_freegoods_Staging.SourceCode"
    Expression ="Integration_comm_freegoods_Staging.ExtFileCostCadAmt"
    Expression ="Integration_comm_freegoods_Staging.ID"
    Expression ="Integration_comm_freegoods_Staging.SalesOrderNumber"
    Expression ="BRS_TransactionDW_Ext.SalesOrderNumber"
    Expression ="Integration_comm_freegoods_Staging.Item"
    Expression ="BRS_ItemHistory.Item"
    Expression ="Integration_comm_freegoods_Staging.ShipTo"
    Expression ="BRS_CustomerFSC_History.Shipto"
    Expression ="Integration_comm_freegoods_Staging.Supplier"
    Expression ="BRS_ItemSupplier.Supplier"
    Expression ="Integration_comm_freegoods_Staging.status_code"
End
Begin Joins
    LeftTable ="Integration_comm_freegoods_Staging"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="Integration_comm_freegoods_Staging.SalesOrderNumber = BRS_TransactionDW_Ext.Sale"
        "sOrderNumber"
    Flag =2
    LeftTable ="Integration_comm_freegoods_Staging"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="Integration_comm_freegoods_Staging.DocType = BRS_TransactionDW_Ext.DocType"
    Flag =2
    LeftTable ="Integration_comm_freegoods_Staging"
    RightTable ="BRS_ItemSupplier"
    Expression ="Integration_comm_freegoods_Staging.Supplier = BRS_ItemSupplier.Supplier"
    Flag =2
    LeftTable ="Integration_comm_freegoods_Staging"
    RightTable ="BRS_ItemHistory"
    Expression ="Integration_comm_freegoods_Staging.FiscalMonth = BRS_ItemHistory.FiscalMonth"
    Flag =2
    LeftTable ="Integration_comm_freegoods_Staging"
    RightTable ="BRS_ItemHistory"
    Expression ="Integration_comm_freegoods_Staging.Item = BRS_ItemHistory.Item"
    Flag =2
    LeftTable ="Integration_comm_freegoods_Staging"
    RightTable ="BRS_CustomerFSC_History"
    Expression ="Integration_comm_freegoods_Staging.FiscalMonth = BRS_CustomerFSC_History.FiscalM"
        "onth"
    Flag =2
    LeftTable ="Integration_comm_freegoods_Staging"
    RightTable ="BRS_CustomerFSC_History"
    Expression ="Integration_comm_freegoods_Staging.ShipTo = BRS_CustomerFSC_History.Shipto"
    Flag =2
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
        dbInteger "ColumnWidth" ="5805"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.Item"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4455"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.ShipTo"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4650"
        dbBoolean "ColumnHidden" ="0"
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
        dbText "Name" ="BRS_TransactionDW_Ext.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4500"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_ItemSupplier.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemHistory.Item"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2460"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.Shipto"
        dbInteger "ColumnWidth" ="3525"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1541
    Bottom =946
    Left =-1
    Top =-1
    Right =1247
    Bottom =286
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =167
        Top =17
        Right =471
        Bottom =332
        Top =0
        Name ="Integration_comm_freegoods_Staging"
        Name =""
    End
    Begin
        Left =648
        Top =157
        Right =792
        Bottom =301
        Top =0
        Name ="BRS_TransactionDW_Ext"
        Name =""
    End
    Begin
        Left =868
        Top =186
        Right =1012
        Bottom =330
        Top =0
        Name ="BRS_ItemSupplier"
        Name =""
    End
    Begin
        Left =702
        Top =1
        Right =846
        Bottom =145
        Top =0
        Name ="BRS_ItemHistory"
        Name =""
    End
    Begin
        Left =922
        Top =46
        Right =1066
        Bottom =190
        Top =0
        Name ="BRS_CustomerFSC_History"
        Name =""
    End
End
