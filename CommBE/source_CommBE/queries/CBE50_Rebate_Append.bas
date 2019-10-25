Operation =3
Name ="STAGE_Rebate"
Option =0
Having ="(((Sum(comm_customer_rebate_YTD.rebate_YTD))>0))"
Begin InputTables
    Name ="comm_customer_rebate_YTD"
    Name ="comm_configure"
    Name ="comm_salesperson_code_map"
    Name ="qsubRebateSundryTeeth"
    Name ="qsubRebateSundry"
End
Begin OutputColumns
    Name ="salesperson_key_id"
    Expression ="comm_salesperson_code_map.salesperson_key_id"
    Alias ="rebate_monthly_amt"
    Name ="rebate_monthly_amt"
    Expression ="Sum(comm_customer_rebate_YTD.rebate_YTD)"
    Alias ="merch_teeth_amt"
    Name ="merch_teeth_amt"
    Expression ="First(qsubRebateSundryTeeth.total_sundry_teeth_amt)"
    Alias ="merch_amt"
    Name ="merch_amt"
    Expression ="First(qsubRebateSundry.merch_amt)"
    Alias ="percent_rt"
    Name ="percent_rt"
    Expression ="0"
End
Begin Joins
    LeftTable ="comm_customer_rebate_YTD"
    RightTable ="comm_configure"
    Expression ="comm_customer_rebate_YTD.fiscal_yearmo_num = comm_configure.current_fiscal_yearm"
        "o_num"
    Flag =1
    LeftTable ="comm_customer_rebate_YTD"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_customer_rebate_YTD.salesperson_cd = comm_salesperson_code_map.salesperson_"
        "cd"
    Flag =1
    LeftTable ="comm_salesperson_code_map"
    RightTable ="qsubRebateSundryTeeth"
    Expression ="comm_salesperson_code_map.salesperson_key_id = qsubRebateSundryTeeth.salesperson"
        "_key_id"
    Flag =2
    LeftTable ="comm_salesperson_code_map"
    RightTable ="qsubRebateSundry"
    Expression ="comm_salesperson_code_map.salesperson_key_id = qsubRebateSundry.salesperson_key_"
        "id"
    Flag =2
End
Begin OrderBy
    Expression ="Sum(comm_customer_rebate_YTD.rebate_YTD)"
    Flag =1
End
Begin Groups
    Expression ="comm_salesperson_code_map.salesperson_key_id"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbText "Description" ="Run comm calc and summary proc first!"
Begin
    Begin
        dbText "Name" ="rebate_monthly_amt"
        dbInteger "ColumnWidth" ="1950"
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
        dbText "Name" ="sundry_teeth_amt"
        dbInteger "ColumnWidth" ="2805"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="merch_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="percent_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubFSCTerrMap.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1493
    Bottom =1004
    Left =-1
    Top =-1
    Right =1470
    Bottom =413
    Left =0
    Top =0
    ColumnsShown =655
    Begin
        Left =38
        Top =6
        Right =244
        Bottom =128
        Top =0
        Name ="comm_customer_rebate_YTD"
        Name =""
    End
    Begin
        Left =448
        Top =7
        Right =706
        Bottom =144
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =320
        Top =188
        Right =556
        Bottom =332
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
    Begin
        Left =851
        Top =34
        Right =1140
        Bottom =111
        Top =0
        Name ="qsubRebateSundryTeeth"
        Name =""
    End
    Begin
        Left =874
        Top =275
        Right =1072
        Bottom =352
        Top =0
        Name ="qsubRebateSundry"
        Name =""
    End
End
