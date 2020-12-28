Operation =1
Option =0
Where ="((([comm_free_goods_redeem-PROD].CalMonth)=202010) AND (([comm_free_goods_redeem"
    "-PROD].SourceCode)=\"ACT\"))"
Begin InputTables
    Name ="comm_free_goods_redeem-PROD"
    Name ="Integration_comm_freegoods_Staging"
End
Begin OutputColumns
    Expression ="[comm_free_goods_redeem-PROD].CalMonth"
    Expression ="[comm_free_goods_redeem-PROD].SourceCode"
    Expression ="[comm_free_goods_redeem-PROD].ID"
    Expression ="[comm_free_goods_redeem-PROD].salesperson_cd"
    Expression ="[comm_free_goods_redeem-PROD].salesperson_ess_cd"
    Expression ="[comm_free_goods_redeem-PROD].comm_group_cd"
End
Begin Joins
    LeftTable ="comm_free_goods_redeem-PROD"
    RightTable ="Integration_comm_freegoods_Staging"
    Expression ="[comm_free_goods_redeem-PROD].CalMonth = Integration_comm_freegoods_Staging.Fisc"
        "alMonth"
    Flag =1
    LeftTable ="comm_free_goods_redeem-PROD"
    RightTable ="Integration_comm_freegoods_Staging"
    Expression ="[comm_free_goods_redeem-PROD].ID = Integration_comm_freegoods_Staging.original_l"
        "ine_number"
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
        dbText "Name" ="[comm_free_goods_redeem-PROD].salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].salesperson_ess_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2250"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_free_goods_redeem-PROD].CalMonth"
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
    Bottom =600
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =93
        Top =50
        Right =429
        Bottom =402
        Top =0
        Name ="comm_free_goods_redeem-PROD"
        Name =""
    End
    Begin
        Left =522
        Top =69
        Right =884
        Bottom =362
        Top =0
        Name ="Integration_comm_freegoods_Staging"
        Name =""
    End
End
