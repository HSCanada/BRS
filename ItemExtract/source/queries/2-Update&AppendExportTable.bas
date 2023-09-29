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
    Expression ="[Item Master].[Comp Xref Item#]"
    Name ="HSI Item#"
    Expression ="[Item Master].[HSI Item#]"
    Name ="HSI Item Prefix"
    Expression ="[Item Master].[HSI Item Prefix]"
    Name ="Item Description"
    Expression ="[Item Master].[Item Description]"
    Name ="Strength"
    Expression ="[Item Master].Strength"
    Name ="Abbr Description"
    Expression ="[Item Master].[Abbr Description]"
    Name ="Abbr Strength"
    Expression ="[Item Master].[Abbr Strength]"
    Name ="Shelf Life Days"
    Expression ="[Item Master].[Shelf Life Days]"
    Name ="Location Type"
    Expression ="[Item Master].[Location Type]"
    Name ="InTransit"
    Expression ="[Item Master].InTransit"
    Name ="Drug Class"
    Expression ="[Item Master].[Drug Class]"
    Name ="NDC Item#"
    Expression ="[Item Master].[NDC Item#]"
    Name ="Manuf Item#"
    Expression ="[Item Master].[Manuf Item#]"
    Name ="Size"
    Expression ="[Item Master].Size"
    Name ="Primary UOM"
    Expression ="[Item Master].[Primary UOM]"
    Name ="Secondary UOM"
    Expression ="[Item Master].[Secondary UOM]"
    Name ="Purchase UOM"
    Expression ="[Item Master].[Purchase UOM]"
    Name ="1 Sec =? Prm"
    Expression ="[Item Master].[1 Sec =? Prm]"
    Name ="1 Purch =? Prm"
    Expression ="[Item Master].[1 Purch =? Prm]"
    Name ="Case Code"
    Expression ="[Item Master].[Case Code]"
    Name ="Case Qty"
    Expression ="[Item Master].[Case Qty]"
    Name ="Units Per Container"
    Expression ="[Item Master].[Units Per Container]"
    Name ="Minimum"
    Expression ="[Item Master].Minimum"
    Name ="Multiple"
    Expression ="[Item Master].Multiple"
    Name ="Major"
    Expression ="[Item Master].Major"
    Name ="Sub Major"
    Expression ="[Item Master].[Sub Major]"
    Name ="Minor"
    Expression ="[Item Master].Minor"
    Name ="Sub Minor"
    Expression ="[Item Master].[Sub Minor]"
    Name ="Tax class"
    Expression ="[Item Master].[Tax class]"
    Name ="Label class"
    Expression ="[Item Master].[Label class]"
    Name ="Manufacturer"
    Expression ="[Item Master].Manufacturer"
    Name ="Brand Name"
    Expression ="[Item Master].[Brand Name]"
    Name ="Vendor"
    Expression ="[Item Master].Vendor"
    Name ="Primary Supplier"
    Expression ="[Item Master].[Primary Supplier]"
    Name ="Buyer#"
    Expression ="[Item Master].[Buyer#]"
    Name ="Currency"
    Expression ="[0-QrySel-SetLeaders-Wholesales].Currency"
    Name ="Wholesale Set Leader"
    Expression ="[Item Master].[Wholesale Set Leader]"
    Name ="Retail Set Leader"
    Expression ="[Item Master].[Retail Set Leader]"
    Name ="Favorite Cost Qty"
    Expression ="[Item Master].[Favorite Cost Qty]"
    Name ="Favorite Cost"
    Expression ="[Item Master].[Favorite Cost]"
    Name ="Cost Qty Brk1"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk1_]"
    Name ="Cost Prc Brk1"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk1_]"
    Name ="Cost Qty Brk2"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk2_]"
    Name ="Cost Prc Brk2"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk2_]"
    Name ="Cost Qty Brk3"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk3_]"
    Name ="Cost Prc Brk3"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk3_]"
    Name ="Sell Qty Brk1"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk1_]"
    Name ="Sell Prc Brk1"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk1_]"
    Name ="Sell Qty Brk2"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk2_]"
    Name ="Sell Prc Brk2"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk2_]"
    Name ="Sell Qty Brk3"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk3_]"
    Name ="Sell Prc Brk3"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk3_]"
    Name ="Classification Code"
    Expression ="[Item Master].[Classification Code]"
    Name ="Line Type"
    Expression ="[Item Master].[Line Type]"
    Name ="Stock Type"
    Expression ="[Item Master].[Stock Type]"
    Name ="GL Class type"
    Expression ="[Item Master].[GL Class type]"
    Name ="Avail Code"
    Expression ="[Item Master].[Avail Code]"
    Name ="Ration Qty"
    Expression ="[Item Master].[Ration Qty]"
    Name ="Country Of Org"
    Expression ="[Item Master].[Country Of Org]"
    Name ="Branch Plant 1"
    Expression ="[Item Master].[Branch Plant 1]"
    Name ="Branch Plant 2"
    Expression ="[Item Master].[Branch Plant 2]"
    Name ="Branch Plant 3"
    Expression ="[Item Master].[Branch Plant 3]"
    Name ="Branch Plant 4"
    Expression ="[Item Master].[Branch Plant 4]"
    Name ="Branch Plant 5"
    Expression ="[Item Master].[Branch Plant 5]"
    Name ="Stocking Flag"
    Expression ="[Item Master].[Stocking Flag]"
    Name ="Pricing Info"
    Expression ="[Item Master].[Pricing Info]"
    Name ="MSDS Flag"
    Expression ="[Item Master].[MSDS Flag]"
    Name ="MSDS Xref Type"
    Expression ="[Item Master].[MSDS Xref Type]"
    Name ="MSDS Item#"
    Expression ="[Item Master].[MSDS Item#]"
    Name ="Substitute Xref Type"
    Expression ="[Item Master].[Substitute Xref Type]"
    Name ="Substitute Item#"
    Expression ="[Item Master].[Substitute Item#]"
    Name ="AutoSubstitute Xref Type"
    Expression ="[Item Master].[AutoSubstitute Xref Type]"
    Name ="AutoSubstitute Item#"
    Expression ="[Item Master].[AutoSubstitute Item#]"
    Name ="Import/Domestic"
    Expression ="[Item Master].[Import/Domestic]"
    Name ="BackOrder Flag"
    Expression ="[Item Master].[BackOrder Flag]"
    Name ="Check Availability"
    Expression ="[Item Master].[Check Availability]"
    Name ="Print on Pickticket"
    Expression ="[Item Master].[Print on Pickticket]"
    Name ="Freightable Item"
    Expression ="[Item Master].[Freightable Item]"
    Name ="Weight UOM"
    Expression ="[Item Master].[Weight UOM]"
    Name ="Volume UOM"
    Expression ="[Item Master].[Volume UOM]"
    Name ="Height"
    Expression ="[Item Master].Height"
    Name ="Width"
    Expression ="[Item Master].Width"
    Name ="Length"
    Expression ="[Item Master].Length"
    Name ="Weight"
    Expression ="[Item Master].Weight"
    Name ="Shipping Commodity Class"
    Expression ="[Item Master].[Shipping Commodity Class]"
    Name ="Hazardous Class"
    Expression ="[Item Master].[Hazardous Class]"
    Name ="CPT Flag"
    Expression ="[Item Master].[CPT Flag]"
    Name ="Repack"
    Expression ="[Item Master].Repack"
    Name ="CE Mark Flag"
    Expression ="[Item Master].[CE Mark Flag]"
    Name ="Force Item Notes"
    Expression ="[Item Master].[Force Item Notes]"
    Name ="Print Message"
    Expression ="[Item Master].[Print Message]"
    Name ="Kit Pricing Method"
    Expression ="[Item Master].[Kit Pricing Method]"
    Name ="Error message"
    Expression ="[Item Master].[Error message]"
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
dbText "Description" ="tc"
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
    Begin
        dbText "Name" ="[Item Master].[Catalog 1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].TOC1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].STOC1"
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
        dbText "Name" ="[Item Master].TOC4"
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
        dbText "Name" ="[Item Master].[Comment - 256 Characters Max]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Future Use Qty -4]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Future Use Flag -2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Future Use Flag -5]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Future Use Amt -3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Future Use Text -1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Future Use Text -4]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Future Use Date -2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Future Use Date -5]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Favorite Cost Qty]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Retail Set Leader]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Favorite Cost]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Branch Plant 2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Branch Plant 3]"
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
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk2_]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk2_]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr11"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk3_]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk2_]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr10"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk3_]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr12"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk1_]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk1_]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk2_]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Cost Qty Brk3_]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Cost Prc Brk3_]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr7"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sell Qty Brk1_]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr8"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Sell Prc Brk1_]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr9"
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
    Bottom =211
    Left =96
    Top =0
    ColumnsShown =651
    Begin
        Left =96
        Top =6
        Right =240
        Bottom =150
        Top =0
        Name ="Item Master"
        Name =""
    End
    Begin
        Left =314
        Top =11
        Right =728
        Bottom =235
        Top =0
        Name ="0-QrySel-SetLeaders-Wholesales"
        Name =""
    End
End
