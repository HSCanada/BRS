Operation =1
Option =0
Where ="(((comm_customer_free_goods_YTD.salesperson_cd) Is Null)) OR (((comm_customer_fr"
    "ee_goods_YTD.comm_group_cd) Is Null)) OR (((comm_customer_free_goods_YTD.comm_gr"
    "oup_cd)=\"\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_customer_free_goods_YTD"
    Name ="comm_customer_hsi_stage"
End
Begin OutputColumns
    Expression ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
    Expression ="comm_customer_free_goods_YTD.hsi_shipto_id"
    Expression ="comm_customer_free_goods_YTD.hsi_shipto_nm"
    Expression ="comm_customer_free_goods_YTD.IMITEM"
    Expression ="comm_customer_free_goods_YTD.item_descr"
    Expression ="comm_customer_free_goods_YTD.free_goods_CDN_ext_cost"
    Alias ="Fix_salesperson_cd"
    Expression ="comm_customer_free_goods_YTD.salesperson_cd"
    Alias ="FIX_comm_group_cd"
    Expression ="comm_customer_free_goods_YTD.comm_group_cd"
    Expression ="comm_customer_hsi_stage.hsi_territory_cd"
    Expression ="comm_customer_hsi_stage.ship_mailing_nm"
    Expression ="comm_customer_free_goods_YTD.Source"
    Expression ="comm_customer_free_goods_YTD.comm_group_cd"
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_customer_free_goods_YTD"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_customer_free_goods_YTD.fiscal_y"
        "earmo_num"
    Flag =1
    LeftTable ="comm_customer_free_goods_YTD"
    RightTable ="comm_customer_hsi_stage"
    Expression ="comm_customer_free_goods_YTD.hsi_shipto_id = comm_customer_hsi_stage.hsi_shipto_"
        "id"
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
        dbText "Name" ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1695"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.hsi_shipto_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3285"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.IMITEM"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1125"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.item_descr"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3075"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Fix_salesperson_cd"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FIX_comm_group_cd"
        dbInteger "ColumnWidth" ="2520"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.free_goods_CDN_ext_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_hsi_stage.hsi_territory_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1920"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.Source"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_hsi_stage.ship_mailing_nm"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-125
    Top =43
    Right =1502
    Bottom =997
    Left =-1
    Top =-1
    Right =1595
    Bottom =417
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =208
        Top =32
        Right =352
        Bottom =176
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =372
        Top =25
        Right =946
        Bottom =350
        Top =0
        Name ="comm_customer_free_goods_YTD"
        Name =""
    End
    Begin
        Left =1045
        Top =72
        Right =1354
        Bottom =327
        Top =0
        Name ="comm_customer_hsi_stage"
        Name =""
    End
End
