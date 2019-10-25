Operation =1
Option =0
Where ="(((comm_salesperson_code_map.branch_cd) In (\"WINPG\",\"VICTR\",\"VACVR\",\"REGI"
    "N\",\"EDMON\",\"CALGY\")) AND ((comm_transaction.source_cd)=\"JDE\") AND ((comm_"
    "transaction.salesperson_key_id)<>\"Internal\") AND ((comm_transaction.IMCLMJ) In"
    " (\"856\",\"X12\",\"857\",\"858\",\"X17\",\"855\",\"X11\")) AND ((comm_transacti"
    "on.manufact_cd) Not In (\"BIOLAS\",\"IMASCI\")))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.customer_nm"
    Expression ="comm_transaction.item_id"
    Expression ="comm_transaction.transaction_txt"
    Alias ="Class"
    Expression ="[IMCLMJ] & \"-\" & Right(\"**\" & Trim([IMCLSJ]),2) & \"-\" & Right(\"**\" & Tri"
        "m([IMCLMC]),2) & \"-\" & Right(\"**\" & Trim([IMCLSM]),2)"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.shipped_qty"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.transaction_dt"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_transaction.pmts_salesperson_cd"
    Expression ="comm_transaction.ess_salesperson_cd"
    Expression ="comm_salesperson_code_map.branch_cd"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_transaction.salesperson_cd = comm_salesperson_code_map.salesperson_cd"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="180"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="For Commissions dept. - Dentrix Fiscal ME Report"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="Class"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2460"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3405"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
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
        dbText "Name" ="comm_transaction.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.pmts_salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2595"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.branch_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1555
    Bottom =1009
    Left =-1
    Top =-1
    Right =1532
    Bottom =195
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =92
        Top =25
        Right =236
        Bottom =169
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =282
        Top =-2
        Right =497
        Bottom =292
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =545
        Top =34
        Right =827
        Bottom =178
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =961
        Top =52
        Right =1105
        Bottom =196
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
