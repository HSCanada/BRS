Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num) Between \"201701\" And \"201703\") AND (("
    "comm_transaction.salesperson_key_id)<>\"Internal\") AND ((comm_transaction.manuf"
    "act_cd) In (\"MILSCI\",\"WAND\",\"GENSCI\",\"SPADNT\",\"INENDO\",\"ORTHOT\")) AN"
    "D ((comm_transaction.item_id) Not In (\"1074153\",\"1070511\",\"1076903\",\"1084"
    "419\",\"1089279\")) AND ((comm_transaction.source_cd)=\"JDE\")) OR (((comm_trans"
    "action.fiscal_yearmo_num) Between \"201701\" And \"201703\") AND ((comm_transact"
    "ion.salesperson_key_id)<>\"Internal\") AND ((comm_transaction.item_id) In (\"808"
    "0261\",\"8080264\",\"8080279\",\"8080282\") Or (comm_transaction.item_id) In (\""
    "5950000\",\"5950014\",\"5950027\",\"5950028\",\"5950029\",\"5950031\",\"5950032\""
    ",\"5950033\",\"5950034\",\"5950035\",\"5959558\")) AND ((comm_transaction.source"
    "_cd)=\"JDE\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_eps_region_map"
    Name ="comm_eps_productline"
    Name ="comm_eps_specialist_map"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_eps_specialist_map.EPS_Specialist"
    Expression ="comm_eps_productline.EPS_ProductLine"
    Expression ="comm_eps_region_map.EPS_Region"
    Expression ="comm_transaction.salesperson_key_id"
    Expression ="comm_transaction.manufact_cd"
    Expression ="comm_transaction.item_id"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.IMCLMJ"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.shipped_qty"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.transaction_dt"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.hsi_shipto_nm"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.line_id"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_eps_region_map"
    Expression ="comm_transaction.hsi_shipto_id = comm_eps_region_map.hsi_shipto_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_eps_productline"
    Expression ="comm_transaction.manufact_cd = comm_eps_productline.manufact_cd"
    Flag =1
    LeftTable ="comm_eps_productline"
    RightTable ="comm_eps_specialist_map"
    Expression ="comm_eps_productline.EPS_ProductLine = comm_eps_specialist_map.EPS_ProductLine"
    Flag =1
    LeftTable ="comm_eps_region_map"
    RightTable ="comm_eps_specialist_map"
    Expression ="comm_eps_region_map.EPS_Region = comm_eps_specialist_map.EPS_Region"
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
        dbText "Name" ="comm_transaction.item_comm_group_cd"
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
        dbText "Name" ="comm_eps_region_map.EPS_Region"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.[item_id]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_eps_productline.EPS_ProductLine"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_eps_specialist_map.EPS_Specialist"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1589
    Bottom =999
    Left =-1
    Top =-1
    Right =1565
    Bottom =377
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =336
        Bottom =360
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =510
        Top =201
        Right =713
        Bottom =370
        Top =0
        Name ="comm_eps_region_map"
        Name =""
    End
    Begin
        Left =418
        Top =38
        Right =562
        Bottom =182
        Top =0
        Name ="comm_eps_productline"
        Name =""
    End
    Begin
        Left =808
        Top =71
        Right =952
        Bottom =215
        Top =0
        Name ="comm_eps_specialist_map"
        Name =""
    End
End
