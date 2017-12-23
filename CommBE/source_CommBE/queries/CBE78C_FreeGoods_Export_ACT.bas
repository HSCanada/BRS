Operation =1
Option =0
Where ="(((comm_customer_free_goods_YTD.Source)=\"ACT\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_customer_free_goods_YTD"
End
Begin OutputColumns
    Expression ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
    Alias ="comm_grp"
    Expression ="comm_customer_free_goods_YTD.SM_comm_group_cd"
    Expression ="comm_customer_free_goods_YTD.salesperson_cd"
    Alias ="vend"
    Expression ="\"FREEGD\""
    Alias ="chqno"
    Expression ="\"NA\""
    Alias ="line_no"
    Expression ="0"
    Alias ="trans_dt"
    Expression ="Now()"
    Alias ="details"
    Expression ="\"FREE GOODS-ACT\""
    Alias ="trans_amt"
    Expression ="0"
    Alias ="GP"
    Expression ="Sum(comm_customer_free_goods_YTD.free_goods_CDN_ext_cost)"
    Alias ="comm_amt"
    Expression ="0"
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_customer_free_goods_YTD"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_customer_free_goods_YTD.fiscal_y"
        "earmo_num"
    Flag =1
End
Begin OrderBy
    Expression ="comm_customer_free_goods_YTD.salesperson_cd"
    Flag =0
End
Begin Groups
    Expression ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_customer_free_goods_YTD.SM_comm_group_cd"
    GroupLevel =0
    Expression ="comm_customer_free_goods_YTD.salesperson_cd"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_grp"
        dbInteger "ColumnWidth" ="2085"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="vend"
        dbInteger "ColumnWidth" ="2085"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="chqno"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="line_no"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="trans_dt"
        dbInteger "ColumnWidth" ="2280"
        dbBoolean "ColumnHidden" ="0"
        dbText "Format" ="Medium Date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="details"
        dbInteger "ColumnWidth" ="1680"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="trans_amt"
        dbInteger "ColumnWidth" ="2085"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GP"
        dbInteger "ColumnWidth" ="3765"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_amt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1531
    Bottom =991
    Left =-1
    Top =-1
    Right =1499
    Bottom =484
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =528
        Top =12
        Right =672
        Bottom =156
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =48
        Top =12
        Right =480
        Bottom =329
        Top =0
        Name ="comm_customer_free_goods_YTD"
        Name =""
    End
End
