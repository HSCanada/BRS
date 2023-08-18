Operation =1
Option =0
Where ="((([Item Master].[Comp Xref])=\"81\") AND (([Item Master].[Wholesale Set Leader]"
    ")=[HSI Item#]))"
Begin InputTables
    Name ="Item Master"
End
Begin OutputColumns
    Expression ="[Item Master].ID"
    Expression ="[Item Master].[Comp Xref]"
    Expression ="[Item Master].[Comp Xref Item#]"
    Expression ="[Item Master].[HSI Item#]"
    Expression ="[Item Master].[HSI Item Prefix]"
    Expression ="[Item Master].[Item Description]"
    Expression ="[Item Master].Strength"
    Expression ="[Item Master].[Abbr Description]"
    Expression ="[Item Master].[Abbr Strength]"
    Expression ="[Item Master].[Shelf Life Days]"
    Expression ="[Item Master].[Location Type]"
    Expression ="[Item Master].InTransit"
    Expression ="[Item Master].[Drug Class]"
    Expression ="[Item Master].[NDC Item#]"
    Expression ="[Item Master].[Manuf Item#]"
    Expression ="[Item Master].Size"
    Expression ="[Item Master].[Primary UOM]"
    Expression ="[Item Master].[Secondary UOM]"
    Expression ="[Item Master].[Purchase UOM]"
    Expression ="[Item Master].[1 Sec =? Prm]"
    Expression ="[Item Master].[1 Purch =? Prm]"
    Expression ="[Item Master].[Case Code]"
    Expression ="[Item Master].[Case Qty]"
    Expression ="[Item Master].[Units Per Container]"
    Expression ="[Item Master].Minimum"
    Expression ="[Item Master].Multiple"
    Expression ="[Item Master].Major"
    Expression ="[Item Master].[Sub Major]"
    Expression ="[Item Master].Minor"
    Expression ="[Item Master].[Sub Minor]"
    Expression ="[Item Master].[Tax class]"
    Expression ="[Item Master].[Label class]"
    Expression ="[Item Master].Manufacturer"
    Expression ="[Item Master].[Brand Name]"
    Expression ="[Item Master].Vendor"
    Expression ="[Item Master].[Primary Supplier]"
    Expression ="[Item Master].[Buyer#]"
    Expression ="[Item Master].Currency"
    Expression ="[Item Master].[Wholesale Set Leader]"
    Expression ="[Item Master].[Retail Set Leader]"
    Expression ="[Item Master].[Favorite Cost Qty]"
    Expression ="[Item Master].[Favorite Cost]"
    Alias ="Cost Qty Brk1_"
    Expression ="Nz([Cost Qty Brk1],0)"
    Alias ="Cost Prc Brk1_"
    Expression ="Nz([Cost Prc Brk1],0)"
    Alias ="Cost Qty Brk2_"
    Expression ="Nz([Cost Qty Brk2],0)"
    Alias ="Cost Prc Brk2_"
    Expression ="Nz([Cost Prc Brk2],0)"
    Alias ="Cost Qty Brk3_"
    Expression ="Nz([Cost Qty Brk3],0)"
    Alias ="Cost Prc Brk3_"
    Expression ="Nz([Cost Prc Brk3],0)"
    Expression ="[Item Master].[MSRP Qty]"
    Expression ="[Item Master].MSRP"
    Alias ="Sell Qty Brk1_"
    Expression ="Nz([Sell Qty Brk1],0)"
    Alias ="Sell Prc Brk1_"
    Expression ="Nz([Sell Prc Brk1],0)"
    Alias ="Sell Qty Brk2_"
    Expression ="Nz([Sell Qty Brk2],0)"
    Alias ="Sell Prc Brk2_"
    Expression ="Nz([Sell Prc Brk2],0)"
    Alias ="Sell Qty Brk3_"
    Expression ="Nz([Sell Qty Brk3],0)"
    Alias ="Sell Prc Brk3_"
    Expression ="Nz([Sell Prc Brk3],0)"
    Expression ="[Item Master].[Classification Code]"
    Expression ="[Item Master].[Line Type]"
    Expression ="[Item Master].[Stock Type]"
    Expression ="[Item Master].[GL Class type]"
    Expression ="[Item Master].[Avail Code]"
    Expression ="[Item Master].[Ration Qty]"
    Expression ="[Item Master].[Country Of Org]"
    Expression ="[Item Master].[Branch Plant 1]"
    Expression ="[Item Master].[Branch Plant 2]"
    Expression ="[Item Master].[Branch Plant 3]"
    Expression ="[Item Master].[Branch Plant 4]"
    Expression ="[Item Master].[Branch Plant 5]"
    Expression ="[Item Master].[Branch Plant 6]"
    Expression ="[Item Master].[Stocking Flag]"
    Expression ="[Item Master].[Pricing Info]"
    Expression ="[Item Master].[MSDS Flag]"
    Expression ="[Item Master].[MSDS Xref Type]"
    Expression ="[Item Master].[MSDS Item#]"
    Expression ="[Item Master].[Substitute Xref Type]"
    Expression ="[Item Master].[Substitute Item#]"
    Expression ="[Item Master].[Substitute Original Item#]"
    Expression ="[Item Master].[AutoSubstitute Xref Type]"
    Expression ="[Item Master].[AutoSubstitute Item#]"
    Expression ="[Item Master].[Auto-Substitute Original Item#]"
    Expression ="[Item Master].[AM Item Number]"
    Expression ="[Item Master].[Import/Domestic]"
    Expression ="[Item Master].[BackOrder Flag]"
    Expression ="[Item Master].[Check Availability]"
    Expression ="[Item Master].[Serial Number Required]"
    Expression ="[Item Master].[Print on Pickticket]"
    Expression ="[Item Master].[Freightable Item]"
    Expression ="[Item Master].[Weight UOM]"
    Expression ="[Item Master].[Volume UOM]"
    Expression ="[Item Master].Height"
    Expression ="[Item Master].Width"
    Expression ="[Item Master].Length"
    Expression ="[Item Master].Weight"
    Expression ="[Item Master].[Shipping Commodity Class]"
    Expression ="[Item Master].[Hazardous Class]"
    Expression ="[Item Master].[CPT Flag]"
    Expression ="[Item Master].Repack"
    Expression ="[Item Master].[CE Mark Flag]"
    Expression ="[Item Master].[Force Item Notes]"
    Expression ="[Item Master].[Print Message]"
    Expression ="[Item Master].[Kit Pricing Method]"
    Expression ="[Item Master].[Catalog 1]"
    Expression ="[Item Master].TOC1"
    Expression ="[Item Master].STOC1"
    Expression ="[Item Master].[Catalog 2]"
    Expression ="[Item Master].TOC2"
    Expression ="[Item Master].STOC2"
    Expression ="[Item Master].[Catalog 3]"
    Expression ="[Item Master].TOC3"
    Expression ="[Item Master].STOC3"
    Expression ="[Item Master].[Catalog 4]"
    Expression ="[Item Master].TOC4"
    Expression ="[Item Master].STOC4"
    Expression ="[Item Master].[Catalog 5]"
    Expression ="[Item Master].TOC5"
    Expression ="[Item Master].STOC5"
    Expression ="[Item Master].[Catalog 6]"
    Expression ="[Item Master].TOC6"
    Expression ="[Item Master].STOC6"
    Expression ="[Item Master].[Employee Uploading Catalog]"
    Expression ="[Item Master].[Comment - 256 Characters Max]"
    Expression ="[Item Master].[Error message]"
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
dbText "Description" ="tc"
Begin
    Begin
        dbText "Name" ="[Item Master].[Cost Prc Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sell Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sell Prc Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Cost Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Cost Qty Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Cost Prc Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Cost Qty Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sell Qty Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sell Qty Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sell Prc Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sell Qty Brk3]"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="[Item Master].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Cost Qty Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Comp Xref"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3630"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Item Master.Comp Xref Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.HSI Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.HSI Item Prefix"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Item Description"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Strength"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Abbr Description"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Abbr Strength"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Shelf Life Days"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Location Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.InTransit"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Drug Class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.NDC Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Manuf Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Size"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Primary UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Secondary UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Purchase UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.1 Sec =? Prm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.1 Purch =? Prm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Case Code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Case Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Units Per Container"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Minimum"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Multiple"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Major"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sub Major"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Minor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sub Minor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Tax class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Label class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Manufacturer"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Brand Name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Vendor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Primary Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Buyer#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Currency"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Wholesale Set Leader"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Retail Set Leader"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Cost Qty Brk1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Cost Prc Brk1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Cost Qty Brk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Cost Prc Brk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Cost Qty Brk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Cost Prc Brk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sell Qty Brk1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sell Prc Brk1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sell Qty Brk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sell Prc Brk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sell Qty Brk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Sell Prc Brk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Classification Code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Line Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Stock Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.GL Class type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Avail Code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Ration Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Country Of Org"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Stocking Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Pricing Info"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.MSDS Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.MSDS Xref Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.MSDS Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Substitute Xref Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Substitute Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.AutoSubstitute Xref Type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.AutoSubstitute Item#"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Import/Domestic"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.BackOrder Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Check Availability"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Print on Pickticket"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Freightable Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Weight UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Volume UOM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Height"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Width"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Length"
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
        dbText "Name" ="Item Master.Hazardous Class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.CPT Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Repack"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.CE Mark Flag"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Force Item Notes"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Print Message"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Kit Pricing Method"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Item Master.Error message"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Wholesale Set Leader]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Comp Xref]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Currency"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Branch Plant 2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].TOC1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Kit Pricing Method]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Check Availability]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Branch Plant 3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Serial Number Required]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].TOC4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Location Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Case Qty]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Abbr Strength]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[AutoSubstitute Xref Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Favorite Cost]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Repack"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].InTransit"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[MSDS Flag]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Pricing Info]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Country Of Org]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[MSRP Qty]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Error message]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].STOC1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Comp Xref Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[HSI Item Prefix]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Item Description]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Strength"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Major"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Abbr Description]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Shelf Life Days]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Drug Class]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[NDC Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Manuf Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Size"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Primary UOM]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Secondary UOM]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Purchase UOM]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Comment - 256 Characters Max]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[1 Sec =? Prm]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[1 Purch =? Prm]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Case Code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Units Per Container]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Minimum"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Multiple"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sub Major]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Minor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sub Minor]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Tax class]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Label class]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Manufacturer"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Brand Name]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Vendor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Primary Supplier]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Buyer#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Retail Set Leader]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Favorite Cost Qty]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].MSRP"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Classification Code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Line Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Stock Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[GL Class type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Avail Code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Ration Qty]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Branch Plant 1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Branch Plant 4]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Branch Plant 5]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Branch Plant 6]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Stocking Flag]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[MSDS Xref Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[MSDS Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Substitute Xref Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Substitute Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Substitute Original Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].TOC3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[AutoSubstitute Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Auto-Substitute Original Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[AM Item Number]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Import/Domestic]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[BackOrder Flag]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Print on Pickticket]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Freightable Item]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Weight UOM]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Volume UOM]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Height"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Width"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Length"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Weight"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Shipping Commodity Class]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Hazardous Class]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[CPT Flag]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[CE Mark Flag]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Force Item Notes]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Print Message]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Catalog 1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Catalog 2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].TOC2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].STOC2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Catalog 3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].STOC3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Catalog 4]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].STOC4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Catalog 5]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].TOC5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].STOC5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Catalog 6]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].TOC6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].STOC6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Employee Uploading Catalog]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Cost Prc Brk3_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Cost Qty Brk3_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Cost Prc Brk1_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Cost Qty Brk2_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Sell Prc Brk1_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Sell Prc Brk3_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Cost Qty Brk1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Cost Qty Brk1_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Cost Prc Brk2_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Sell Qty Brk1_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Sell Qty Brk2_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Sell Prc Brk2_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Sell Qty Brk3_"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1494
    Bottom =938
    Left =-1
    Top =-1
    Right =1470
    Bottom =660
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =513
        Bottom =710
        Top =0
        Name ="Item Master"
        Name =""
    End
End
