Operation =1
Option =0
Where ="(((BRS_TransactionDW_Ext.SalesOrderNumber) Is Null)) OR (((BRS_Customer.ShipTo) "
    "Is Null)) OR (((BRS_Item.Item) Is Null)) OR (((BRS_ItemSupplier.Supplier) Is Nul"
    "l))"
Begin InputTables
    Name ="Integration_comm_freegoods_Staging"
    Name ="BRS_TransactionDW_Ext"
    Name ="BRS_Customer"
    Name ="BRS_Item"
    Name ="BRS_ItemSupplier"
End
Begin OutputColumns
    Expression ="Integration_comm_freegoods_Staging.FiscalMonth"
    Expression ="Integration_comm_freegoods_Staging.SalesOrderNumber"
    Expression ="Integration_comm_freegoods_Staging.ShipTo"
    Expression ="Integration_comm_freegoods_Staging.Item"
    Expression ="Integration_comm_freegoods_Staging.ItemDescription"
    Expression ="Integration_comm_freegoods_Staging.Supplier"
    Expression ="Integration_comm_freegoods_Staging.SourceCode"
    Expression ="Integration_comm_freegoods_Staging.ID"
    Expression ="BRS_TransactionDW_Ext.SalesOrderNumber"
    Expression ="BRS_Customer.ShipTo"
    Expression ="BRS_Item.Item"
    Expression ="BRS_ItemSupplier.Supplier"
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
    RightTable ="BRS_Customer"
    Expression ="Integration_comm_freegoods_Staging.ShipTo = BRS_Customer.ShipTo"
    Flag =2
    LeftTable ="Integration_comm_freegoods_Staging"
    RightTable ="BRS_Item"
    Expression ="Integration_comm_freegoods_Staging.Item = BRS_Item.Item"
    Flag =2
    LeftTable ="Integration_comm_freegoods_Staging"
    RightTable ="BRS_ItemSupplier"
    Expression ="Integration_comm_freegoods_Staging.Supplier = BRS_ItemSupplier.Supplier"
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
    End
    Begin
        dbText "Name" ="BRS_Customer.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemSupplier.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.DocType"
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
        dbText "Name" ="Integration_comm_freegoods_Staging.PracticeName"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1167
    Bottom =787
    Left =-1
    Top =-1
    Right =1143
    Bottom =233
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =167
        Top =17
        Right =311
        Bottom =222
        Top =0
        Name ="Integration_comm_freegoods_Staging"
        Name =""
    End
    Begin
        Left =413
        Top =41
        Right =557
        Bottom =185
        Top =0
        Name ="BRS_TransactionDW_Ext"
        Name =""
    End
    Begin
        Left =626
        Top =35
        Right =770
        Bottom =179
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =846
        Top =38
        Right =990
        Bottom =182
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =789
        Top =168
        Right =933
        Bottom =312
        Top =0
        Name ="BRS_ItemSupplier"
        Name =""
    End
End
