Operation =1
Option =0
Where ="(((comm_free_goods_redeem.CalMonth)=201909) AND ((comm_free_goods_redeem.salespe"
    "rson_cd) Is Null)) OR (((comm_free_goods_redeem.CalMonth)=201909) AND ((comm_fre"
    "e_goods_redeem.comm_group_cd) Is Null)) OR (((comm_free_goods_redeem.comm_group_"
    "cd)=\"\"))"
Begin InputTables
    Name ="comm_customer_hsi_stage"
    Name ="comm_free_goods_redeem"
End
Begin OutputColumns
    Expression ="comm_free_goods_redeem.CalMonth"
    Expression ="comm_free_goods_redeem.ShipTo"
    Expression ="comm_free_goods_redeem.PracticeName"
    Expression ="comm_free_goods_redeem.Item"
    Expression ="comm_free_goods_redeem.ItemDescription"
    Expression ="comm_free_goods_redeem.ExtFileCostCadAmt"
    Alias ="Fix_salesperson_cd"
    Expression ="comm_free_goods_redeem.salesperson_cd"
    Alias ="FIX_comm_group_cd"
    Expression ="comm_free_goods_redeem.comm_group_cd"
    Expression ="comm_customer_hsi_stage.hsi_territory_cd"
    Expression ="comm_customer_hsi_stage.ship_mailing_nm"
    Expression ="comm_free_goods_redeem.SourceCode"
    Expression ="comm_free_goods_redeem.comm_group_cd"
End
Begin Joins
    LeftTable ="comm_free_goods_redeem"
    RightTable ="comm_customer_hsi_stage"
    Expression ="comm_free_goods_redeem.ShipTo = comm_customer_hsi_stage.hsi_shipto_id"
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
        dbText "Name" ="comm_customer_hsi_stage.hsi_territory_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1920"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_hsi_stage.ship_mailing_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.item_descr"
        dbInteger "ColumnWidth" ="3075"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.free_goods_CDN_ext_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.IMITEM"
        dbInteger "ColumnWidth" ="1125"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.hsi_shipto_nm"
        dbInteger "ColumnWidth" ="3285"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.Source"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.hsi_shipto_id"
        dbInteger "ColumnWidth" ="1695"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.PracticeName"
        dbInteger "ColumnWidth" ="2415"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ItemDescription"
        dbInteger "ColumnWidth" ="3270"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ExtFileCostCadAmt"
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
    Bottom =400
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =1045
        Top =72
        Right =1354
        Bottom =327
        Top =0
        Name ="comm_customer_hsi_stage"
        Name =""
    End
    Begin
        Left =55
        Top =33
        Right =484
        Bottom =266
        Top =0
        Name ="comm_free_goods_redeem"
        Name =""
    End
End
