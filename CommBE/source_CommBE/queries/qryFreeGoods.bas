Operation =1
Option =0
Where ="(((comm_customer_free_goods_YTD.fiscal_yearmo_num)>=\"201601\") AND ((comm_custo"
    "mer_free_goods_YTD.IMSUPL)=\"PROCGA\") AND ((comm_customer_free_goods_YTD.Source"
    ")=\"ACT\"))"
Begin InputTables
    Name ="comm_customer_free_goods_YTD"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
    Expression ="comm_salesperson_code_map.salesperson_key_id"
    Expression ="comm_customer_free_goods_YTD.hsi_shipto_id"
    Expression ="comm_customer_free_goods_YTD.hsi_shipto_nm"
    Expression ="comm_customer_free_goods_YTD.IMITEM"
    Expression ="comm_customer_free_goods_YTD.item_descr"
    Expression ="comm_customer_free_goods_YTD.IMSUPL"
    Expression ="comm_customer_free_goods_YTD.doc_id"
    Expression ="comm_customer_free_goods_YTD.free_goods_CDN_ext_cost"
    Expression ="comm_customer_free_goods_YTD.comm_group_cd"
    Expression ="comm_customer_free_goods_YTD.Source"
End
Begin Joins
    LeftTable ="comm_customer_free_goods_YTD"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_customer_free_goods_YTD.salesperson_cd = comm_salesperson_code_map.salesper"
        "son_cd"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
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
        dbText "Name" ="comm_customer_free_goods_YTD.hsi_shipto_nm"
        dbInteger "ColumnWidth" ="3120"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.item_descr"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.free_goods_CDN_ext_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.salesperson_ess_cd"
        dbLong "AggregateType" ="-1"
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
        dbText "Name" ="comm_customer_free_goods_YTD.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.IMITEM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.IMSUPL"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1540
    Bottom =999
    Left =-1
    Top =-1
    Right =1081
    Bottom =668
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =66
        Top =60
        Right =830
        Bottom =558
        Top =0
        Name ="comm_customer_free_goods_YTD"
        Name =""
    End
    Begin
        Left =911
        Top =74
        Right =1379
        Bottom =391
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
