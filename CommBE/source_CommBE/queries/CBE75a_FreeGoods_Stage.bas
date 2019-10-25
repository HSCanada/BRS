Operation =1
Option =0
Begin InputTables
    Name ="itegration_comm_free_goods_redeem"
End
Begin OutputColumns
    Expression ="itegration_comm_free_goods_redeem.CalMonth"
    Expression ="itegration_comm_free_goods_redeem.Supplier"
    Expression ="itegration_comm_free_goods_redeem.ShipTo"
    Expression ="itegration_comm_free_goods_redeem.PracticeName"
    Expression ="itegration_comm_free_goods_redeem.SalesOrderNumber"
    Expression ="itegration_comm_free_goods_redeem.Item"
    Expression ="itegration_comm_free_goods_redeem.ItemDescription"
    Expression ="itegration_comm_free_goods_redeem.ExtFileCostCadAmt"
    Expression ="itegration_comm_free_goods_redeem.SourceCode"
    Expression ="itegration_comm_free_goods_redeem.ID"
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
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =779
    Bottom =794
    Left =-1
    Top =-1
    Right =755
    Bottom =271
    Left =0
    Top =192
    ColumnsShown =539
    Begin
        Left =128
        Top =-48
        Right =410
        Bottom =211
        Top =0
        Name ="itegration_comm_free_goods_redeem"
        Name =""
    End
End
