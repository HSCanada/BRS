Operation =1
Option =0
Having ="(((BRS_Customer.MarketClass)=\"elite\" Or (BRS_Customer.MarketClass)=\"instit\" "
    "Or (BRS_Customer.MarketClass)=\"midmkt\") AND ((BRS_Transaction.FiscalMonth)=201"
    "706) AND ((BRS_Transaction.SalesDate)=#6/22/2017#))"
Begin InputTables
    Name ="BRS_Transaction"
    Name ="BRS_Customer"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_Transaction.Branch"
    Expression ="BRS_Transaction.GLBU_Class"
    Expression ="BRS_Transaction.Shipto"
    Expression ="BRS_Customer.MarketClass"
    Expression ="BRS_Transaction.FiscalMonth"
    Expression ="BRS_Transaction.SalesDate"
    Alias ="SumOfNetSalesAmt"
    Expression ="Sum(BRS_Transaction.NetSalesAmt)"
    Alias ="SumOfExtendedCostAmt"
    Expression ="Sum(BRS_Transaction.ExtendedCostAmt)"
    Expression ="BRS_Transaction.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.Label"
    Expression ="BRS_Item.SalesCategory"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_Item.SubMajorProdClass"
End
Begin Joins
    LeftTable ="BRS_Transaction"
    RightTable ="BRS_Customer"
    Expression ="BRS_Transaction.Shipto = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="BRS_Transaction"
    RightTable ="BRS_Item"
    Expression ="BRS_Transaction.Item = BRS_Item.Item"
    Flag =1
End
Begin Groups
    Expression ="BRS_Transaction.Branch"
    GroupLevel =0
    Expression ="BRS_Transaction.GLBU_Class"
    GroupLevel =0
    Expression ="BRS_Transaction.Shipto"
    GroupLevel =0
    Expression ="BRS_Customer.MarketClass"
    GroupLevel =0
    Expression ="BRS_Transaction.FiscalMonth"
    GroupLevel =0
    Expression ="BRS_Transaction.SalesDate"
    GroupLevel =0
    Expression ="BRS_Transaction.Item"
    GroupLevel =0
    Expression ="BRS_Item.ItemDescription"
    GroupLevel =0
    Expression ="BRS_Item.Supplier"
    GroupLevel =0
    Expression ="BRS_Item.Label"
    GroupLevel =0
    Expression ="BRS_Item.SalesCategory"
    GroupLevel =0
    Expression ="BRS_Item.MajorProductClass"
    GroupLevel =0
    Expression ="BRS_Item.SubMajorProdClass"
    GroupLevel =0
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
        dbText "Name" ="BRS_Transaction.GLBU_Class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Transaction.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfExtendedCostAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Label"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Transaction.Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.MarketClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfNetSalesAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Transaction.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SubMajorProdClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Transaction.SalesDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Transaction.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1449
    Bottom =799
    Left =-1
    Top =-1
    Right =1411
    Bottom =407
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =60
        Top =15
        Right =447
        Bottom =350
        Top =0
        Name ="BRS_Transaction"
        Name =""
    End
    Begin
        Left =507
        Top =15
        Right =833
        Bottom =408
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =893
        Top =15
        Right =1164
        Bottom =218
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
