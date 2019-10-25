Operation =1
Option =0
Begin InputTables
    Name ="STAGE_salesperson_master"
End
Begin OutputColumns
    Expression ="STAGE_salesperson_master.salesperson_cd"
    Expression ="STAGE_salesperson_master.salesperson_nm"
    Alias ="FIX_salesperson_key_id"
    Expression ="STAGE_salesperson_master.salesperson_key_id"
    Alias ="FIX_email_address_nm"
    Expression ="STAGE_salesperson_master.email_address_nm"
    Alias ="FIX_salesperson_category_cd"
    Expression ="STAGE_salesperson_master.salesperson_category_cd"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CBE10_STAGE_salesperson_Update].[salesperson_nm]"
Begin
    Begin
        dbText "Name" ="STAGE_salesperson_master.salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1980"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="STAGE_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4170"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="FIX_salesperson_key_id"
        dbInteger "ColumnWidth" ="4050"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FIX_email_address_nm"
        dbInteger "ColumnWidth" ="3495"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FIX_salesperson_category_cd"
        dbInteger "ColumnWidth" ="5820"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-111
    Top =19
    Right =1458
    Bottom =967
    Left =-1
    Top =-1
    Right =1537
    Bottom =195
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =61
        Top =28
        Right =530
        Bottom =307
        Top =0
        Name ="STAGE_salesperson_master"
        Name =""
    End
End
