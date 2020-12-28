Operation =1
Option =0
Begin InputTables
    Name ="Integration_comm_adjustment_Staging"
End
Begin OutputColumns
    Expression ="Integration_comm_adjustment_Staging.FiscalMonth"
    Expression ="Integration_comm_adjustment_Staging.WSVR01_reference"
    Alias ="CountOfWSOGNO_original_line_number"
    Expression ="Count(Integration_comm_adjustment_Staging.WSOGNO_original_line_number)"
    Alias ="MaxOfWSOGNO_original_line_number"
    Expression ="Max(Integration_comm_adjustment_Staging.WSOGNO_original_line_number)"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(Integration_comm_adjustment_Staging.transaction_amt)"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(Integration_comm_adjustment_Staging.gp_ext_amt)"
    Alias ="SumOfWS$UNC_sales_order_cost_markup"
    Expression ="Sum(Integration_comm_adjustment_Staging.[WS$UNC_sales_order_cost_markup])"
End
Begin Groups
    Expression ="Integration_comm_adjustment_Staging.FiscalMonth"
    GroupLevel =0
    Expression ="Integration_comm_adjustment_Staging.WSVR01_reference"
    GroupLevel =0
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
        dbText "Name" ="Integration_comm_adjustment_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="MaxOfWSOGNO_original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOfWSOGNO_original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2550"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="SumOfgp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfWS$UNC_sales_order_cost_markup"
        dbInteger "ColumnWidth" ="4335"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.WSVR01_reference"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1121
    Bottom =547
    Left =-1
    Top =-1
    Right =1097
    Bottom =344
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =233
        Top =59
        Right =599
        Bottom =310
        Top =0
        Name ="Integration_comm_adjustment_Staging"
        Name =""
    End
End
