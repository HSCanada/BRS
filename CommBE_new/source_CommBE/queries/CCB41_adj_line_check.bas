Operation =1
Option =0
Begin InputTables
    Name ="Integration_comm_adjustment_Staging"
End
Begin OutputColumns
    Expression ="Integration_comm_adjustment_Staging.FiscalMonth"
    Alias ="MaxOfWSOGNO_original_line_number"
    Expression ="Max(Integration_comm_adjustment_Staging.WSOGNO_original_line_number)"
    Alias ="CountOfWSOGNO_original_line_number"
    Expression ="Count(Integration_comm_adjustment_Staging.WSOGNO_original_line_number)"
    Alias ="ZeroCheck"
    Expression ="Max([WSOGNO_original_line_number])-Count([WSOGNO_original_line_number])"
End
Begin Groups
    Expression ="Integration_comm_adjustment_Staging.FiscalMonth"
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
        dbText "Name" ="MaxOfWSOGNO_original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ZeroCheck"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOfWSOGNO_original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_adjustment_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1407
    Bottom =937
    Left =-1
    Top =-1
    Right =1383
    Bottom =583
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =76
        Top =129
        Right =299
        Bottom =273
        Top =0
        Name ="Integration_comm_adjustment_Staging"
        Name =""
    End
End
