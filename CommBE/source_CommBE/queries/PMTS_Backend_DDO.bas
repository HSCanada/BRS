Operation =1
Option =0
Where ="(((comm_transaction.item_id) In ('5814032','1247256','1341116','1342936','134458"
    "5','5858822','5858858','5859847','5859848','5859849','5859851','5859852')) AND ("
    "(comm_transaction.salesperson_key_id)<>\"Internal\") AND ((comm_transaction.sour"
    "ce_cd)=\"JDE\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_territory_map"
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
    Expression ="comm_salesperson_territory_map.branch_nm"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_salesperson_territory_map"
    Expression ="comm_salesperson_master.salesperson_territory_cd = comm_salesperson_territory_ma"
        "p.salesperson_territory_cd"
    Flag =1
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="For Commissions dept. - Dentrix Fiscal ME Report"
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
        dbText "Name" ="comm_transaction.customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
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
        dbText "Name" ="comm_transaction.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_territory_map.branch_nm"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1634
    Bottom =600
    Left =-1
    Top =-1
    Right =1611
    Bottom =352
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =101
        Top =120
        Right =245
        Bottom =264
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =309
        Top =31
        Right =542
        Bottom =313
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =681
        Top =106
        Right =912
        Bottom =250
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =1044
        Top =167
        Right =1188
        Bottom =311
        Top =0
        Name ="comm_salesperson_territory_map"
        Name =""
    End
End
