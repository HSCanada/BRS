Operation =1
Option =0
Where ="(((BRS_TransactionDW.CalMonth) Between 202101 And 202109) AND ((BRS_Customer.Sal"
    "esDivision)=\"AAD\") AND ((BRS_TransactionDW.FreeGoodsInvoicedInd)=True) AND ((B"
    "RS_Item.SalesCategory)=\"MERCH\") AND ((BRS_Customer.MarketClass_New) In (\"ELIT"
    "E\",\"MIDMKT\",\"INSTIT\")))"
Having ="(((BRS_Customer.VPA)=\"\"))"
Begin InputTables
    Name ="BRS_TransactionDW"
    Name ="BRS_Customer"
    Name ="BRS_Item"
    Name ="zzzItem"
End
Begin OutputColumns
    Expression ="BRS_Customer.VPA"
    Expression ="BRS_Customer.Specialty"
    Expression ="BRS_Item.Supplier"
    Alias ="src"
    Expression ="\"FG\""
    Alias ="SumOfGPAtFileCostAmt"
    Expression ="Sum(BRS_TransactionDW.GPAtFileCostAmt)"
    Alias ="SumOfExtChargebackAmt"
    Expression ="Sum(BRS_TransactionDW.ExtChargebackAmt)"
End
Begin Joins
    LeftTable ="BRS_TransactionDW"
    RightTable ="BRS_Customer"
    Expression ="BRS_TransactionDW.Shipto = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="BRS_TransactionDW"
    RightTable ="BRS_Item"
    Expression ="BRS_TransactionDW.Item = BRS_Item.Item"
    Flag =1
    LeftTable ="BRS_Item"
    RightTable ="zzzItem"
    Expression ="BRS_Item.Supplier = zzzItem.Item"
    Flag =1
End
Begin Groups
    Expression ="BRS_Customer.VPA"
    GroupLevel =0
    Expression ="BRS_Customer.Specialty"
    GroupLevel =0
    Expression ="BRS_Item.Supplier"
    GroupLevel =0
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
dbMemo "OrderBy" ="[qry_sm_model].SumOfExtChargebackAmt DESC"
Begin
    Begin
        dbText "Name" ="SumOfGPAtFileCostAmt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2655"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="SumOfExtChargebackAmt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2790"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="src"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Specialty"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1254
    Bottom =918
    Left =-1
    Top =-1
    Right =1238
    Bottom =639
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =107
        Top =103
        Right =537
        Bottom =468
        Top =0
        Name ="BRS_TransactionDW"
        Name =""
    End
    Begin
        Left =563
        Top =18
        Right =873
        Bottom =229
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =506
        Top =68
        Right =956
        Bottom =612
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =1144
        Top =229
        Right =1288
        Bottom =373
        Top =0
        Name ="zzzItem"
        Name =""
    End
End
