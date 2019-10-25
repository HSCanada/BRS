Operation =1
Option =0
Where ="(((comm_customer_master.hsi_shipto_id) Is Null)) OR (((BRS_TransactionDW_Ext.Sal"
    "esOrderNumber) Is Null)) OR (((comm_item_master.item_id) Is Null)) OR (((BRS_Ite"
    "mSupplier.Supplier) Is Null))"
Begin InputTables
    Name ="itegration_comm_free_goods_redeem"
    Name ="comm_customer_master"
    Name ="comm_item_master"
    Name ="BRS_TransactionDW_Ext"
    Name ="BRS_ItemSupplier"
End
Begin OutputColumns
    Expression ="itegration_comm_free_goods_redeem.CalMonth"
    Expression ="itegration_comm_free_goods_redeem.Supplier"
    Expression ="BRS_ItemSupplier.Supplier"
    Expression ="itegration_comm_free_goods_redeem.ShipTo"
    Expression ="comm_customer_master.hsi_shipto_id"
    Expression ="itegration_comm_free_goods_redeem.PracticeName"
    Expression ="itegration_comm_free_goods_redeem.SalesOrderNumber"
    Expression ="BRS_TransactionDW_Ext.SalesOrderNumber"
    Expression ="itegration_comm_free_goods_redeem.Item"
    Expression ="comm_item_master.item_id"
    Expression ="itegration_comm_free_goods_redeem.ItemDescription"
    Expression ="itegration_comm_free_goods_redeem.ExtFileCostCadAmt"
    Expression ="itegration_comm_free_goods_redeem.SourceCode"
    Expression ="itegration_comm_free_goods_redeem.ID"
End
Begin Joins
    LeftTable ="itegration_comm_free_goods_redeem"
    RightTable ="comm_customer_master"
    Expression ="itegration_comm_free_goods_redeem.ShipTo = comm_customer_master.hsi_shipto_id"
    Flag =2
    LeftTable ="itegration_comm_free_goods_redeem"
    RightTable ="comm_item_master"
    Expression ="itegration_comm_free_goods_redeem.Item = comm_item_master.item_id"
    Flag =2
    LeftTable ="itegration_comm_free_goods_redeem"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="itegration_comm_free_goods_redeem.SalesOrderNumber = BRS_TransactionDW_Ext.Sales"
        "OrderNumber"
    Flag =2
    LeftTable ="itegration_comm_free_goods_redeem"
    RightTable ="BRS_ItemSupplier"
    Expression ="itegration_comm_free_goods_redeem.Supplier = BRS_ItemSupplier.Supplier"
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
        dbText "Name" ="itegration_comm_free_goods_redeem.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.ItemDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemSupplier.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1471
    Bottom =825
    Left =-1
    Top =-1
    Right =1447
    Bottom =533
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =71
        Top =60
        Right =353
        Bottom =319
        Top =0
        Name ="itegration_comm_free_goods_redeem"
        Name =""
    End
    Begin
        Left =490
        Top =39
        Right =634
        Bottom =183
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =516
        Top =223
        Right =660
        Bottom =367
        Top =0
        Name ="comm_item_master"
        Name =""
    End
    Begin
        Left =736
        Top =119
        Right =880
        Bottom =263
        Top =0
        Name ="BRS_TransactionDW_Ext"
        Name =""
    End
    Begin
        Left =713
        Top =40
        Right =857
        Bottom =184
        Top =0
        Name ="BRS_ItemSupplier"
        Name =""
    End
End
