Operation =1
Option =0
Where ="(((comm_customer_master.hsi_shipto_id) Is Null))"
Begin InputTables
    Name ="comm_transaction_hsi_stage"
    Name ="comm_customer_master"
End
Begin OutputColumns
    Alias ="hsi_shipto_id"
    Expression ="comm_transaction_hsi_stage.WKSHAN"
    Alias ="hsi_billto_id"
    Expression ="First(comm_transaction_hsi_stage.WKAN8)"
    Alias ="ship_mailing_nm"
    Expression ="First(comm_transaction_hsi_stage.WKALPH)"
    Alias ="ship_address_1_txt"
    Expression ="\"\""
    Alias ="ship_address_2_txt"
    Expression ="\"\""
    Alias ="ship_address_3_txt"
    Expression ="\"\""
    Alias ="ship_address_4_txt"
    Expression ="\"\""
    Alias ="ship_city_nm"
    Expression ="\"\""
    Alias ="ship_province_cd"
    Expression ="\"\""
    Alias ="ship_postal_num"
    Expression ="\"\""
    Alias ="ship_phone_num"
    Expression ="\"\""
    Alias ="customer_id"
    Expression ="\"\""
    Alias ="salesperson_cd"
    Expression ="First(IIf([WKAC10]=\"AZA\",\"AZAZZ\",[WK$L04]))"
    Alias ="salesperson_nm"
    Expression ="\"\""
End
Begin Joins
    LeftTable ="comm_transaction_hsi_stage"
    RightTable ="comm_customer_master"
    Expression ="comm_transaction_hsi_stage.WKSHAN = comm_customer_master.hsi_shipto_id"
    Flag =2
End
Begin Groups
    Expression ="comm_transaction_hsi_stage.WKSHAN"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="hsi_shipto_id"
        dbInteger "ColumnWidth" ="1380"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="hsi_billto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ship_mailing_nm"
        dbInteger "ColumnWidth" ="2820"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ship_address_1_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ship_address_2_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ship_address_3_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ship_address_4_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ship_city_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ship_province_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ship_postal_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ship_phone_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="customer_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1539
    Bottom =1004
    Left =-1
    Top =-1
    Right =1516
    Bottom =359
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =47
        Top =20
        Right =323
        Bottom =292
        Top =0
        Name ="comm_transaction_hsi_stage"
        Name =""
    End
    Begin
        Left =395
        Top =42
        Right =895
        Bottom =328
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
End
