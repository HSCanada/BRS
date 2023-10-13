Operation =1
Option =0
Having ="(((BRS_CustomerFSC_History.FiscalMonth) In (202212,202302)) AND ((BRS_Customer.S"
    "alesDivision) Not In (\"ALC\",\"AZA\",\"AZE\")))"
Begin InputTables
    Name ="BRS_CustomerFSC_History"
    Name ="BRS_Customer"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="BRS_CustomerFSC_History.FiscalMonth"
    Expression ="BRS_CustomerFSC_History.HIST_TerritoryCd"
    Expression ="BRS_Customer.SalesDivision"
    Expression ="BRS_Customer.MarketClass"
    Alias ="FirstOforder_taken_by"
    Expression ="First(BRS_FSC_Rollup.order_taken_by)"
    Alias ="FirstOfFSCName"
    Expression ="First(BRS_FSC_Rollup.FSCName)"
    Alias ="FirstOfBranch"
    Expression ="First(BRS_FSC_Rollup.Branch)"
    Alias ="CountOfShipto"
    Expression ="Count(BRS_CustomerFSC_History.Shipto)"
    Alias ="SumOfEst12MoMerch"
    Expression ="Sum(BRS_Customer.Est12MoMerch)"
    Expression ="BRS_Customer.AccountType"
End
Begin Joins
    LeftTable ="BRS_CustomerFSC_History"
    RightTable ="BRS_Customer"
    Expression ="BRS_CustomerFSC_History.Shipto = BRS_Customer.ShipTo"
    Flag =1
    LeftTable ="BRS_CustomerFSC_History"
    RightTable ="BRS_FSC_Rollup"
    Expression ="BRS_CustomerFSC_History.HIST_TerritoryCd = BRS_FSC_Rollup.TerritoryCd"
    Flag =1
End
Begin Groups
    Expression ="BRS_CustomerFSC_History.FiscalMonth"
    GroupLevel =0
    Expression ="BRS_CustomerFSC_History.HIST_TerritoryCd"
    GroupLevel =0
    Expression ="BRS_Customer.SalesDivision"
    GroupLevel =0
    Expression ="BRS_Customer.MarketClass"
    GroupLevel =0
    Expression ="BRS_Customer.AccountType"
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
dbMemo "Filter" ="((([GW_FSC_Cust_Cnt].[FiscalMonth]=202212) AND ([GW_FSC_Cust_Cnt].[MarketClass]="
    "\"ELITE \"))) AND ([GW_FSC_Cust_Cnt].[FirstOfBranch]=\"TORNT\")"
dbMemo "OrderBy" ="[GW_FSC_Cust_Cnt].[MarketClass], [GW_FSC_Cust_Cnt].[AccountType] DESC, [GW_FSC_C"
    "ust_Cnt].[SumOfEst12MoMerch] DESC"
Begin
    Begin
        dbText "Name" ="CountOfShipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.HIST_TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfFSCName"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3120"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="FirstOfBranch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.AccountType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOforder_taken_by"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2364"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Customer.MarketClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfEst12MoMerch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_CustomerFSC_History.Shipto"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.order_taken_by"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Est12MoMerch"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =12
    Top =-29
    Right =1495
    Bottom =781
    Left =-1
    Top =-1
    Right =1455
    Bottom =309
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =236
        Top =9
        Right =452
        Bottom =243
        Top =0
        Name ="BRS_CustomerFSC_History"
        Name =""
    End
    Begin
        Left =771
        Top =12
        Right =953
        Bottom =274
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =533
        Top =95
        Right =700
        Bottom =291
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
