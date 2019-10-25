Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num) Between \"201501\" And \"201512\") AND (("
    "BRS_Item.Supplier) In (\"ADEC\",\"CPIINT\",\"DEXISL\",\"GENDEN\",\"GENDEX\",\"IM"
    "ASCI\",\"INSTRM\",\"KAVODC\",\"KAVODG\",\"MARUS\",\"PELTON\")) AND ((BRS_Item.Sa"
    "lesCategory) In (\"HITECH\",\"EQUIPM\")))"
Begin InputTables
    Name ="comm_transaction"
    Name ="BRS_Item"
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_master"
    Alias ="comm_salesperson_master_1"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="BRS_Item.Supplier"
    Alias ="FSC_Code"
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Alias ="FSC_Name"
    Expression ="First(comm_salesperson_master.salesperson_nm)"
    Expression ="comm_salesperson_master.branch_cd"
    Alias ="ESS_Code"
    Expression ="comm_salesperson_master_1.master_salesperson_cd"
    Alias ="ESS_Name"
    Expression ="First(comm_salesperson_master_1.salesperson_nm)"
    Expression ="comm_transaction.source_cd"
    Expression ="BRS_Item.SalesCategory"
    Alias ="SumOfshipped_qty"
    Expression ="Sum(comm_transaction.shipped_qty)"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(comm_transaction.gp_ext_amt)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="BRS_Item"
    Expression ="comm_transaction.item_id = BRS_Item.Item"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master_1"
    Expression ="comm_transaction.ess_salesperson_key_id = comm_salesperson_master_1.salesperson_"
        "key_id"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="BRS_Item.Supplier"
    GroupLevel =0
    Expression ="comm_salesperson_master.master_salesperson_cd"
    GroupLevel =0
    Expression ="comm_salesperson_master.branch_cd"
    GroupLevel =0
    Expression ="comm_salesperson_master_1.master_salesperson_cd"
    GroupLevel =0
    Expression ="comm_transaction.source_cd"
    GroupLevel =0
    Expression ="BRS_Item.SalesCategory"
    GroupLevel =0
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
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1350"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="SumOfshipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfgp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ESS_Code"
        dbInteger "ColumnWidth" ="1320"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ESS_Name"
        dbInteger "ColumnWidth" ="2670"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FSC_Code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FSC_Name"
        dbInteger "ColumnWidth" ="2910"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_1.master_salesperson_cd"
        dbInteger "ColumnWidth" ="5400"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_1.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfsalesperson_nm1"
        dbInteger "ColumnWidth" ="2670"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfsalesperson_nm"
        dbInteger "ColumnWidth" ="2910"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1488
    Bottom =951
    Left =-1
    Top =-1
    Right =1456
    Bottom =383
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =468
        Bottom =409
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =590
        Top =47
        Right =985
        Bottom =447
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =549
        Top =506
        Right =759
        Bottom =650
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =356
        Top =462
        Right =500
        Bottom =606
        Top =0
        Name ="comm_salesperson_master_1"
        Name =""
    End
End
