Operation =1
Option =0
Where ="(((comm_transfer_rule.FiscalMonth)=(SELECT [PriorFiscalMonth] FROM [comm_config]"
    ")))"
Begin InputTables
    Name ="comm_transfer_rule"
End
Begin OutputColumns
    Expression ="comm_transfer_rule.FiscalMonth"
    Expression ="comm_transfer_rule.SalesOrderNumber"
    Expression ="comm_transfer_rule.DocType"
    Expression ="comm_transfer_rule.fsc_code"
    Expression ="comm_transfer_rule.ess_code"
    Expression ="comm_transfer_rule.xfer_key"
    Expression ="comm_transfer_rule.xfer_type"
    Expression ="comm_transfer_rule.new_fsc_code"
    Expression ="comm_transfer_rule.new_ess_code"
    Expression ="comm_transfer_rule.xfer_date"
    Expression ="comm_transfer_rule.ShipTo"
    Expression ="comm_transfer_rule.xfer_branch_ind"
    Expression ="comm_transfer_rule.comment"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="Update Fiscal period"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_transfer_rule.comment"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4095"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transfer_rule.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transfer_rule.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2205"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transfer_rule.DocType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transfer_rule.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transfer_rule.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transfer_rule.xfer_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transfer_rule.xfer_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transfer_rule.new_fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transfer_rule.new_ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transfer_rule.xfer_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transfer_rule.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transfer_rule.xfer_branch_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_dt"
        dbInteger "ColumnWidth" ="1410"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbInteger "ColumnWidth" ="1995"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_amt"
        dbInteger "ColumnWidth" ="1545"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_key_id"
        dbInteger "ColumnWidth" ="3675"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="UPD_ess_salesperson_cd"
        dbInteger "ColumnWidth" ="3045"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.customer_nm"
        dbInteger "ColumnWidth" ="2790"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbInteger "ColumnWidth" ="1560"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
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
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_TransferDoc.note_txt"
        dbInteger "ColumnWidth" ="2670"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbInteger "ColumnWidth" ="2520"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="UPD_salesperson_cd"
        dbInteger "ColumnWidth" ="2565"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbInteger "ColumnWidth" ="1860"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1438
    Bottom =825
    Left =-1
    Top =-1
    Right =1167
    Bottom =237
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =68
        Top =39
        Right =375
        Bottom =272
        Top =0
        Name ="comm_transfer_rule"
        Name =""
    End
End
