Operation =4
Option =0
Where ="(((comm_free_goods_redeem.SourceCode)=\"EST\") AND ((comm_free_goods_redeem.CalM"
    "onth)=[enter fiscal]))"
Begin InputTables
    Name ="comm_group"
    Name ="comm_group"
    Alias ="comm_group_1"
    Name ="comm_free_goods_redeem"
End
Begin OutputColumns
    Name ="comm_free_goods_redeem.fsc_comm_group_cd"
    Expression ="IIf((([special_market_ind]=1) And (([equipment_opt_out_ind]<>1) Or (([equipment_"
        "opt_out_ind]=1) And ([group_equipment_opt_out_ind]<>1)))),[comm_group_1]![FRG_co"
        "mm_group_cd],[comm_group]![FRG_comm_group_cd])"
End
Begin Joins
    LeftTable ="comm_group"
    RightTable ="comm_group_1"
    Expression ="comm_group.SPM_comm_group_cd = comm_group_1.comm_group_cd"
    Flag =1
    LeftTable ="comm_free_goods_redeem"
    RightTable ="comm_group"
    Expression ="comm_free_goods_redeem.comm_group_cd = comm_group.comm_group_cd"
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
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
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
    Begin
        dbText "Name" ="comm_free_goods_redeem.SM_comm_group_cd"
        dbInteger "ColumnWidth" ="2340"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.Source"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.special_market_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.equipment_opt_out_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.group_equipment_opt_out_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.fsc_comm_group_cd"
        dbInteger "ColumnWidth" ="2340"
        dbBoolean "ColumnHidden" ="0"
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
    Bottom =494
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =665
        Top =22
        Right =976
        Bottom =349
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
    Begin
        Left =110
        Top =43
        Right =420
        Bottom =289
        Top =0
        Name ="comm_free_goods_redeem"
        Name =""
    End
End
