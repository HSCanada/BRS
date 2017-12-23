Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num) Between \"201601\" And \"201604\") AND (("
    "BRS_Item.MajorProductClass) In (\"855\",\"856\",\"857\",\"858\",\"X11\",\"X12\","
    "\"X17\")) AND ((comm_transaction.source_cd)=\"JDE\") AND ((comm_transaction.sale"
    "sperson_key_id)<>\"Internal\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_code_map"
    Name ="comm_item_master"
    Name ="comm_customer_master"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Alias ="TERdnu"
    Expression ="\"\""
    Alias ="Grpdnu"
    Expression ="\"\""
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.customer_nm"
    Expression ="comm_transaction.item_id"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.shipped_qty"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.transaction_dt"
    Expression ="BRS_Item.MinorProductClass"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_transaction.pmts_salesperson_cd"
    Expression ="comm_transaction.ess_salesperson_cd"
    Expression ="comm_salesperson_code_map.branch_cd"
    Alias ="PC1"
    Expression ="Left([ship_postal_num],1)"
    Alias ="PC3"
    Expression ="Left([ship_postal_num],3)"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="BRS_Item.MajorProductClass"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_transaction.salesperson_cd = comm_salesperson_code_map.salesperson_cd"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_item_master"
    Expression ="comm_transaction.item_id = comm_item_master.item_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_customer_master"
    Expression ="comm_transaction.hsi_shipto_id = comm_customer_master.hsi_shipto_id"
    Flag =1
    LeftTable ="comm_item_master"
    RightTable ="BRS_Item"
    Expression ="comm_item_master.item_id = BRS_Item.Item"
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
    Begin
        dbText "Name" ="comm_item_master.MinorCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="PC3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="PC1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Grpdnu"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="TERdnu"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.hsi_class_major_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1586
    Bottom =999
    Left =-1
    Top =-1
    Right =1259
    Bottom =484
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =282
        Top =-2
        Right =497
        Bottom =519
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =654
        Top =-9
        Right =936
        Bottom =135
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =937
        Top =258
        Right =1216
        Bottom =452
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
    Begin
        Left =587
        Top =251
        Right =808
        Bottom =578
        Top =0
        Name ="comm_item_master"
        Name =""
    End
    Begin
        Left =1209
        Top =53
        Right =1452
        Bottom =336
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =910
        Top =177
        Right =1162
        Bottom =403
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
