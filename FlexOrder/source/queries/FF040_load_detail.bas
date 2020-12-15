Operation =3
Name ="flex_order_detail"
Option =0
Begin InputTables
    Name ="Integration_flex_order_lines_Staging"
    Name ="flex_batch_template"
End
Begin OutputColumns
    Name ="ORDERNO"
    Expression ="Integration_flex_order_lines_Staging.ORDERNO"
    Name ="Supplier"
    Expression ="flex_batch_template.Supplier"
    Name ="line_id"
    Expression ="Integration_flex_order_lines_Staging.line_id"
    Name ="status_code"
    Expression ="Integration_flex_order_lines_Staging.status_code"
    Alias ="Expr1"
    Name ="ITEMNO"
    Expression ="CLng([ITEMNO])"
    Name ="QTY"
    Expression ="Integration_flex_order_lines_Staging.QTY"
    Name ="ITEMDESC"
    Expression ="Integration_flex_order_lines_Staging.ITEMDESC"
    Name ="UPC"
    Expression ="Integration_flex_order_lines_Staging.UPC"
    Name ="PRICE"
    Expression ="Integration_flex_order_lines_Staging.PRICE"
    Name ="FREEGDS"
    Expression ="Integration_flex_order_lines_Staging.FREEGDS"
    Name ="PROMOCODE"
    Expression ="Integration_flex_order_lines_Staging.PROMOCODE"
    Name ="PROGRAMCODE"
    Expression ="Integration_flex_order_lines_Staging.PROGRAMCODE"
End
Begin Joins
    LeftTable ="Integration_flex_order_lines_Staging"
    RightTable ="flex_batch_template"
    Expression ="Integration_flex_order_lines_Staging.flex_code = flex_batch_template.flex_code"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ORIGINAL_INVOICE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.order_file_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.flex_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.PROMOCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.line_id"
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
        dbText "Name" ="Integration_flex_order_lines_Staging.REF2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.COMPANY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.FIRSTLAST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ADDRESS1"
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
        dbText "Name" ="Integration_flex_order_lines_Staging.PROGRAMCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_batch_template.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1616
    Bottom =917
    Left =-1
    Top =-1
    Right =1600
    Bottom =484
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =84
        Top =84
        Right =629
        Bottom =403
        Top =0
        Name ="Integration_flex_order_lines_Staging"
        Name =""
    End
    Begin
        Left =823
        Top =103
        Right =967
        Bottom =247
        Top =0
        Name ="flex_batch_template"
        Name =""
    End
End
