Operation =1
Option =0
Begin InputTables
    Name ="comm_configure-PROD"
    Name ="BRS_Config"
End
Begin OutputColumns
    Expression ="BRS_Config.id"
    Alias ="prod_fiscal"
    Expression ="[comm_configure-PROD].current_fiscal_yearmo_num"
    Alias ="new_fiscal"
    Expression ="BRS_Config.PriorFiscalMonth"
End
Begin Joins
    LeftTable ="BRS_Config"
    RightTable ="comm_configure-PROD"
    Expression ="BRS_Config.id = [comm_configure-PROD].record_id"
    Flag =1
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
        dbText "Name" ="BRS_Config.id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="new_fiscal"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="prod_fiscal"
        dbInteger "ColumnWidth" ="3015"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1412
    Bottom =817
    Left =-1
    Top =-1
    Right =1388
    Bottom =450
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =309
        Top =85
        Right =453
        Bottom =229
        Top =0
        Name ="comm_configure-PROD"
        Name =""
    End
    Begin
        Left =49
        Top =173
        Right =193
        Bottom =317
        Top =0
        Name ="BRS_Config"
        Name =""
    End
End
