Operation =4
Option =0
Where ="(((comm_customer_free_goods_YTD.Source)=\"EST\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_customer_free_goods_YTD"
    Name ="comm_item_master"
    Name ="comm_customer_master"
    Name ="comm_group"
End
Begin OutputColumns
    Name ="comm_customer_free_goods_YTD.salesperson_cd"
    Expression ="[comm_customer_master]![salesperson_cd]"
    Name ="comm_customer_free_goods_YTD.comm_group_cd"
    Expression ="[comm_item_master]![comm_group_cd]"
    Name ="comm_customer_free_goods_YTD.CUST_SPM_StatusCd"
    Expression ="[comm_customer_master]![SPM_StatusCd]"
    Name ="comm_customer_free_goods_YTD.CUST_SPM_EQOptOut"
    Expression ="[comm_customer_master]![SPM_EQOptOut]"
    Name ="comm_customer_free_goods_YTD.GRP_SPM_EQOptOut"
    Expression ="[comm_group]![SPM_EQOptOut]"
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_customer_free_goods_YTD"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_customer_free_goods_YTD.fiscal_y"
        "earmo_num"
    Flag =1
    LeftTable ="comm_customer_free_goods_YTD"
    RightTable ="comm_item_master"
    Expression ="comm_customer_free_goods_YTD.IMITEM = comm_item_master.item_id"
    Flag =2
    LeftTable ="comm_customer_free_goods_YTD"
    RightTable ="comm_customer_master"
    Expression ="comm_customer_free_goods_YTD.hsi_shipto_id = comm_customer_master.hsi_shipto_id"
    Flag =2
    LeftTable ="comm_item_master"
    RightTable ="comm_group"
    Expression ="comm_item_master.comm_group_cd = comm_group.comm_group_cd"
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
End
Begin
    State =0
    Left =0
    Top =40
    Right =1526
    Bottom =1004
    Left =-1
    Top =-1
    Right =1494
    Bottom =613
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =52
        Top =57
        Right =196
        Bottom =201
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =261
        Top =-5
        Right =647
        Bottom =406
        Top =0
        Name ="comm_customer_free_goods_YTD"
        Name =""
    End
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
        Left =684
        Top =328
        Right =924
        Bottom =579
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
End
