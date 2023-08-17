Operation =3
Name ="Item Master Export"
Option =0
Where ="((([Item Master].[Comp Xref])=\"81\"))"
Begin InputTables
    Name ="Item Master"
    Name ="0-QrySel-SetLeaders-Wholesales"
End
Begin OutputColumns
    Name ="Comp Xref"
    Expression ="[Item Master].[Comp Xref]"
    Name ="Comp Xref Item#"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Comp Xref Item#]"
    Name ="HSI Item#"
    Expression ="[Item Master].[HSI Item#]"
    Name ="HSI Item Prefix"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[HSI Item Prefix]"
    Name ="Item Description"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Item Description]"
    Name ="Strength"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Strength"
    Name ="Abbr Description"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Abbr Description]"
    Name ="Abbr Strength"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Abbr Strength]"
    Name ="Shelf Life Days"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Shelf Life Days]"
    Name ="Location Type"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Location Type]"
    Name ="InTransit"
    Expression ="[0-QrySel-SetLeaders-Wholesales].InTransit"
    Name ="Drug Class"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Drug Class]"
    Name ="NDC Item#"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[NDC Item#]"
    Name ="Manuf Item#"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Manuf Item#]"
    Name ="Size"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Size"
    Name ="Primary UOM"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Primary UOM]"
    Name ="Secondary UOM"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Secondary UOM]"
    Name ="Purchase UOM"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Purchase UOM]"
    Name ="1 Sec =? Prm"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[1 Sec =? Prm]"
    Name ="1 Purch =? Prm"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[1 Purch =? Prm]"
    Name ="Case Code"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Case Code]"
    Name ="Case Qty"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Case Qty]"
    Name ="Units Per Container"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Units Per Container]"
    Name ="Minimum"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Minimum"
    Name ="Multiple"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Multiple"
    Name ="Major"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Major"
    Name ="Sub Major"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sub Major]"
    Name ="Minor"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Minor"
    Name ="Sub Minor"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sub Minor]"
    Name ="Tax class"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Tax class]"
    Name ="Label class"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Label class]"
    Name ="Manufacturer"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Manufacturer"
    Name ="Brand Name"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Brand Name]"
    Name ="Vendor"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Vendor"
    Name ="Primary Supplier"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Primary Supplier]"
    Name ="Buyer#"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Buyer#]"
    Name ="Currency"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Currency"
    Name ="Wholesale Set Leader"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Wholesale Set Leader]"
    Name ="Retail Set Leader"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Retail Set Leader]"
    Name ="Cost Qty Brk1"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk1]"
    Name ="Cost Prc Brk1"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk1]"
    Name ="Cost Qty Brk2"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk2]"
    Name ="Cost Prc Brk2"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk2]"
    Name ="Cost Qty Brk3"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk3]"
    Name ="Cost Prc Brk3"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk3]"
    Name ="Sell Qty Brk1"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk1]"
    Name ="Sell Prc Brk1"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk1]"
    Name ="Sell Qty Brk2"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk2]"
    Name ="Sell Prc Brk2"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk2]"
    Name ="Sell Qty Brk3"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk3]"
    Name ="Sell Prc Brk3"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk3]"
    Name ="Classification Code"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Classification Code]"
    Name ="Line Type"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Line Type]"
    Name ="Stock Type"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Stock Type]"
    Name ="GL Class type"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[GL Class type]"
    Name ="Avail Code"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Avail Code]"
    Name ="Ration Qty"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Ration Qty]"
    Name ="Country Of Org"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Country Of Org]"
    Alias ="Expr1"
    Name ="Branch Plant"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Branch Plant]"
    Name ="Stocking Flag"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Stocking Flag]"
    Name ="Pricing Info"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Pricing Info]"
    Name ="MSDS Flag"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[MSDS Flag]"
    Name ="MSDS Xref Type"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[MSDS Xref Type]"
    Name ="MSDS Item#"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[MSDS Item#]"
    Name ="Substitute Xref Type"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Substitute Xref Type]"
    Name ="Substitute Item#"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Substitute Item#]"
    Name ="AutoSubstitute Xref Type"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[AutoSubstitute Xref Type]"
    Name ="AutoSubstitute Item#"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[AutoSubstitute Item#]"
    Name ="Import/Domestic"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Import/Domestic]"
    Name ="BackOrder Flag"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[BackOrder Flag]"
    Name ="Check Availability"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Check Availability]"
    Name ="Print on Pickticket"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Print on Pickticket]"
    Name ="Freightable Item"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Freightable Item]"
    Name ="Weight UOM"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Weight UOM]"
    Name ="Volume UOM"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Volume UOM]"
    Name ="Height"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Height"
    Name ="Width"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Width"
    Name ="Length"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Length"
    Name ="Weight"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Weight"
    Name ="Shipping Commodity Class"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Shipping Commodity Class]"
    Name ="Hazardous Class"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Hazardous Class]"
    Name ="CPT Flag"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[CPT Flag]"
    Name ="Repack"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Repack"
    Name ="CE Mark Flag"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[CE Mark Flag]"
    Name ="Force Item Notes"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Force Item Notes]"
    Name ="Print Message"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Print Message]"
    Name ="Kit Pricing Method"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Kit Pricing Method]"
    Name ="Error message"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Error message]"
    Alias ="Expr2"
    Name ="Exception Message"
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
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
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
End
Begin
    State =0
    Left =0
    Top =40
    Right =1242
    Bottom =952
    Left =-1
    Top =-1
    Right =1216
    Bottom =168
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="Item Master"
        Name =""
    End
    Begin
        Left =240
        Top =12
        Right =572
        Bottom =156
        Top =0
        Name ="0-QrySel-SetLeaders-Wholesales"
        Name =""
    End
End
