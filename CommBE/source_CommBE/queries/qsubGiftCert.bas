Operation =1
Option =0
Where ="(((comm_transaction.comm_plan_id) Like \"FSC*\") AND ((comm_transaction.source_c"
    "d) In (\"ACCPAC\",\"JDE\")))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
    Name ="comm_item_master"
    Name ="STAGE_GiftCert"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.salesperson_key_id"
    Alias ="FirstOfcustomer_nm"
    Expression ="First(comm_transaction.customer_nm)"
    Alias ="FirstOfdoc_id"
    Expression ="First(comm_transaction.doc_id)"
    Alias ="cert_amt"
    Expression ="Sum([supplier_cost_amt]*[shipped_qty])"
    Alias ="red_gp_ext_amt"
    Expression ="Sum([gp_ext_amt])*0.25"
    Alias ="comm_adj_amt"
    Expression ="Sum([supplier_cost_amt]*[shipped_qty]*0.25)"
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_item_master"
    Expression ="comm_transaction.item_id = comm_item_master.item_id"
    Flag =1
    LeftTable ="comm_item_master"
    RightTable ="STAGE_GiftCert"
    Expression ="comm_item_master.item_id = STAGE_GiftCert.item_id"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_transaction.salesperson_key_id"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbInteger "ColumnWidth" ="1860"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfcustomer_nm"
        dbInteger "ColumnWidth" ="3600"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfdoc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="cert_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adj_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="red_gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =20
    Top =66
    Right =1619
    Bottom =1030
    Left =-1
    Top =-1
    Right =1576
    Bottom =348
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =20
        Top =32
        Right =242
        Bottom =281
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =279
        Top =21
        Right =539
        Bottom =233
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =577
        Top =6
        Right =898
        Bottom =218
        Top =0
        Name ="comm_item_master"
        Name =""
    End
    Begin
        Left =985
        Top =33
        Right =1129
        Bottom =177
        Top =0
        Name ="STAGE_GiftCert"
        Name =""
    End
End
