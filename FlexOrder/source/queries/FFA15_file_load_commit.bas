Operation =3
Name ="Integration_flex_order_lines_Staging"
Option =0
Begin InputTables
    Name ="lnkCN-SCHN_LOAD"
End
Begin OutputColumns
    Name ="order_file_name"
    Expression ="[lnkCN-SCHN_LOAD].FILE_NAME"
    Name ="line_id"
    Expression ="[lnkCN-SCHN_LOAD].FILE_LINE"
    Name ="ORDERNO"
    Expression ="[lnkCN-SCHN_LOAD].ORDERNO"
    Name ="REFERENCE"
    Expression ="[lnkCN-SCHN_LOAD].REFERENCE"
    Name ="ITEMNO"
    Expression ="[lnkCN-SCHN_LOAD].ITEMNO"
    Name ="ITEMDESC"
    Expression ="[lnkCN-SCHN_LOAD].ITEMDESC"
    Name ="UPC"
    Expression ="[lnkCN-SCHN_LOAD].UPC"
    Name ="QTY"
    Expression ="[lnkCN-SCHN_LOAD].QTY"
    Name ="PRICE"
    Expression ="[lnkCN-SCHN_LOAD].PRICE"
    Name ="FREEGDS"
    Expression ="[lnkCN-SCHN_LOAD].FREEGDS"
    Name ="DATE_TEXT"
    Expression ="[lnkCN-SCHN_LOAD].DATE"
    Name ="ACCOUNT"
    Expression ="[lnkCN-SCHN_LOAD].ACCOUNT"
    Name ="COMPANY"
    Expression ="[lnkCN-SCHN_LOAD].COMPANY"
    Name ="FIRSTLAST"
    Expression ="[lnkCN-SCHN_LOAD].FIRSTLAST"
    Name ="ADDRESS1"
    Expression ="[lnkCN-SCHN_LOAD].ADDRESS1"
    Name ="ADDRESS2"
    Expression ="[lnkCN-SCHN_LOAD].ADDRESS2"
    Name ="ADDRESS3"
    Expression ="[lnkCN-SCHN_LOAD].ADDRESS3"
    Name ="CITY"
    Expression ="[lnkCN-SCHN_LOAD].CITY"
    Name ="ST"
    Expression ="[lnkCN-SCHN_LOAD].ST"
    Name ="POSTALCODE"
    Expression ="[lnkCN-SCHN_LOAD].POSTALCODE"
    Name ="PHONE"
    Expression ="[lnkCN-SCHN_LOAD].PHONE"
    Name ="COUNTRY"
    Expression ="[lnkCN-SCHN_LOAD].COUNTRY"
    Name ="PROGRAMCODE"
    Expression ="[lnkCN-SCHN_LOAD].PROGRAMCODE"
    Name ="PROMOCODE"
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
dbBoolean "UseTransaction" ="-1"
Begin
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ADDRESS1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.FIRSTLAST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.order_file_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.QTY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ITEMNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ACCOUNT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ORDERNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.REFERENCE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ITEMDESC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.UPC"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2835"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.PRICE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.FREEGDS"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.DATE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.COMPANY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ADDRESS2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ADDRESS3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.CITY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.POSTALCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.PHONE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.COUNTRY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.PROMOCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.PROGRAMCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].REFERENCE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ORDERNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].FILE_LINE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].FILE_NAME"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].COUNTRY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].FIRSTLAST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ITEMNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].PROGRAMCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ADDRESS1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ITEMDESC"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].PROMOCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ADDRESS2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].UPC"
        dbInteger "ColumnWidth" ="2835"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ADDRESS3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].QTY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].CITY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].PRICE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].FREEGDS"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].POSTALCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].ACCOUNT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].PHONE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].COMPANY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[lnkCN-SCHN_LOAD].DATE"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1474
    Bottom =918
    Left =-1
    Top =-1
    Right =1458
    Bottom =233
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =108
        Top =11
        Right =462
        Bottom =231
        Top =0
        Name ="lnkCN-SCHN_LOAD"
        Name =""
    End
End
