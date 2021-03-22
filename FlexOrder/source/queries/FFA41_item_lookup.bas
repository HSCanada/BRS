Operation =1
Option =0
Where ="(((BRS_Item.Supplier)=\"PROCGA\") AND (([ItemDescription] & [ManufPartNumber] & "
    "[Item]) Like \"*\" & [item lookup] & \"*\"))"
Begin InputTables
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.ManufPartNumber"
    Expression ="BRS_Item.ItemCreationDate"
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
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3330"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ManufPartNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemCreationDate"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1672
    Bottom =918
    Left =-1
    Top =-1
    Right =1386
    Bottom =511
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =42
        Top =44
        Right =268
        Bottom =319
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
