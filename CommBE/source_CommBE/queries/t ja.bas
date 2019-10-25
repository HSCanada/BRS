Operation =1
Option =0
Where ="(((comm_salesperson_code_map.salesperson_key_id)=\"JAdamski\") AND ((comm_custom"
    "er_free_goods_YTD.fiscal_yearmo_num)>=\"201901\"))"
Begin InputTables
    Name ="comm_customer_free_goods_YTD"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_salesperson_code_map.salesperson_key_id"
    Expression ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
    Expression ="comm_customer_free_goods_YTD.hsi_shipto_id"
    Expression ="comm_customer_free_goods_YTD.hsi_shipto_nm"
    Expression ="comm_customer_free_goods_YTD.IMITEM"
    Expression ="comm_customer_free_goods_YTD.item_descr"
    Expression ="comm_customer_free_goods_YTD.doc_id"
    Expression ="comm_customer_free_goods_YTD.free_goods_CDN_ext_cost"
    Expression ="comm_customer_free_goods_YTD.salesperson_cd"
    Expression ="comm_customer_free_goods_YTD.salesperson_ess_cd"
    Expression ="comm_customer_free_goods_YTD.comm_group_cd"
    Expression ="comm_customer_free_goods_YTD.ID"
    Expression ="comm_customer_free_goods_YTD.Source"
    Expression ="comm_customer_free_goods_YTD.SM_comm_group_cd"
    Expression ="comm_customer_free_goods_YTD.CUST_SPM_StatusCd"
    Expression ="comm_customer_free_goods_YTD.CUST_SPM_EQOptOut"
    Expression ="comm_customer_free_goods_YTD.GRP_SPM_EQOptOut"
    Expression ="comm_customer_free_goods_YTD.OrderSourceCd"
    Expression ="comm_customer_free_goods_YTD.IMSUPL"
End
Begin Joins
    LeftTable ="comm_customer_free_goods_YTD"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_customer_free_goods_YTD.salesperson_cd = comm_salesperson_code_map.salesper"
        "son_cd"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query1].[fiscal_yearmo_num]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.CUST_SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.IMSUPL"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.item_descr"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.IMITEM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.hsi_shipto_nm"
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
        dbText "Name" ="comm_customer_free_goods_YTD.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.salesperson_ess_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.Source"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.SM_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.CUST_SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.GRP_SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.OrderSourceCd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1534
    Bottom =865
    Left =-1
    Top =-1
    Right =1484
    Bottom =538
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =30
        Top =48
        Right =570
        Bottom =397
        Top =0
        Name ="comm_customer_free_goods_YTD"
        Name =""
    End
    Begin
        Left =646
        Top =71
        Right =1092
        Bottom =431
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
