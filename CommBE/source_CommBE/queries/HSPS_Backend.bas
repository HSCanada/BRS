Operation =1
Option =0
Where ="(((comm_transaction.source_cd)=\"JDE\") AND ((comm_transaction.salesperson_key_i"
    "d)<>\"Internal\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_code_map"
    Name ="comm_item_master"
    Name ="comm_customer_master"
    Name ="BRS_Item"
    Name ="comm_item_hsps"
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
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
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
    LeftTable ="comm_item_hsps"
    RightTable ="BRS_Item"
    Expression ="comm_item_hsps.item = BRS_Item.Item"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_item_hsps"
    Expression ="comm_transaction.item_id = comm_item_hsps.item"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
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
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =925
    Bottom =984
    Left =-1
    Top =-1
    Right =901
    Bottom =467
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
        Left =982
        Top =255
        Right =1261
        Bottom =449
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
        Left =1092
        Top =15
        Right =1335
        Bottom =298
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =782
        Top =23
        Right =1034
        Bottom =249
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =623
        Top =31
        Right =767
        Bottom =175
        Top =0
        Name ="comm_item_hsps"
        Name =""
    End
End
