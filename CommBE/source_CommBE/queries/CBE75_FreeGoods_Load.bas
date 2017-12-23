Operation =1
Option =0
Begin InputTables
    Name ="comm_configure"
    Name ="comm_customer_free_goods_YTD"
End
Begin OutputColumns
    Expression ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
    Expression ="comm_customer_free_goods_YTD.hsi_shipto_id"
    Expression ="comm_customer_free_goods_YTD.hsi_shipto_nm"
    Expression ="comm_customer_free_goods_YTD.IMITEM"
    Expression ="comm_customer_free_goods_YTD.item_descr"
    Expression ="comm_customer_free_goods_YTD.IMSUPL"
    Expression ="comm_customer_free_goods_YTD.doc_id"
    Expression ="comm_customer_free_goods_YTD.free_goods_CDN_ext_cost"
    Expression ="comm_customer_free_goods_YTD.Source"
    Expression ="comm_customer_free_goods_YTD.salesperson_cd"
    Expression ="comm_customer_free_goods_YTD.comm_group_cd"
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_customer_free_goods_YTD"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_customer_free_goods_YTD.fiscal_y"
        "earmo_num"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CBE75_FreeGoods_Load].[Source]"
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
        dbInteger "ColumnWidth" ="3240"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.IMITEM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.item_descr"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.IMSUPL"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.free_goods_CDN_ext_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.Source"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =27
    Top =-12
    Right =1590
    Bottom =939
    Left =-1
    Top =-1
    Right =1545
    Bottom =580
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
End
