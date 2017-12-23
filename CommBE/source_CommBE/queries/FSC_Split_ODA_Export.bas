Operation =1
Option =0
Where ="(((comm_transaction.item_comm_group_cd) Not In (\"ITMSER\",\"ITMPAR\",\"ITMEQ0\""
    ")) AND ((comm_transaction.source_cd)=\"JDE\") AND ((comm_transaction.order_sourc"
    "e_cd)=\"A\") AND ((comm_transaction.salesperson_key_id)<>\"INTERNAL\"))"
Having ="(((First(comm_transaction.doc_type_cd)) Like \"s*\") AND ((Sum(comm_transaction."
    "comm_amt))>0))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.doc_id"
    Alias ="customer_po_num"
    Expression ="First(comm_transaction.customer_po_num)"
    Alias ="doc_type_cd"
    Expression ="First(comm_transaction.doc_type_cd)"
    Alias ="hsi_shipto_id"
    Expression ="First(comm_transaction.hsi_shipto_id)"
    Alias ="salesperson_cd"
    Expression ="First(comm_transaction.salesperson_cd)"
    Alias ="ess_salesperson_cd"
    Expression ="First(comm_transaction.ess_salesperson_cd)"
    Alias ="transaction_dt"
    Expression ="First(comm_transaction.transaction_dt)"
    Alias ="total_transaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
    Alias ="total_gp_ext_amt"
    Expression ="Sum(comm_transaction.gp_ext_amt)"
    Alias ="total_comm_amt"
    Expression ="Sum(comm_transaction.comm_amt)"
    Alias ="Avg Comm"
    Expression ="Sum([comm_amt])/Sum([transaction_amt])"
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_transaction.doc_id"
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
        dbText "Name" ="comm_transaction.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="doc_type_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="total_transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="total_gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="total_comm_amt"
        dbInteger "ColumnWidth" ="2250"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Avg Comm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2505"
        dbBoolean "ColumnHidden" ="0"
        dbText "Format" ="Percent"
        dbByte "DecimalPlaces" ="1"
    End
    Begin
        dbText "Name" ="customer_po_num"
        dbInteger "ColumnWidth" ="2940"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1466
    Bottom =1004
    Left =-1
    Top =-1
    Right =1443
    Bottom =392
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =489
        Top =-2
        Right =738
        Bottom =135
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =38
        Top =6
        Right =336
        Bottom =233
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
