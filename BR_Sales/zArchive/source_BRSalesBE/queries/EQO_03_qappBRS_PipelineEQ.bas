Operation =3
Name ="BRS_PipelineEQ"
Option =0
Begin InputTables
    Name ="qsubBRS_PipelineEQ"
End
Begin OutputColumns
    Name ="D1Branch"
    Expression ="qsubBRS_PipelineEQ.Center"
    Name ="ETSNum"
    Expression ="qsubBRS_PipelineEQ.OrdNum"
    Name ="WorkOrderDt"
    Expression ="qsubBRS_PipelineEQ.OrderDate"
    Name ="OrderStatus"
    Expression ="qsubBRS_PipelineEQ.ST"
    Name ="Item"
    Expression ="qsubBRS_PipelineEQ.Part_"
    Name ="OrderQty"
    Expression ="qsubBRS_PipelineEQ.Qty"
    Name ="NetSalesAmt"
    Expression ="qsubBRS_PipelineEQ.Ext_Price"
    Name ="ExtendedCostAmt"
    Expression ="qsubBRS_PipelineEQ.Ext_Cost"
    Name ="Supplier"
    Expression ="qsubBRS_PipelineEQ.Supplier"
    Name ="InstallDt"
    Expression ="qsubBRS_PipelineEQ.Proj_Date"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="lnkEQProj.OrdNum"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkEQProj.Center"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOfCenter"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkEQProj.Vendor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkEQProj.Part"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkEQProj.Quantity"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkEQProj.Price"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkEQProj.Cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkEQProj.ProjectedDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkEQProj.OrderDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="lnkEQProj.ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubBRS_PipelineEQ.ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="IsNumeric([Quantity])"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubBRS_PipelineEQ.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubBRS_PipelineEQ.OrderDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubBRS_PipelineEQ.ProjectedDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubBRS_PipelineEQ.Ext_Cost"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubBRS_PipelineEQ.OrdNum"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubBRS_PipelineEQ.Quantity"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubBRS_PipelineEQ.Ext_Price"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubBRS_PipelineEQ.Center"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubBRS_PipelineEQ.Part"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubBRS_PipelineEQ.Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubBRS_PipelineEQ.Proj_Date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubBRS_PipelineEQ.Part_"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =4
    Top =15
    Right =1159
    Bottom =705
    Left =-1
    Top =-1
    Right =1123
    Bottom =347
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =15
        Top =17
        Right =182
        Bottom =266
        Top =0
        Name ="qsubBRS_PipelineEQ"
        Name =""
    End
End
