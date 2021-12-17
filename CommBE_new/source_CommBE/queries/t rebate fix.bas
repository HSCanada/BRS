Operation =1
Option =0
Begin InputTables
    Name ="zzzShipto"
    Name ="BRS_Customer"
End
Begin OutputColumns
    Expression ="zzzShipto.ST"
    Expression ="BRS_Customer.TerritoryCd"
    Expression ="BRS_Customer.PracticeName"
End
Begin Joins
    LeftTable ="zzzShipto"
    RightTable ="BRS_Customer"
    Expression ="zzzShipto.ST = BRS_Customer.ShipTo"
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
        dbText "Name" ="zzzShipto.ST"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =234
    Top =80
    Right =1794
    Bottom =978
    Left =-1
    Top =-1
    Right =1536
    Bottom =618
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =47
        Top =41
        Right =376
        Bottom =318
        Top =0
        Name ="zzzShipto"
        Name =""
    End
    Begin
        Left =446
        Top =80
        Right =662
        Bottom =387
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
End
