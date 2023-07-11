Operation =1
Option =0
Where ="((([Item Master].[HSI Item#])=\"5832431\"))"
Begin InputTables
    Name ="Item Master"
    Name ="Item Master Export"
End
Begin OutputColumns
    Expression ="[Item Master].[HSI Item#]"
    Alias ="master"
    Expression ="[Item Master].[Cost Prc Brk1]"
    Alias ="export"
    Expression ="[Item Master Export].[Cost Prc Brk1]"
End
Begin Joins
    LeftTable ="Item Master"
    RightTable ="Item Master Export"
    Expression ="[Item Master].[HSI Item#] = [Item Master Export].[HSI Item#]"
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
        dbText "Name" ="[Item Master].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.HSI Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="export"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="master"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Comp Xref Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Item Description"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.NDC Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.InTransit"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Multiple"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Abbr Strength"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.1 Purch =? Prm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Primary UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.1 Sec =? Prm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Units Per Container"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Brand Name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.HSI Item Prefix"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Drug Class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Location Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Abbr Description"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Size"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Purchase UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Vendor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Manuf Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Comp Xref"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Shelf Life Days"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Secondary UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Case Code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Strength"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Case Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Minimum"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sub Major"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Primary Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Major"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.MSRP Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Cost Qty Brk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Tax class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sub Minor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sell Qty Brk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sell Prc Brk1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Stock Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Cost Prc Brk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Branch Plant 1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Retail Set Leader"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.MSDS Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sell Prc Brk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.AutoSubstitute Xref Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Cost Prc Brk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.AM Item Number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Ration Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Minor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.AutoSubstitute Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sell Qty Brk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.MSDS Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Cost Qty Brk1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Substitute Xref Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Buyer#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.STOC4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sell Prc Brk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Import/Domestic"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Substitute Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.MSRP"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Country Of Org"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Currency"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.MSDS Xref Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Cost Qty Brk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Substitute Original Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Wholesale Set Leader"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Auto-Substitute Original Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Stocking Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Cost Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Classification Code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Favorite Cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.GL Class type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Favorite Cost Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Exception Message"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Manufacturer"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.TOC1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Cost Prc Brk1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.BackOrder Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Line Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Check Availability"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Pricing Info"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sell Qty Brk1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Label class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Avail Code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Branch Plant 2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Branch Plant 3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Serial Number Required"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Branch Plant 4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Date -4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Branch Plant 5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Branch Plant 6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Print on Pickticket"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Amt -4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Freightable Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.STOC6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.CE Mark Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Qty -3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Weight UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Employee Uploading Catalog"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Length"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Comment - 256 Characters Max"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Volume UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Error message"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Print Message"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Flag -1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Height"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Kit Pricing Method"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Width"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Weight"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Shipping Commodity Class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Repack"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Hazardous Class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Flag -4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.STOC3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Flag -5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.CPT Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Amt -1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Force Item Notes"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Amt -2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Catalog 1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Amt -3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.TOC2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Amt-5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.STOC1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Text -1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Catalog 2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Text -2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.TOC3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Text -3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.STOC2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Text -5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Catalog 3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Date -1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Catalog 4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Date -2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.TOC5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Date -3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.TOC4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Date -5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Catalog 5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.STOC5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Catalog 6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Text -4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.TOC6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Qty -1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Qty -2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Qty -4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Cost Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Qty -5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Flag -2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Future Use Flag -3"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1473
    Bottom =790
    Left =-1
    Top =-1
    Right =1435
    Bottom =297
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =60
        Top =15
        Right =240
        Bottom =195
        Top =0
        Name ="Item Master"
        Name =""
    End
    Begin
        Left =323
        Top =43
        Right =503
        Bottom =223
        Top =0
        Name ="Item Master Export"
        Name =""
    End
End
