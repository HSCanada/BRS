Operation =1
Option =0
Where ="(((BRS_Transaction.TerritoryCd)=\"\")) OR (((BRS_Transaction.GLBU_Class)=\"\")) "
    "OR (((BRS_Transaction.Branch)<>[BRS_FSC_Rollup]![Branch]) AND ((BRS_Transaction."
    "DocType)<>\"AA\")) OR (((BRS_FSC_Rollup.Branch)=\"\"))"
Begin InputTables
    Name ="BRS_Transaction"
    Name ="BRS_Customer"
    Name ="BRS_FSC_Rollup"
    Name ="BRS_Config"
End
Begin OutputColumns
    Expression ="BRS_Transaction.FiscalMonth"
    Expression ="BRS_Transaction.SalesOrderNumberKEY"
    Expression ="BRS_Transaction.Shipto"
    Expression ="BRS_Customer.PracticeName"
    Expression ="BRS_Transaction.SalesDivision"
    Expression ="BRS_Customer.PostalCode"
    Alias ="TerritoryCd_NEW"
    Expression ="BRS_Customer.TerritoryCd"
    Alias ="TerritoryCd_OLD"
    Expression ="BRS_Transaction.TerritoryCd"
    Alias ="Branch_NEW"
    Expression ="BRS_FSC_Rollup.Branch"
    Alias ="Branch_OLD"
    Expression ="BRS_Transaction.Branch"
    Expression ="BRS_Transaction.GLBU_Class"
    Expression ="BRS_Transaction.GL_BusinessUnit"
    Expression ="BRS_Transaction.SalesDate"
    Expression ="BRS_Transaction.NetSalesAmt"
End
Begin Joins
    LeftTable ="BRS_Transaction"
    RightTable ="BRS_Customer"
    Expression ="BRS_Transaction.Shipto = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="BRS_Customer"
    RightTable ="BRS_FSC_Rollup"
    Expression ="BRS_Customer.TerritoryCd = BRS_FSC_Rollup.TerritoryCd"
    Flag =1
    LeftTable ="BRS_Transaction"
    RightTable ="BRS_Config"
    Expression ="BRS_Transaction.FiscalMonth = BRS_Config.FiscalMonth"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_Transaction.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Transaction.SalesOrderNumberKEY"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Transaction.SalesDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Transaction.Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Transaction.NetSalesAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Transaction.GLBU_Class"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1500"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="TerritoryCd_NEW"
        dbInteger "ColumnWidth" ="2025"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Branch_NEW"
        dbInteger "ColumnWidth" ="1560"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PracticeName"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2040"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Customer.PostalCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Branch_OLD"
        dbInteger "ColumnWidth" ="1530"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="TerritoryCd_OLD"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Transaction.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Transaction.GL_BusinessUnit"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-9
    Top =-36
    Right =1646
    Bottom =803
    Left =-1
    Top =-1
    Right =1127
    Bottom =394
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =463
        Bottom =449
        Top =0
        Name ="BRS_Transaction"
        Name =""
    End
    Begin
        Left =597
        Top =214
        Right =996
        Bottom =495
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =1153
        Top =88
        Right =1297
        Bottom =232
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =598
        Top =-2
        Right =742
        Bottom =142
        Top =0
        Name ="BRS_Config"
        Name =""
    End
End
