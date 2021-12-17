Operation =1
Option =0
Begin InputTables
    Name ="comm_free_goods_redeem-PROD"
End
Begin OutputColumns
    Expression ="[comm_free_goods_redeem-PROD].CalMonth"
    Expression ="[comm_free_goods_redeem-PROD].SalesOrderNumber"
    Expression ="[comm_free_goods_redeem-PROD].ID"
    Expression ="[comm_free_goods_redeem-PROD].ShipTo"
    Expression ="[comm_free_goods_redeem-PROD].PracticeName"
    Expression ="[comm_free_goods_redeem-PROD].Item"
    Expression ="[comm_free_goods_redeem-PROD].ItemDescription"
    Expression ="[comm_free_goods_redeem-PROD].Supplier"
    Expression ="[comm_free_goods_redeem-PROD].ExtFileCostCadAmt"
    Expression ="[comm_free_goods_redeem-PROD].SourceCode"
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
        dbText "Name" ="[comm_free_goods_redeem-PROD].CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].ItemDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].SourceCode"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1391
    Bottom =937
    Left =-1
    Top =-1
    Right =1367
    Bottom =353
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =24
        Top =4
        Right =413
        Bottom =351
        Top =0
        Name ="comm_free_goods_redeem-PROD"
        Name =""
    End
End
