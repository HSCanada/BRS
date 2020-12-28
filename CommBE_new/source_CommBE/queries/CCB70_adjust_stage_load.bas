Operation =1
Option =0
Begin InputTables
    Name ="Integration_comm_adjustment_Staging"
End
Begin OutputColumns
    Expression ="Integration_comm_adjustment_Staging.FiscalMonth"
    Alias ="Owner"
    Expression ="Integration_comm_adjustment_Staging.WSVR01_reference"
    Expression ="Integration_comm_adjustment_Staging.WSOGNO_original_line_number"
    Expression ="Integration_comm_adjustment_Staging.fsc_code"
    Expression ="Integration_comm_adjustment_Staging.ess_code"
    Alias ="Shipto"
    Expression ="Integration_comm_adjustment_Staging.WSSHAN_shipto"
    Alias ="customer_nm"
    Expression ="Integration_comm_adjustment_Staging.WSVR02_reference_2"
    Alias ="Sales order"
    Expression ="Integration_comm_adjustment_Staging.WSDOC__document_number"
    Alias ="item_id"
    Expression ="Integration_comm_adjustment_Staging.WSLITM_item_number"
    Alias ="Additional_Notes"
    Expression ="Integration_comm_adjustment_Staging.WSDSC1_description"
    Expression ="Integration_comm_adjustment_Staging.transaction_amt"
    Alias ="Adj Type Actual"
    Expression ="Integration_comm_adjustment_Staging.WSSRP6_manufacturer"
    Expression ="Integration_comm_adjustment_Staging.fsc_comm_group_cd"
    Expression ="Integration_comm_adjustment_Staging.gp_code"
    Expression ="Integration_comm_adjustment_Staging.gp_ext_amt"
    Alias ="File_TAG_COST_ADJ"
    Expression ="Integration_comm_adjustment_Staging.[WS$UNC_sales_order_cost_markup]"
    Expression ="Integration_comm_adjustment_Staging.WSDCTO_order_type"
    Expression ="Integration_comm_adjustment_Staging.status_code"
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
        dbText "Name" ="Integration_comm_adjustment_Staging.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2310"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSOGNO_original_line_number"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3420"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSDCTO_order_type"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2370"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Owner"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Sales order"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Adj Type Actual"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.transaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1920"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Additional_Notes"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2055"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="File_TAG_COST_ADJ"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2280"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.gp_code"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1391
    Bottom =937
    Left =-1
    Top =-1
    Right =1367
    Bottom =294
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =114
        Top =42
        Right =429
        Bottom =278
        Top =0
        Name ="Integration_comm_adjustment_Staging"
        Name =""
    End
End
