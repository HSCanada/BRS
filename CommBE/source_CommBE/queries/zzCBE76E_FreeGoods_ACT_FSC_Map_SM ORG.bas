Operation =4
Option =0
Where ="(((comm_customer_free_goods_YTD.fiscal_yearmo_num)=[enter fiscal]) AND ((comm_cu"
    "stomer_free_goods_YTD.Source)=\"ACT\"))"
Begin InputTables
    Name ="comm_customer_free_goods_YTD"
    Name ="comm_group"
    Name ="comm_group"
    Alias ="comm_group_1"
End
Begin OutputColumns
    Name ="comm_customer_free_goods_YTD.SM_comm_group_cd"
    Expression ="IIf((([CUST_SPM_StatusCd]='Y') And (([CUST_SPM_EQOptOut]<>'Y') Or (([CUST_SPM_EQ"
        "OptOut]='Y') And ([GRP_SPM_EQOptOut]<>'Y')))),[comm_group_1]![FRG_comm_group_cd]"
        ",[comm_group]![FRG_comm_group_cd])"
End
Begin Joins
    LeftTable ="comm_customer_free_goods_YTD"
    RightTable ="comm_group"
    Expression ="comm_customer_free_goods_YTD.comm_group_cd = comm_group.comm_group_cd"
    Flag =1
    LeftTable ="comm_group"
    RightTable ="comm_group_1"
    Expression ="comm_group.SPM_comm_group_cd = comm_group_1.comm_group_cd"
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
dbBoolean "UseTransaction" ="0"
dbBoolean "FailOnError" ="-1"
Begin
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.CUST_SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2445"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.GRP_SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.CUST_SPM_StatusCd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2310"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.SM_comm_group_cd"
        dbInteger "ColumnWidth" ="2340"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.SPM_comm_group_cd"
        dbInteger "ColumnWidth" ="2460"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.IMITEM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.free_goods_CDN_ext_cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.item_descr"
        dbInteger "ColumnWidth" ="1860"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group_1.FRG_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.FRG_comm_group_cd"
        dbInteger "ColumnWidth" ="3690"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.division_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.hsi_shipto_nm"
        dbInteger "ColumnWidth" ="3330"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.Source"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1437
    Bottom =977
    Left =-1
    Top =-1
    Right =1413
    Bottom =443
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =234
        Top =70
        Right =620
        Bottom =481
        Top =0
        Name ="comm_customer_free_goods_YTD"
        Name =""
    End
    Begin
        Left =661
        Top =47
        Right =972
        Bottom =374
        Top =0
        Name ="comm_group"
        Name =""
    End
    Begin
        Left =1080
        Top =90
        Right =1363
        Bottom =338
        Top =0
        Name ="comm_group_1"
        Name =""
    End
End
