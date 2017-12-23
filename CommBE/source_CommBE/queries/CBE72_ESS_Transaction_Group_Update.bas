Operation =4
Option =0
Where ="(((comm_transaction.ess_comm_plan_id) Like \"ESS*\" Or (comm_transaction.ess_com"
    "m_plan_id) Like \"CCS*\") AND ((comm_transaction.source_cd) In (\"JDE\")))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
    Name ="comm_item_master"
End
Begin OutputColumns
    Name ="comm_transaction.ess_comm_group_cd"
    Expression ="comm_item_master!comm_group_cd"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_item_master"
    Expression ="comm_transaction.item_id = comm_item_master.item_id"
    Flag =1
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
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1365
    Bottom =999
    Left =-1
    Top =-1
    Right =1341
    Bottom =313
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =85
        Top =87
        Right =229
        Bottom =231
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =342
        Top =9
        Right =657
        Bottom =303
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =720
        Top =20
        Right =897
        Bottom =157
        Top =0
        Name ="comm_item_master"
        Name =""
    End
End
