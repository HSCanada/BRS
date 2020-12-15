Operation =3
Name ="flex_order_header"
Option =0
Begin InputTables
    Name ="Integration_flex_order_lines_Staging"
    Name ="flex_order_file"
End
Begin OutputColumns
    Name ="ORDERNO"
    Expression ="Integration_flex_order_lines_Staging.ORDERNO"
    Alias ="FirstOfSupplier"
    Name ="Supplier"
    Expression ="First(flex_order_file.Supplier)"
    Alias ="FirstOforder_file_key"
    Name ="order_file_key"
    Expression ="First(flex_order_file.order_file_key)"
    Alias ="FirstOfACCOUNT"
    Name ="ACCOUNT"
    Expression ="First(Integration_flex_order_lines_Staging.ACCOUNT)"
    Alias ="FirstOfREFERENCE"
    Name ="REFERENCE"
    Expression ="First(Integration_flex_order_lines_Staging.REFERENCE)"
End
Begin Joins
    LeftTable ="Integration_flex_order_lines_Staging"
    RightTable ="flex_order_file"
    Expression ="Integration_flex_order_lines_Staging.order_file_name = flex_order_file.order_fil"
        "e_name"
    Flag =1
End
Begin Groups
    Expression ="Integration_flex_order_lines_Staging.ORDERNO"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="flex_order_file.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOforder_file_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_file.order_file_key"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfSupplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ORDERNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfADDRESS3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfCOMPANY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfREFERENCE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ADDRESS3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.COMPANY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.REFERENCE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfADDRESS2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfREF2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfACCOUNT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ADDRESS2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.REF2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ACCOUNT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.CITY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.FIRSTLAST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.DATE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfCITY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfFIRSTLAST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfDATE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ADDRESS1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.DUEDATE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfADDRESS1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfDUEDATE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfORIGINAL_INVOICE"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2835"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="FirstOfST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.POSTALCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfPOSTALCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.PHONE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfPHONE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.COUNTRY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfCOUNTRY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_flex_order_lines_Staging.ORIGINAL_INVOICE"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1433
    Bottom =527
    Left =-1
    Top =-1
    Right =1417
    Bottom =484
    Left =0
    Top =0
    ColumnsShown =655
    Begin
        Left =102
        Top =168
        Right =500
        Bottom =507
        Top =0
        Name ="Integration_flex_order_lines_Staging"
        Name =""
    End
    Begin
        Left =597
        Top =142
        Right =1063
        Bottom =381
        Top =0
        Name ="flex_order_file"
        Name =""
    End
End
