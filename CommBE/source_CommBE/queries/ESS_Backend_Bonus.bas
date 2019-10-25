Operation =1
Option =0
Where ="(((comm_transaction.ess_comm_plan_id)=\"ESSGP\") AND ((comm_transaction.sales_ca"
    "tegory_cd) In (\"HITECH\",\"EQUIPM\")) AND ((comm_transaction.source_cd)=\"JDE\""
    "))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
    Name ="comm_configure"
End
Begin OutputColumns
    Expression ="comm_transaction.ess_salesperson_key_id"
    Expression ="comm_transaction.fiscal_yearmo_num"
    Alias ="ess_salesperson_cd_trim"
    Expression ="Trim([master_salesperson_cd])"
    Expression ="comm_transaction.ess_comm_plan_id"
    Expression ="comm_transaction.transaction_dt"
    Expression ="comm_transaction.line_id"
    Expression ="comm_transaction.item_id"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.doc_id"
    Expression ="comm_transaction.ess_comm_group_cd"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.record_id"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.customer_nm"
    Expression ="comm_transaction.salesperson_cd"
    Expression ="comm_transaction.manufact_cd"
    Expression ="comm_transaction.sales_category_cd"
    Expression ="comm_transaction.IMCLMJ"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.ess_salesperson_key_id = comm_salesperson_master.salesperson_ke"
        "y_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_configure"
    Expression ="comm_transaction.fiscal_yearmo_num = comm_configure.current_fiscal_yearmo_num"
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
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1980"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1995"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1560"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3030"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.customer_nm"
        dbInteger "ColumnWidth" ="3000"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_dt"
        dbInteger "ColumnWidth" ="2175"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.manufact_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.sales_category_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ess_salesperson_cd_trim"
        dbInteger "ColumnWidth" ="2460"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-32
    Top =40
    Right =1531
    Bottom =976
    Left =-1
    Top =-1
    Right =1545
    Bottom =379
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =417
        Bottom =443
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =526
        Top =277
        Right =786
        Bottom =448
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =504
        Top =30
        Right =648
        Bottom =174
        Top =0
        Name ="comm_configure"
        Name =""
    End
End
