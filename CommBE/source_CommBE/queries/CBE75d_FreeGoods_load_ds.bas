Operation =3
Name ="comm_free_goods_redeem_DS"
Option =0
Begin InputTables
    Name ="itegration_comm_free_goods_redeem"
End
Begin OutputColumns
    Name ="FiscalMonth"
    Expression ="itegration_comm_free_goods_redeem.CalMonth"
    Alias ="FirstOfSupplier"
    Name ="Supplier"
    Expression ="First(itegration_comm_free_goods_redeem.Supplier)"
    Alias ="FirstOfShipTo"
    Name ="ShipTo"
    Expression ="First(itegration_comm_free_goods_redeem.ShipTo)"
    Name ="SalesOrderNumber"
    Expression ="itegration_comm_free_goods_redeem.SalesOrderNumber"
    Name ="Item"
    Expression ="itegration_comm_free_goods_redeem.Item"
    Alias ="SumOfExtFileCostCadAmt"
    Name ="ExtFileCostCadAmt"
    Expression ="Sum(itegration_comm_free_goods_redeem.ExtFileCostCadAmt)"
    Alias ="FirstOfSourceCode"
    Name ="SourceCode"
    Expression ="First(itegration_comm_free_goods_redeem.SourceCode)"
    Alias ="Expr1"
    Name ="DocType"
    Expression ="\"AA\""
End
Begin Groups
    Expression ="itegration_comm_free_goods_redeem.CalMonth"
    GroupLevel =0
    Expression ="itegration_comm_free_goods_redeem.SalesOrderNumber"
    GroupLevel =0
    Expression ="itegration_comm_free_goods_redeem.Item"
    GroupLevel =0
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
dbBoolean "UseTransaction" ="-1"
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
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfSourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfItemDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfPracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfSupplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfShipTo"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1445
    Bottom =817
    Left =-1
    Top =-1
    Right =1421
    Bottom =431
    Left =0
    Top =0
    ColumnsShown =655
    Begin
        Left =71
        Top =60
        Right =353
        Bottom =319
        Top =0
        Name ="itegration_comm_free_goods_redeem"
        Name =""
    End
End
