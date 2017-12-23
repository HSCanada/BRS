Operation =1
Option =0
Where ="(((comm_transaction.salesperson_key_id)<>\"Internal\") AND ((comm_transaction.it"
    "em_comm_group_cd)=\"ITMARS\") AND ((comm_transaction.manufact_cd) In (\"GENSCI\""
    ",\"STAR\",\"SPADNT\")) AND ((comm_salesperson_master.branch_cd) In (\"HALFX\",\""
    "LONDN\",\"MNTRL\",\"OTTWA\",\"QUEBC\",\"SJOHN\",\"TORNT\"))) OR (((comm_transact"
    "ion.salesperson_key_id)<>\"Internal\") AND ((comm_transaction.manufact_cd) In (\""
    "SPADNT\")) AND ((comm_salesperson_master.branch_cd) In (\"LONDN\",\"OTTWA\",\"TO"
    "RNT\",\"WINPG\")))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
    Name ="comm_configure"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.salesperson_key_id"
    Expression ="comm_transaction.transaction_dt"
    Expression ="comm_transaction.shipped_qty"
    Alias ="FreeGood_ind"
    Expression ="IIf([transaction_amt]=0,\"Y\",\"N\")"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.source_cd"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.IMITEM"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.hsi_shipto_nm"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.IMCLMJ"
    Expression ="comm_transaction.manufact_cd"
    Expression ="comm_salesperson_master.branch_cd"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
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
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
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
        dbInteger "ColumnWidth" ="3675"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.manufact_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2925"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FreeGood_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
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
    Right =1503
    Bottom =285
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =40
        Top =54
        Right =338
        Bottom =281
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =473
        Top =148
        Right =617
        Bottom =292
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =434
        Top =-2
        Right =578
        Bottom =142
        Top =0
        Name ="comm_configure"
        Name =""
    End
End
