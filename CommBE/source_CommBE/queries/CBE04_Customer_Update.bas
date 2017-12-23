Operation =4
Option =0
Where ="(((comm_customer_master.hsi_billto_id)<>comm_customer_hsi_stage!hsi_billto_id)) "
    "Or (((comm_customer_master.customer_nm)<>Left(comm_customer_hsi_stage!ship_maili"
    "ng_nm,30))) Or (((comm_customer_master.salesperson_cd)<>comm_customer_hsi_stage!"
    "hsi_territory_cd)) Or (((comm_customer_master.ship_postal_num)<>comm_customer_hs"
    "i_stage!ship_postal_num)) Or (((comm_customer_master.sales_plan_cd)<>Nz([Current"
    "_Sales_Plan_cd],\"0\")))"
Begin InputTables
    Name ="comm_customer_hsi_stage"
    Name ="comm_customer_master"
End
Begin OutputColumns
    Name ="comm_customer_master.hsi_billto_id"
    Expression ="[comm_customer_hsi_stage]![hsi_billto_id]"
    Name ="comm_customer_master.customer_nm"
    Expression ="Left([comm_customer_hsi_stage]![ship_mailing_nm],30)"
    Name ="comm_customer_master.salesperson_cd"
    Expression ="[comm_customer_hsi_stage]![hsi_territory_cd]"
    Name ="comm_customer_master.ship_postal_num"
    Expression ="[comm_customer_hsi_stage]![ship_postal_num]"
    Name ="comm_customer_master.sales_plan_cd"
    Expression ="Nz([Current_Sales_Plan_cd],\"0\")"
End
Begin Joins
    LeftTable ="comm_customer_hsi_stage"
    RightTable ="comm_customer_master"
    Expression ="comm_customer_hsi_stage.hsi_shipto_id = comm_customer_master.hsi_shipto_id"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="0"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="-1"
Begin
    Begin
        dbText "Name" ="comm_customer_master.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.hsi_billto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.customer_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3525"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_master.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_hsi_stage.hsi_billto_id"
        dbInteger "ColumnWidth" ="4350"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_hsi_stage.ship_mailing_nm"
        dbInteger "ColumnWidth" ="4395"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_hsi_stage.hsi_territory_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_hsi_stage.ship_postal_num"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4590"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_master.customer_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_hsi_stage.customer_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="nz([comm_customer_hsi_stage]![customer_id],\"\")"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Nz([comm_customer_master]![customer_id],\"\")"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.ship_postal_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.sales_plan_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_hsi_stage.[Current Sales Plan]"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1534
    Bottom =1009
    Left =-1
    Top =-1
    Right =1502
    Bottom =453
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =38
        Top =6
        Right =409
        Bottom =321
        Top =0
        Name ="comm_customer_hsi_stage"
        Name =""
    End
    Begin
        Left =809
        Top =32
        Right =1123
        Bottom =291
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
End
