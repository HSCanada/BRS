Operation =1
Option =0
Where ="((([Item Master].[Comp Xref])=\"81\") AND (([Item Master].[Wholesale Set Leader]"
    ")=[HSI Item#]))"
Begin InputTables
    Name ="Item Master"
End
Begin OutputColumns
    Expression ="[Item Master].*"
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
End
Begin
    State =0
    Left =-516
    Top =41
    Right =726
    Bottom =963
    Left =-1
    Top =-1
    Right =1204
    Bottom =285
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
