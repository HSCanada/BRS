Operation =4
Option =0
Where ="((([Item Master Export].[Sell Prc Brk1])<>[CorporatePrice]) AND ((STAGE_BRS_Item"
    "BaseHistory.CalMonth)=0)) OR ((([Item Master Export].[Sell Qty Brk2])<>[SellQtyB"
    "rk2]) AND ((STAGE_BRS_ItemBaseHistory.CalMonth)=0)) OR ((([Item Master Export].["
    "Sell Prc Brk2])<>[SellPrcBrk2]) AND ((STAGE_BRS_ItemBaseHistory.CalMonth)=0)) OR"
    " ((([Item Master Export].[Sell Qty Brk3])<>[SellQtyBrk3]) AND ((STAGE_BRS_ItemBa"
    "seHistory.CalMonth)=0)) OR ((([Item Master Export].[Sell Prc Brk3])<>[SellPrcBrk"
    "3]) AND ((STAGE_BRS_ItemBaseHistory.CalMonth)=0))"
Begin InputTables
    Name ="Item Master Export"
    Name ="STAGE_BRS_ItemBaseHistory"
End
Begin OutputColumns
    Name ="[Item Master Export].[Sell Prc Brk1]"
    Expression ="[CorporatePrice]"
    Name ="[Item Master Export].[Sell Qty Brk2]"
    Expression ="[SellQtyBrk2]"
    Name ="[Item Master Export].[Sell Prc Brk2]"
    Expression ="[SellPrcBrk2]"
    Name ="[Item Master Export].[Sell Qty Brk3]"
    Expression ="[SellQtyBrk3]"
    Name ="[Item Master Export].[Sell Prc Brk3]"
    Expression ="[SellPrcBrk3]"
End
Begin Joins
    LeftTable ="Item Master Export"
    RightTable ="STAGE_BRS_ItemBaseHistory"
    Expression ="[Item Master Export].[HSI Item#] = STAGE_BRS_ItemBaseHistory.Item"
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
dbBoolean "UseTransaction" ="0"
dbBoolean "FailOnError" ="-1"
dbText "Description" ="tc"
Begin
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Prc Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Qty Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Prc Brk3]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Qty Brk2]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="cost__"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Nz([Item Master Export]![Currency],\"CAD\")"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].Currency"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Cost Prc Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="curr_"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.SellQtyBrk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master Export].[Sell Qty Brk1]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.CorporatePrice"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.SellPrcBrk2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.SellPrcBrk3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_BRS_ItemBaseHistory.SellQtyBrk2"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1096
    Bottom =938
    Left =-1
    Top =-1
    Right =1072
    Bottom =499
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =74
        Top =36
        Right =326
        Bottom =358
        Top =0
        Name ="Item Master Export"
        Name =""
    End
    Begin
        Left =480
        Top =59
        Right =809
        Bottom =383
        Top =0
        Name ="STAGE_BRS_ItemBaseHistory"
        Name =""
    End
End
