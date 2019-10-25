Operation =1
Option =0
Begin InputTables
    Name ="comm_transaction"
    Name ="STAGE_TransferDoc"
    Name ="comm_configure"
End
Begin OutputColumns
    Expression ="comm_transaction.transaction_dt"
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.doc_id"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.customer_nm"
    Alias ="UPD_salesperson_cd"
    Expression ="comm_transaction.salesperson_cd"
    Expression ="comm_transaction.salesperson_key_id"
    Alias ="UPD_ess_salesperson_cd"
    Expression ="comm_transaction.ess_salesperson_cd"
    Expression ="comm_transaction.ess_salesperson_key_id"
    Expression ="comm_transaction.source_cd"
    Expression ="comm_transaction.order_source_cd"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.comm_amt"
    Expression ="comm_transaction.item_id"
    Expression ="STAGE_TransferDoc.note_txt"
    Expression ="comm_transaction.item_comm_group_cd"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="STAGE_TransferDoc"
    Expression ="comm_transaction.doc_id = STAGE_TransferDoc.transfer_doc_id_"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_configure"
    Expression ="comm_transaction.fiscal_yearmo_num = comm_configure.current_fiscal_yearmo_num"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="Update Fiscal period"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CBE61_Transaction_Transfer].[UPD_ess_salesperson_cd] DESC"
Begin
    Begin
        dbText "Name" ="comm_transaction.transaction_dt"
        dbInteger "ColumnWidth" ="1410"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbInteger "ColumnWidth" ="1860"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbInteger "ColumnWidth" ="2520"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.customer_nm"
        dbInteger "ColumnWidth" ="2790"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3675"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1995"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="UPD_salesperson_cd"
        dbInteger "ColumnWidth" ="2565"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="UPD_ess_salesperson_cd"
        dbInteger "ColumnWidth" ="3045"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_TransferDoc.note_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2670"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbInteger "ColumnWidth" ="1560"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_amt"
        dbInteger "ColumnWidth" ="1545"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1534
    Bottom =865
    Left =-1
    Top =-1
    Right =1484
    Bottom =319
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =239
        Bottom =289
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =566
        Top =174
        Right =710
        Bottom =318
        Top =0
        Name ="STAGE_TransferDoc"
        Name =""
    End
    Begin
        Left =386
        Top =22
        Right =530
        Bottom =166
        Top =0
        Name ="comm_configure"
        Name =""
    End
End
