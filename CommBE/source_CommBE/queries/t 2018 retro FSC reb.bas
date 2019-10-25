Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num) Between \"201701\" And \"201712\") AND (("
    "comm_transaction.item_comm_group_cd)=\"REBSND\") AND ((comm_customer_master.SPM_"
    "StatusCd)=\"y\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_customer_master"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.salesperson_key_id"
    Expression ="comm_transaction.comm_plan_id"
    Expression ="comm_transaction.item_id"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.vpa_desc"
    Expression ="comm_customer_master.SPM_StatusCd"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_customer_master"
    Expression ="comm_transaction.hsi_shipto_id = comm_customer_master.hsi_shipto_id"
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
Begin
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbInteger "ColumnWidth" ="2565"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1140"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2490"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.vpa_desc"
        dbInteger "ColumnWidth" ="3375"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1541
    Bottom =976
    Left =-1
    Top =-1
    Right =1523
    Bottom =626
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =806
        Bottom =608
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =932
        Top =49
        Right =1294
        Bottom =417
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
End
