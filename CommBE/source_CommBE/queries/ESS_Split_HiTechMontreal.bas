Operation =1
Option =0
Where ="(((comm_transaction.item_comm_group_cd) Not In (\"ITMEQ0\",\"ITMSER\",\"ITMPAR\""
    ")) AND ((comm_transaction.comm_plan_id) Like \"FSC*\") AND ((comm_transaction.so"
    "urce_cd)=\"JDE\") AND ((comm_salesperson_master.salesperson_territory_cd)=\"NQZC"
    "\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_master"
    Alias ="comm_salesperson_master_1"
    Name ="STAGE_HiTechMontreal"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.salesperson_cd"
    Expression ="comm_transaction.ess_salesperson_cd"
    Alias ="ess_salesperson_nm"
    Expression ="comm_salesperson_master_1.salesperson_nm"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.IMITEM"
    Expression ="comm_transaction.transaction_dt"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.manufact_cd"
    Expression ="comm_transaction.IMCLMJ"
    Expression ="comm_transaction.IMCLSJ"
    Expression ="comm_transaction.IMCLMJ"
    Expression ="comm_salesperson_master.branch_cd"
    Expression ="comm_transaction.record_id"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id=comm_salesperson_master.salesperson_key_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master_1"
    Expression ="comm_transaction.ess_salesperson_key_id=comm_salesperson_master_1.salesperson_ke"
        "y_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="STAGE_HiTechMontreal"
    Expression ="comm_transaction.IMCLSJ=STAGE_HiTechMontreal.IMCLSJ"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="STAGE_HiTechMontreal"
    Expression ="comm_transaction.IMCLMJ=STAGE_HiTechMontreal.IMCLMJ"
    Flag =1
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num=comm_transaction.fiscal_yearmo_num"
    Flag =1
End
Begin OrderBy
    Expression ="comm_transaction.fiscal_yearmo_num"
    Flag =0
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
        dbText "Name" ="comm_transaction.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_dt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1800"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1995"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMITEM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3165"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_cd"
        dbInteger "ColumnWidth" ="2460"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.manufact_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ess_salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMCLSJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1013"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1515
    Bottom =1008
    Left =-1
    Top =-1
    Right =1496
    Bottom =681
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =336
        Bottom =476
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =650
        Top =157
        Right =996
        Bottom =404
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =408
        Top =517
        Right =646
        Bottom =661
        Top =0
        Name ="comm_salesperson_master_1"
        Name =""
    End
    Begin
        Left =413
        Top =240
        Right =557
        Bottom =384
        Top =0
        Name ="STAGE_HiTechMontreal"
        Name =""
    End
    Begin
        Left =439
        Top =24
        Right =583
        Bottom =168
        Top =0
        Name ="comm_configure"
        Name =""
    End
End
