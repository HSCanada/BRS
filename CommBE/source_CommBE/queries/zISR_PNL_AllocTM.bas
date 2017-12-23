Operation =1
Option =0
Where ="(((FSC_Split_ISR.order_source_cd) Not In (\"A\",\"L\")))"
Begin InputTables
    Name ="FSC_Split_ISR"
End
Begin OutputColumns
    Expression ="FSC_Split_ISR.fiscal_yearmo_num"
    Expression ="FSC_Split_ISR.branch_cd"
    Alias ="Sales$"
    Expression ="Sum(FSC_Split_ISR.transaction_amt)"
    Alias ="CommGP$"
    Expression ="Sum(FSC_Split_ISR.gp_ext_amt)"
    Alias ="CommGP_FreeGoods$"
    Expression ="Sum(FSC_Split_ISR.gp_free_goods_amt)"
End
Begin Groups
    Expression ="FSC_Split_ISR.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="FSC_Split_ISR.branch_cd"
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
Begin
    Begin
        dbText "Name" ="FSC_Split_ISR.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2235"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Sales$"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1350"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="CommGP$"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1380"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="CommGP_FreeGoods$"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2490"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="FSC_Split_ISR.branch_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1365"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1627
    Bottom =1005
    Left =-1
    Top =-1
    Right =1603
    Bottom =629
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =439
        Bottom =511
        Top =0
        Name ="FSC_Split_ISR"
        Name =""
    End
End
