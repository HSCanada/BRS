Operation =1
Option =0
Begin InputTables
    Name ="lnkCN-SCHN_LOAD"
End
Begin OutputColumns
    Expression ="[lnkCN-SCHN_LOAD].FILE_NAME"
    Expression ="[lnkCN-SCHN_LOAD].FILE_LINE"
    Expression ="[lnkCN-SCHN_LOAD].ORDERNO"
    Expression ="[lnkCN-SCHN_LOAD].REFERENCE"
    Expression ="[lnkCN-SCHN_LOAD].ITEMNO"
    Expression ="[lnkCN-SCHN_LOAD].ITEMDESC"
    Expression ="[lnkCN-SCHN_LOAD].UPC"
    Expression ="[lnkCN-SCHN_LOAD].QTY"
    Expression ="[lnkCN-SCHN_LOAD].PRICE"
    Expression ="[lnkCN-SCHN_LOAD].FREEGDS"
    Expression ="[lnkCN-SCHN_LOAD].Date"
    Expression ="[lnkCN-SCHN_LOAD].ACCOUNT"
    Expression ="[lnkCN-SCHN_LOAD].COMPANY"
    Expression ="[lnkCN-SCHN_LOAD].FIRSTLAST"
    Expression ="[lnkCN-SCHN_LOAD].ADDRESS1"
    Expression ="[lnkCN-SCHN_LOAD].ADDRESS2"
    Expression ="[lnkCN-SCHN_LOAD].ADDRESS3"
    Expression ="[lnkCN-SCHN_LOAD].CITY"
    Expression ="[lnkCN-SCHN_LOAD].ST"
    Expression ="[lnkCN-SCHN_LOAD].POSTALCODE"
    Expression ="[lnkCN-SCHN_LOAD].PHONE"
    Expression ="[lnkCN-SCHN_LOAD].COUNTRY"
    Expression ="[lnkCN-SCHN_LOAD].PROGRAMCODE"
    Expression ="[lnkCN-SCHN_LOAD].PROMOCODE"
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
        dbText "Name" ="[lnkCN-SCHN_LOAD].ADDRESS3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ADDRESS2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].PROMOCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].FREEGDS"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].FILE_NAME"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4380"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].FILE_LINE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ORDERNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].REFERENCE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ITEMNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ITEMDESC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].UPC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].QTY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].PRICE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].DATE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ACCOUNT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].COMPANY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].FIRSTLAST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ADDRESS1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].CITY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].POSTALCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].PHONE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].COUNTRY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].PROGRAMCODE"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1215
    Bottom =565
    Left =-1
    Top =-1
    Right =1199
    Bottom =429
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =76
        Top =43
        Right =220
        Bottom =187
        Top =0
        Name ="lnkCN-SCHN_LOAD"
        Name =""
    End
End
