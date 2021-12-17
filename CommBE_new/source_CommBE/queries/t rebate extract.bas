Operation =1
Option =0
Where ="(((comm_customer_rebate.FiscalMonth) Between 202101 And 202109) AND ((BRS_Custom"
    "er.BillTo) In (1668708,1663135)))"
Begin InputTables
    Name ="comm_customer_rebate"
    Name ="BRS_Customer"
End
Begin OutputColumns
    Expression ="comm_customer_rebate.FiscalMonth"
    Expression ="comm_customer_rebate.ShipTo"
    Expression ="BRS_Customer.BillTo"
    Expression ="comm_customer_rebate.original_line_number"
    Expression ="comm_customer_rebate.SourceCode"
    Expression ="comm_customer_rebate.PracticeName"
    Expression ="comm_customer_rebate.rebate_amt"
    Expression ="comm_customer_rebate.ID"
    Expression ="comm_customer_rebate.comm_note_txt"
    Expression ="comm_customer_rebate.fsc_salesperson_key_id"
    Expression ="comm_customer_rebate.fsc_comm_group_cd"
    Expression ="comm_customer_rebate.fsc_code"
    Expression ="comm_customer_rebate.status_code"
    Expression ="comm_customer_rebate.teeth_share_rt"
End
Begin Joins
    LeftTable ="comm_customer_rebate"
    RightTable ="BRS_Customer"
    Expression ="comm_customer_rebate.ShipTo = BRS_Customer.ShipTo"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query1].[FiscalMonth]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_customer_rebate.rebate_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.comm_note_txt"
        dbInteger "ColumnWidth" ="4920"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfrebate_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.teeth_share_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.PracticeName"
        dbInteger "ColumnWidth" ="2820"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.isr_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.isr_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.isr_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.BillTo"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1628
    Bottom =946
    Left =-1
    Top =-1
    Right =1334
    Bottom =618
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =54
        Top =47
        Right =279
        Bottom =396
        Top =0
        Name ="comm_customer_rebate"
        Name =""
    End
    Begin
        Left =416
        Top =59
        Right =560
        Bottom =203
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
