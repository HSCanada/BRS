Operation =1
Option =0
Begin InputTables
    Name ="Integration_flex_order_lines_Staging"
End
Begin OutputColumns
    Expression ="Integration_flex_order_lines_Staging.order_file_name"
    Expression ="Integration_flex_order_lines_Staging.line_id"
    Expression ="Integration_flex_order_lines_Staging.ORDERNO"
    Expression ="Integration_flex_order_lines_Staging.ACCOUNT"
    Expression ="Integration_flex_order_lines_Staging.ITEMNO"
    Expression ="Integration_flex_order_lines_Staging.QTY"
    Expression ="Integration_flex_order_lines_Staging.REFERENCE"
    Expression ="Integration_flex_order_lines_Staging.ITEMDESC"
    Expression ="Integration_flex_order_lines_Staging.UPC"
    Expression ="Integration_flex_order_lines_Staging.PRICE"
    Expression ="Integration_flex_order_lines_Staging.FREEGDS"
    Expression ="Integration_flex_order_lines_Staging.Date"
    Expression ="Integration_flex_order_lines_Staging.DUEDATE"
    Expression ="Integration_flex_order_lines_Staging.REF2"
    Expression ="Integration_flex_order_lines_Staging.COMPANY"
    Expression ="Integration_flex_order_lines_Staging.FIRSTLAST"
    Expression ="Integration_flex_order_lines_Staging.ADDRESS1"
    Expression ="Integration_flex_order_lines_Staging.ADDRESS2"
    Expression ="Integration_flex_order_lines_Staging.ADDRESS3"
    Expression ="Integration_flex_order_lines_Staging.CITY"
    Expression ="Integration_flex_order_lines_Staging.ST"
    Expression ="Integration_flex_order_lines_Staging.POSTALCODE"
    Expression ="Integration_flex_order_lines_Staging.PHONE"
    Expression ="Integration_flex_order_lines_Staging.COUNTRY"
    Expression ="Integration_flex_order_lines_Staging.PROMOCODE"
    Expression ="Integration_flex_order_lines_Staging.PROGRAMCODE"
    Expression ="Integration_flex_order_lines_Staging.ORIGINAL_INVOICE"
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
        dbText "Name" ="Integration_flex_order_lines_Staging.REF2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ORIGINAL_INVOICE"
        dbLong "AggregateType" ="-1"
    End
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
        dbText "Name" ="Integration_flex_order_lines_Staging.DUEDATE"
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
End
Begin
    State =0
    Left =0
    Top =0
    Right =1616
    Bottom =918
    Left =-1
    Top =-1
    Right =1600
    Bottom =656
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =95
        Top =109
        Right =616
        Bottom =657
        Top =0
        Name ="Integration_flex_order_lines_Staging"
        Name =""
    End
End
