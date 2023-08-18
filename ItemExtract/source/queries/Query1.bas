Operation =1
Option =0
Begin InputTables
    Name ="Item Master Export"
End
Begin OutputColumns
    Expression ="[Item Master Export].[Sell Prc Brk1]"
    Alias ="CountOfID"
    Expression ="Count([Item Master Export].ID)"
End
Begin Groups
    Expression ="[Item Master Export].[Sell Prc Brk1]"
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
        dbText "Name" ="Item Master Export.InTransit"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Primary Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.1 Sec =? Prm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOfID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Vendor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Force Item Notes"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.HSI Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Comp Xref Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Comp Xref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Label class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Sell Qty Brk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Case Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Comp Xref Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Shipping Commodity Class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.HSI Item Prefix"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Retail Set Leader"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Error message"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Item Description"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Favorite Cost Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Buyer#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Strength"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Abbr Description"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Abbr Strength"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Shelf Life Days"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Location Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Cost Qty Brk1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Drug Class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.NDC Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Tax class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Manuf Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Date -4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Size"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.MSRP Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Primary UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.MSRP"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Minor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Major"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Secondary UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Purchase UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.1 Purch =? Prm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Case Code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Sell Prc Brk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.STOC6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Manufacturer"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.CE Mark Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Units Per Container"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Minimum"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Sell Prc Brk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Cost Qty Brk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Multiple"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Sub Major"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Sub Minor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Brand Name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Weight"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Currency"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Wholesale Set Leader"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Freightable Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Favorite Cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Stock Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Cost Prc Brk1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Line Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Cost Qty Brk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Cost Prc Brk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Cost Prc Brk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Sell Qty Brk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Sell Qty Brk1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Sell Prc Brk1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Classification Code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.GL Class type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Avail Code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Ration Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Exception Message"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Country Of Org"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Branch Plant 1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Text -3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Branch Plant 2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Branch Plant 3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Branch Plant 4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Branch Plant 5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Branch Plant 6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Stocking Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Pricing Info"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.MSDS Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.TOC2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.MSDS Xref Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.MSDS Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Substitute Xref Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Substitute Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Substitute Original Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.AutoSubstitute Xref Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.AutoSubstitute Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Auto-Substitute Original Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.AM Item Number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Import/Domestic"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.BackOrder Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Check Availability"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Serial Number Required"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Print on Pickticket"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Weight UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.TOC4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Volume UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Height"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Width"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Qty -2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Length"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Hazardous Class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.CPT Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Repack"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Print Message"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Kit Pricing Method"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Catalog 1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.TOC1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.STOC1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Catalog 2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.STOC2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Catalog 3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.TOC3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.STOC3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Catalog 4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.STOC4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Catalog 5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.TOC5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.STOC5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Catalog 6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.TOC6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Employee Uploading Catalog"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Comment - 256 Characters Max"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Qty -1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Qty -3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Qty -4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Qty -5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Flag -1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Flag -2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Flag -3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Flag -4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Flag -5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Amt -1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Amt -2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Amt -3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Amt -4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Amt-5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Text -1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Text -2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Text -4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Text -5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Date -1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Date -2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Date -3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master Export.Future Use Date -5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.CorporatePrice"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1461
    Bottom =832
    Left =-1
    Top =-1
    Right =1437
    Bottom =512
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =61
        Top =38
        Right =396
        Bottom =344
        Top =0
        Name ="Item Master Export"
        Name =""
    End
End
