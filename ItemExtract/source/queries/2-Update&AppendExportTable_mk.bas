Operation =2
Name ="Item Master Export - Fix"
Option =0
Where ="((([Item Master].[Comp Xref])=\"81\") AND (([Item Master].[HSI Item#])=\"1000025"
    "\"))"
Begin InputTables
    Name ="Item Master"
    Name ="0-QrySel-SetLeaders-Wholesales"
End
Begin OutputColumns
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
    Expression ="[0-QrySel-SetLeaders-Wholesales].Currency"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Wholesale Set Leader]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Retail Set Leader]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Favorite Cost Qty]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Favorite Cost]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk1]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk1]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk2]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk2]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk3]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk3]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk1]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk1]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk2]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk2]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk3]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk3]"
    Expression ="[Item Master].[Classification Code]"
    Expression ="[Item Master].[Line Type]"
    Expression ="[Item Master].[Stock Type]"
    Expression ="[Item Master].[GL Class type]"
    Expression ="[Item Master].[Avail Code]"
    Expression ="[Item Master].[Ration Qty]"
    Expression ="[Item Master].[Country Of Org]"
    Expression ="[Item Master].[Branch Plant 1]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Branch Plant 2]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Branch Plant 3]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Branch Plant 4]"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Branch Plant 5]"
    Expression ="[Item Master].[Stocking Flag]"
    Expression ="[Item Master].[Pricing Info]"
    Expression ="[Item Master].[MSDS Flag]"
    Expression ="[Item Master].[MSDS Xref Type]"
    Expression ="[Item Master].[MSDS Item#]"
    Expression ="[Item Master].[Substitute Xref Type]"
    Expression ="[Item Master].[Substitute Item#]"
    Expression ="[Item Master].[AutoSubstitute Xref Type]"
    Expression ="[Item Master].[AutoSubstitute Item#]"
    Expression ="[Item Master].[Import/Domestic]"
    Expression ="[Item Master].[BackOrder Flag]"
    Expression ="[Item Master].[Check Availability]"
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
    Expression ="[Item Master].[Error message]"
    Alias ="Expr2"
    Expression ="[Item Master].[Exception Message]"
End
Begin Joins
    LeftTable ="Item Master"
    RightTable ="0-QrySel-SetLeaders-Wholesales"
    Expression ="[Item Master].[Wholesale Set Leader] = [0-QrySel-SetLeaders-Wholesales].[HSI Ite"
        "m#]"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="[Item Master].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Cost Qty Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Cost Qty Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sell Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sell Qty Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sell Prc Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Cost Prc Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Retails].[Cost Qty Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Cost Qty Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Cost Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Cost Prc Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sell Qty Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sell Prc Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Sell Qty Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Comp Xref]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Comp Xref Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Error message]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Item Master.Comp Xref]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[HSI Item Prefix]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Item Description]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Strength"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Abbr Description]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Abbr Strength]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Shelf Life Days]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Location Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].InTransit"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Drug Class]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[NDC Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Manuf Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Size"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Primary UOM]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Secondary UOM]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Purchase UOM]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[1 Sec =? Prm]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[1 Purch =? Prm]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Case Code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Case Qty]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Units Per Container]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Minimum"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Multiple"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Major"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sub Major]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Minor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sub Minor]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Tax class]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Label class]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Manufacturer"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Brand Name]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Vendor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Primary Supplier]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Buyer#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Currency"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Wholesale Set Leader]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Retail Set Leader]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Classification Code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Line Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Stock Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[GL Class type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Avail Code]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Ration Qty]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Country Of Org]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Branch Plant]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Stocking Flag]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Pricing Info]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[MSDS Flag]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[MSDS Xref Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[MSDS Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Substitute Xref Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Substitute Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[AutoSubstitute Xref Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[AutoSubstitute Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Import/Domestic]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[BackOrder Flag]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Check Availability]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Print on Pickticket]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Freightable Item]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Weight UOM]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Volume UOM]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Height"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Width"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Length"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Weight"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Shipping Commodity Class]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Hazardous Class]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[CPT Flag]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].Repack"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[CE Mark Flag]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Force Item Notes]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Print Message]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Kit Pricing Method]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Exception Message]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Comp Xref]"
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
        dbInteger "ColumnWidth" ="2895"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].Strength"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Abbr Description]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Abbr Strength]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Shelf Life Days]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Location Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].InTransit"
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
        dbText "Name" ="[Item Master].[Case Qty]"
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
        dbText "Name" ="[Item Master].Major"
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
        dbText "Name" ="[Item Master].Currency"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Wholesale Set Leader]"
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
        dbText "Name" ="[Item Master].[Country Of Org]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Branch Plant]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Stocking Flag]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Pricing Info]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[MSDS Flag]"
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
        dbText "Name" ="[Item Master].[AutoSubstitute Xref Type]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[AutoSubstitute Item#]"
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
        dbText "Name" ="[Item Master].[Check Availability]"
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
        dbText "Name" ="[Item Master].Repack"
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
        dbText "Name" ="[Item Master].[Kit Pricing Method]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Error message]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Favorite Cost Qty]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Favorite Cost]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[MSRP Qty]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].MSRP"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Branch Plant 1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Branch Plant 2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Branch Plant 3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Branch Plant 4]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Branch Plant 5]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr2"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =761
    Bottom =632
    Left =-1
    Top =-1
    Right =723
    Bottom =254
    Left =96
    Top =0
    ColumnsShown =539
    Begin
        Left =85
        Top =-2
        Right =229
        Bottom =142
        Top =0
        Name ="Item Master"
        Name =""
    End
    Begin
        Left =317
        Top =19
        Right =649
        Bottom =163
        Top =0
        Name ="0-QrySel-SetLeaders-Wholesales"
        Name =""
    End
End
