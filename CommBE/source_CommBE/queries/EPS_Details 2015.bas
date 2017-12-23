Operation =1
Option =0
Where ="(((comm_transaction.manufact_cd)=\"GENSCI\") AND ((comm_transaction.salesperson_"
    "key_id)<>\"Internal\") AND ((comm_transaction.source_cd)=\"JDE\")) OR (((comm_ep"
    "s_region_map.EPS_Region)<>\"WEST\") AND ((comm_transaction.salesperson_key_id)<>"
    "\"Internal\") AND ((comm_transaction.item_id) In (\"8080261\",\"8080264\",\"8080"
    "279\",\"8080282\")) AND ((comm_transaction.source_cd)=\"JDE\")) OR (((comm_trans"
    "action.manufact_cd)=\"SPADNT\") AND ((comm_eps_region_map.EPS_Region)<>\"WEST\")"
    " AND ((comm_transaction.salesperson_key_id)<>\"Internal\") AND ((comm_transactio"
    "n.source_cd)=\"JDE\")) OR (((comm_eps_region_map.EPS_Region)<>\"WEST\") AND ((co"
    "mm_transaction.salesperson_key_id)<>\"Internal\") AND ((comm_transaction.item_id"
    ") In (\"5950000\",\"5950014\",\"5950027\",\"5950028\",\"5950029\",\"5950031\",\""
    "5950032\",\"5950033\",\"5950034\",\"5950035\",\"5959558\")) AND ((comm_transacti"
    "on.source_cd)=\"JDE\")) OR (((comm_transaction.manufact_cd)=\"INENDO\") AND ((co"
    "mm_eps_region_map.EPS_Region)<>\"WEST\") AND ((comm_transaction.salesperson_key_"
    "id)<>\"Internal\") AND ((comm_transaction.source_cd)=\"JDE\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_eps_region_map"
    Name ="comm_configure"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_eps_region_map.EPS_Specialist"
    Expression ="comm_transaction.manufact_cd"
    Expression ="comm_eps_region_map.EPS_Region"
    Expression ="comm_transaction.salesperson_key_id"
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
    RightTable ="comm_configure"
    Expression ="comm_transaction.fiscal_yearmo_num = comm_configure.current_fiscal_yearmo_num"
    Flag =1
End
Begin OrderBy
    Expression ="comm_transaction.manufact_cd"
    Flag =0
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
        dbText "Name" ="comm_eps_region_map.EPS_Specialist"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_eps_region_map.[EPS_Specialist]"
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
End
Begin
    State =0
    Left =-56
    Top =40
    Right =1485
    Bottom =997
    Left =-1
    Top =-1
    Right =1509
    Bottom =256
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
        Left =727
        Top =88
        Right =930
        Bottom =257
        Top =0
        Name ="comm_eps_region_map"
        Name =""
    End
    Begin
        Left =388
        Top =45
        Right =532
        Bottom =189
        Top =0
        Name ="comm_configure"
        Name =""
    End
End
