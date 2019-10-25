Operation =4
Option =0
Where ="(((STAGE_Rebate.percent_rt)=0) AND ((STAGE_Rebate.merch_teeth_amt)>0) AND ((STAG"
    "E_Rebate.merch_amt)<=[merch_teeth_amt] And (STAGE_Rebate.merch_amt)>=0))"
Begin InputTables
    Name ="STAGE_Rebate"
End
Begin OutputColumns
    Name ="STAGE_Rebate.percent_rt"
    Expression ="[merch_amt]/[merch_teeth_amt]"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.salesperson_key_id"
        dbInteger "ColumnWidth" ="2910"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOftotal_sundry_teeth_amt"
        dbInteger "ColumnWidth" ="2805"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="rebate_monthly_amt"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="sundry_teeth_amt"
        dbInteger "ColumnWidth" ="2805"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="merch_teeth_amt"
        dbInteger "ColumnWidth" ="2805"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzRebate02.merch_teeth_amt"
        dbInteger "ColumnWidth" ="1695"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =18
    Top =40
    Right =1258
    Bottom =449
    Left =-1
    Top =-1
    Right =1217
    Bottom =225
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="STAGE_Rebate"
        Name =""
    End
End
