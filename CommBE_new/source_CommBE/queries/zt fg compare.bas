Operation =1
Option =0
Where ="(((comm_freegoods.FiscalMonth)=202010) AND ((comm_freegoods.SourceCode)=\"ACT\")"
    " AND ((comm_freegoods.ess_code)=[salesperson_ess_cd]))"
Begin InputTables
    Name ="comm_freegoods"
    Name ="comm_free_goods_redeem-PROD"
End
Begin OutputColumns
    Expression ="comm_freegoods.FiscalMonth"
    Expression ="comm_freegoods.SourceCode"
    Expression ="comm_freegoods.fsc_code"
    Expression ="[comm_free_goods_redeem-PROD].salesperson_cd"
    Expression ="comm_freegoods.ess_code"
    Expression ="[comm_free_goods_redeem-PROD].salesperson_ess_cd"
End
Begin Joins
    LeftTable ="comm_freegoods"
    RightTable ="comm_free_goods_redeem-PROD"
    Expression ="comm_freegoods.FiscalMonth = [comm_free_goods_redeem-PROD].CalMonth"
    Flag =1
    LeftTable ="comm_freegoods"
    RightTable ="comm_free_goods_redeem-PROD"
    Expression ="comm_freegoods.original_line_number = [comm_free_goods_redeem-PROD].ID"
    Flag =1
    LeftTable ="comm_freegoods"
    RightTable ="comm_free_goods_redeem-PROD"
    Expression ="comm_freegoods.SalesOrderNumber = [comm_free_goods_redeem-PROD].SalesOrderNumber"
    Flag =1
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
        dbText "Name" ="[comm_free_goods_redeem-PROD].salesperson_ess_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_freegoods.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1291
    Bottom =547
    Left =-1
    Top =-1
    Right =1267
    Bottom =271
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =45
        Top =29
        Right =399
        Bottom =261
        Top =0
        Name ="comm_freegoods"
        Name =""
    End
    Begin
        Left =501
        Top =56
        Right =791
        Bottom =266
        Top =0
        Name ="comm_free_goods_redeem-PROD"
        Name =""
    End
End
