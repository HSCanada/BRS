Operation =4
Option =0
Where ="(((comm_transaction.item_comm_group_cd) In (\"ITME4D\",\"ITMFO1\",\"ITMFO2\",\"I"
    "TMFO3\",\"ITMISC\",\"ITMMID\",\"FRESEQ\",\"SPMEQU\",\"ITMCPU\",\"ITMSOF\")) AND "
    "((comm_transaction.comm_plan_id) Like \"FSC*\") AND ((comm_transaction.source_cd"
    ") In (\"JDE\")) AND ((comm_transaction.customer_comm_group_cd)=\"CUSINS\") AND ("
    "(comm_transaction.vpa_cd)<>\"RID01\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
End
Begin OutputColumns
    Name ="comm_transaction.item_comm_group_cd"
    Expression ="\"SPMEQU\""
    Name ="comm_transaction.comm_group_cd"
    Expression ="\"SPMEQU\""
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "DefaultView" ="2"
dbText "Description" ="Change Fiscal period in qry"
Begin
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_key_id"
        dbInteger "ColumnWidth" ="2325"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.reference_order_txt"
        dbInteger "ColumnWidth" ="1845"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.contact_nm"
        dbInteger "ColumnWidth" ="1590"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.customer_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.vpa_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbInteger "ColumnWidth" ="2490"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1547
    Bottom =1005
    Left =-1
    Top =-1
    Right =1523
    Bottom =412
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =85
        Top =87
        Right =349
        Bottom =406
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =583
        Top =51
        Right =898
        Bottom =345
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
