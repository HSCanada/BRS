Operation =1
Option =0
Where ="(((comm_transaction_F555115.FiscalMonth)=202101) AND ((comm_transaction_F555115."
    "fsc_salesperson_key_id)=\"CDynes\") AND ((comm_transaction_F555115.fsc_comm_grou"
    "p_cd)=\"DIGMAT\"))"
Begin InputTables
    Name ="comm_transaction_F555115"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115.FiscalMonth"
    Expression ="comm_transaction_F555115.isr_salesperson_key_id"
    Expression ="comm_transaction_F555115.fsc_salesperson_key_id"
    Expression ="comm_transaction_F555115.fsc_code"
    Expression ="comm_transaction_F555115.fsc_comm_plan_id"
    Expression ="comm_transaction_F555115.source_cd"
    Expression ="comm_transaction_F555115.WSDOCO_salesorder_number"
    Expression ="comm_transaction_F555115.WSLNID_line_number"
    Expression ="comm_transaction_F555115.WSOGNO_original_line_number"
    Expression ="comm_transaction_F555115.fsc_comm_group_cd"
    Expression ="comm_transaction_F555115.ess_comm_group_cd"
    Expression ="comm_transaction_F555115.gp_ext_amt"
    Expression ="comm_transaction_F555115.transaction_amt"
    Expression ="comm_transaction_F555115.WSUORG_quantity"
    Expression ="comm_transaction_F555115.WSSRP6_manufacturer"
    Expression ="comm_transaction_F555115.WSDSC1_description"
    Expression ="comm_transaction_F555115.WSDSC2_description_2"
    Expression ="comm_transaction_F555115.WSVR01_reference"
    Expression ="comm_transaction_F555115.WSVR02_reference_2"
    Expression ="comm_transaction_F555115.xfer_key"
    Expression ="comm_transaction_F555115.xfer_fsc_code_org"
    Expression ="comm_transaction_F555115.xfer_ess_code_org"
    Expression ="comm_transaction_F555115.fsc_calc_key"
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
        dbText "Name" ="comm_transaction_F555115.WSVR02_reference_2"
        dbInteger "ColumnWidth" ="2655"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSVR01_reference"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2880"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSSRP6_manufacturer"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDSC2_description_2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDSC1_description"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSLNID_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSOGNO_original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.WSUORG_quantity"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.xfer_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.xfer_ess_code_org"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.xfer_fsc_code_org"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_salesperson_key_id"
        dbInteger "ColumnWidth" ="2700"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.isr_salesperson_key_id"
        dbInteger "ColumnWidth" ="2670"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115.fsc_calc_key"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1524
    Bottom =938
    Left =-1
    Top =-1
    Right =1500
    Bottom =352
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =33
        Top =33
        Right =457
        Bottom =341
        Top =0
        Name ="comm_transaction_F555115"
        Name =""
    End
End
