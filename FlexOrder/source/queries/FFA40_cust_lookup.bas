Operation =1
Option =0
Where ="((([ShipTo] & [BillTo] & [MailingName] & [AddressLine1] & [AddressLine3] & [Addr"
    "essLine4] & [PhoneNo] & [PostalCode] & [CustGrpWrk] & [VPA]) Like \"*\" & [Enter"
    " Search] & \"*\"))"
Begin InputTables
    Name ="BRS_Customer"
    Name ="BRS_FSC_Rollup"
End
Begin OutputColumns
    Expression ="BRS_Customer.ShipTo"
    Expression ="BRS_Customer.DSO_ParentShipTo"
    Expression ="BRS_Customer.Est12MoMerch"
    Expression ="BRS_Customer.Est12MoTotal"
    Expression ="BRS_Customer.CustGrpWrk"
    Expression ="BRS_Customer.CustGrpWrkNote"
    Expression ="BRS_Customer.CustGrpWrkLastReviewDate"
    Expression ="BRS_Customer.Specialty"
    Expression ="BRS_Customer.SegCd"
    Expression ="BRS_Customer.MarketClass"
    Expression ="BRS_Customer.VPA"
    Expression ="BRS_Customer.PracticeName"
    Expression ="BRS_Customer.PostalCode"
    Expression ="BRS_Customer.PhoneNo"
    Expression ="BRS_Customer.MailingName"
    Expression ="BRS_Customer.AddressLine1"
    Expression ="BRS_Customer.City"
    Expression ="BRS_Customer.Province"
    Expression ="BRS_Customer.AddressLine3"
    Expression ="BRS_Customer.AddressLine4"
    Expression ="BRS_Customer.AccountType"
    Expression ="BRS_Customer.TerritoryCd"
    Expression ="BRS_Customer.DSO_TrackingCd"
    Expression ="BRS_FSC_Rollup.FSCName"
    Expression ="BRS_Customer.SalesDivision"
    Expression ="BRS_Customer.DateAccountOpened"
    Expression ="BRS_Customer.TsTerritoryCd"
    Expression ="BRS_FSC_Rollup.Branch"
End
Begin Joins
    LeftTable ="BRS_Customer"
    RightTable ="BRS_FSC_Rollup"
    Expression ="BRS_Customer.TerritoryCd = BRS_FSC_Rollup.TerritoryCd"
    Flag =1
End
Begin OrderBy
    Expression ="BRS_Customer.PostalCode"
    Flag =0
    Expression ="BRS_Customer.PhoneNo"
    Flag =0
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
        dbText "Name" ="BRS_Customer.City"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.DSO_ParentShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Est12MoTotal"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.DateAccountOpened"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Est12MoMerch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.CustGrpWrkLastReviewDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.CustGrpWrkNote"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.CustGrpWrk"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Specialty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.SegCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.MarketClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PracticeName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PostalCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.PhoneNo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.MailingName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.AddressLine1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.Province"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.AddressLine3"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1830"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Customer.AddressLine4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.AccountType"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.DSO_TrackingCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.TsTerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
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
    Bottom =639
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =240
        Top =12
        Right =384
        Bottom =156
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
End
