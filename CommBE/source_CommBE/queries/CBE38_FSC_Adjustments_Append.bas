Operation =3
Name ="comm_transaction_stage"
Option =0
Begin InputTables
    Name ="comm_transaction_external_stage"
End
Begin OutputColumns
    Name ="fiscal_yearmo_num"
    Expression ="comm_transaction_external_stage.fiscal_yearmo_num"
    Alias ="division_cd"
    Name ="division_cd"
    Expression ="\"\""
    Name ="salesperson_cd"
    Expression ="comm_transaction_external_stage.salesperson_cd"
    Alias ="source_cd"
    Name ="source_cd"
    Expression ="\"IMPORT\""
    Name ="transaction_dt"
    Expression ="comm_transaction_external_stage.transaction_dt"
    Name ="transaction_amt"
    Expression ="comm_transaction_external_stage.transaction_amt"
    Alias ="comm_cd"
    Name ="comm_cd"
    Expression ="\"Z\""
    Alias ="doc_key_id"
    Name ="doc_key_id"
    Expression ="comm_transaction_external_stage.invoice_id"
    Alias ="line_id"
    Name ="line_id"
    Expression ="comm_transaction_external_stage.line_num"
    Name ="customer_nm"
    Expression ="comm_transaction_external_stage.customer_nm"
    Alias ="shipped_qty"
    Name ="shipped_qty"
    Expression ="1"
    Name ="transaction_txt"
    Expression ="comm_transaction_external_stage.transaction_txt"
    Alias ="cost_ext_amt"
    Name ="cost_ext_amt"
    Expression ="[transaction_amt]-[gp_ext_amt]"
    Name ="comm_group_cd"
    Expression ="comm_transaction_external_stage.comm_group_cd"
    Name ="comm_amt"
    Expression ="comm_transaction_external_stage.comm_amt"
    Name ="salesperson_key_id"
    Expression ="comm_transaction_external_stage.salesperson_key_id"
    Alias ="status_cd"
    Name ="status_cd"
    Expression ="20"
    Name ="gp_ext_amt"
    Expression ="comm_transaction_external_stage.gp_ext_amt"
    Name ="reference_order_txt"
    Expression ="comm_transaction_external_stage.reference_order_txt"
    Name ="hsi_shipto_id"
    Expression ="comm_transaction_external_stage.hsi_shipto_id"
    Name ="doc_id"
    Expression ="comm_transaction_external_stage.invoice_id"
    Name ="order_id"
    Expression ="comm_transaction_external_stage.invoice_id"
    Name ="item_id"
    Expression ="comm_transaction_external_stage.item_id"
    Name ="IMITEM"
    Expression ="comm_transaction_external_stage.item_id"
End
Begin OrderBy
    Expression ="comm_transaction_external_stage.comm_group_cd"
    Flag =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbText "Description" ="Copy Commission revisions import to stage"
Begin
    Begin
        dbText "Name" ="source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="cost_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="status_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.division_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="division_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.transaction_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.transaction_dt"
        dbInteger "ColumnWidth" ="2295"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.invoice_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.reference_order_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1495
    Bottom =991
    Left =-1
    Top =-1
    Right =1463
    Bottom =334
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =38
        Top =6
        Right =395
        Bottom =278
        Top =0
        Name ="comm_transaction_external_stage"
        Name =""
    End
End
