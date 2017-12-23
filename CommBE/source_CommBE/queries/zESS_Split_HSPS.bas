dbMemo "SQL" ="SELECT comm_transaction.fiscal_yearmo_num, comm_transaction.salesperson_cd, comm"
    "_transaction.ess_salesperson_cd, comm_salesperson_master_1.salesperson_nm AS ess"
    "_salesperson_nm, comm_transaction.hsi_shipto_id, comm_transaction.doc_key_id, co"
    "mm_transaction.IMITEM, comm_transaction.transaction_dt, comm_transaction.transac"
    "tion_amt, comm_transaction.gp_ext_amt, comm_transaction.item_comm_group_cd, comm"
    "_transaction.transaction_txt, comm_transaction.manufact_cd, comm_transaction.IMC"
    "LMJ, comm_transaction.IMCLSJ, comm_transaction.IMCLMJ, comm_salesperson_master.b"
    "ranch_cd, comm_transaction.record_id\015\012FROM comm_configure INNER JOIN (((co"
    "mm_transaction INNER JOIN comm_salesperson_master ON comm_transaction.salesperso"
    "n_key_id=comm_salesperson_master.salesperson_key_id) INNER JOIN comm_salesperson"
    "_master AS comm_salesperson_master_1 ON comm_transaction.ess_salesperson_key_id="
    "comm_salesperson_master_1.salesperson_key_id) INNER JOIN STAGE_HiTechMontreal ON"
    " (comm_transaction.IMCLSJ=STAGE_HiTechMontreal.IMCLSJ) AND (comm_transaction.IMC"
    "LMJ=STAGE_HiTechMontreal.IMCLMJ)) ON comm_configure.current_fiscal_yearmo_num=co"
    "mm_transaction.fiscal_yearmo_num\015\012WHERE (((comm_transaction.item_comm_grou"
    "p_cd) Not In (\"ITMEQ0\",\"ITMSER\",\"ITMPAR\")) AND ((comm_transaction.comm_pla"
    "n_id) Like \"FSC*\") AND ((comm_transaction.source_cd)=\"JDE\") AND ((comm_sales"
    "person_master.salesperson_territory_cd)=\"NQZC\"))\015\012ORDER BY comm_transact"
    "ion.fiscal_yearmo_num;\015\012"
dbMemo "Connect" =""
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
