Operation =1
Option =0
Where ="(((BRS_Customer.SalesDivision)=\"aad\") AND ((BRS_Customer.Est12MoTotal)>=10000)"
    ")"
Begin InputTables
    Name ="BRS_Customer"
End
Begin OutputColumns
    Expression ="BRS_Customer.BillTo"
    Expression ="BRS_Customer.SalesDivision"
    Expression ="BRS_Customer.Est12MoTotal"
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
        dbText "Name" ="BRS_Customer.Est12MoTotal"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.BillTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1462
    Bottom =976
    Left =-1
    Top =-1
    Right =1444
    Bottom =660
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =425
        Bottom =435
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
