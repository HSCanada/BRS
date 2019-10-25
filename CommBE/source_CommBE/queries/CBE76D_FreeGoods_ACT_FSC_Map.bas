Operation =4
Option =0
Where ="(((comm_free_goods_redeem.SourceCode)=\"ACT\") AND ((comm_free_goods_redeem.CalM"
    "onth)=[enter fiscal]))"
Begin InputTables
    Name ="comm_item_master"
    Name ="comm_customer_master"
    Name ="comm_group"
    Name ="comm_free_goods_redeem"
End
Begin OutputColumns
    Name ="comm_free_goods_redeem.salesperson_cd"
    Expression ="[comm_customer_master]![salesperson_cd]"
    Name ="comm_free_goods_redeem.comm_group_cd"
    Expression ="[comm_item_master]![comm_group_cd]"
    Name ="comm_free_goods_redeem.special_market_ind"
    Expression ="IIf([comm_customer_master]![SPM_StatusCd]=\"Y\",1,0)"
    Name ="comm_free_goods_redeem.equipment_opt_out_ind"
    Expression ="IIf([comm_customer_master]![SPM_EQOptOut]=\"Y\",1,0)"
    Name ="comm_free_goods_redeem.group_equipment_opt_out_ind"
    Expression ="IIf([comm_group]![SPM_EQOptOut]=\"Y\",1,0)"
End
Begin Joins
    LeftTable ="comm_item_master"
    RightTable ="comm_group"
    Expression ="comm_item_master.comm_group_cd = comm_group.comm_group_cd"
    Flag =2
    LeftTable ="comm_free_goods_redeem"
    RightTable ="comm_customer_master"
    Expression ="comm_free_goods_redeem.ShipTo = comm_customer_master.hsi_shipto_id"
    Flag =2
    LeftTable ="comm_free_goods_redeem"
    RightTable ="comm_item_master"
    Expression ="comm_free_goods_redeem.Item = comm_item_master.item_id"
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
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
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
        dbText "Name" ="comm_customer_free_goods_YTD.division_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.hsi_shipto_nm"
        dbInteger "ColumnWidth" ="3330"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.Source"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.CUST_SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.GRP_SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.CUST_SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.equipment_opt_out_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.special_market_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.group_equipment_opt_out_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.GRP_SPM_EQOptOut"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.CUST_SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.Source"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.CUST_SPM_EQOptOut"
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
End
Begin
    State =0
    Left =0
    Top =40
    Right =1445
    Bottom =817
    Left =-1
    Top =-1
    Right =1421
    Bottom =528
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =906
        Top =-4
        Right =1240
        Bottom =288
        Top =0
        Name ="comm_item_master"
        Name =""
    End
    Begin
        Left =843
        Top =303
        Right =1083
        Bottom =554
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =1296
        Top =15
        Right =1495
        Bottom =346
        Top =0
        Name ="comm_group"
        Name =""
    End
    Begin
        Left =126
        Top =61
        Right =303
        Bottom =359
        Top =0
        Name ="comm_free_goods_redeem"
        Name =""
    End
End
