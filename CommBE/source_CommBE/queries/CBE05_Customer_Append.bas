Operation =3
Name ="comm_customer_master"
Option =0
Where ="(((comm_customer_master.hsi_shipto_id) Is Null))"
Begin InputTables
    Name ="comm_customer_hsi_stage"
    Name ="comm_customer_master"
End
Begin OutputColumns
    Name ="hsi_shipto_id"
    Expression ="comm_customer_hsi_stage.hsi_shipto_id"
    Name ="hsi_billto_id"
    Expression ="comm_customer_hsi_stage.hsi_billto_id"
    Name ="customer_nm"
    Expression ="comm_customer_hsi_stage.ship_mailing_nm"
    Name ="salesperson_cd"
    Expression ="comm_customer_hsi_stage.hsi_territory_cd"
    Alias ="Expr3"
    Name ="ship_postal_num"
    Expression ="Nz([comm_customer_hsi_stage]![ship_postal_num],\"\")"
    Alias ="Expr2"
    Name ="sales_plan_cd"
    Expression ="Nz([Current_Sales_Plan_cd],\"0\")"
End
Begin Joins
    LeftTable ="comm_customer_hsi_stage"
    RightTable ="comm_customer_master"
    Expression ="comm_customer_hsi_stage.hsi_shipto_id = comm_customer_master.hsi_shipto_id"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="0"
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
        dbText "Name" ="comm_customer_hsi_stage.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="customer_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1635"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_customer_hsi_stage.ship_postal_num"
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
    Right =1539
    Bottom =1004
    Left =-1
    Top =-1
    Right =1507
    Bottom =453
    Left =0
    Top =0
    ColumnsShown =651
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
        Right =1012
        Bottom =407
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
End
