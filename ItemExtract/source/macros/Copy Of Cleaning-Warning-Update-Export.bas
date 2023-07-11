Version =196611
ColumnsShown =0
Begin
    Action ="SetWarnings"
    Argument ="0"
End
Begin
    Action ="OpenQuery"
    Argument ="0-DelItems"
    Argument ="0"
    Argument ="1"
End
Begin
    Action ="TransferText"
    Argument ="0"
    Argument ="2"
    Argument ="Item Master"
    Argument ="S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Data\\ITEM01.CSV"
    Argument ="-1"
End
Begin
    Action ="TransferText"
    Argument ="0"
    Argument ="2"
    Argument ="Item Master"
    Argument ="S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Data\\ITEM02.CSV"
    Argument ="-1"
End
Begin
    Action ="TransferText"
    Argument ="0"
    Argument ="2"
    Argument ="Item Master"
    Argument ="S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Data\\ITEM03.CSV"
    Argument ="-1"
End
Begin
    Action ="TransferText"
    Argument ="0"
    Argument ="2"
    Argument ="Item Master"
    Argument ="S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Data\\ITEM04.CSV"
    Argument ="-1"
End
Begin
    Action ="TransferText"
    Argument ="0"
    Argument ="ITEM Import Specification New"
    Argument ="Item Master"
    Argument ="S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Data\\ITEM05.CSV"
    Argument ="-1"
End
Begin
    Action ="MsgBox"
    Argument ="\"import finished\""
    Argument ="-1"
    Argument ="0"
End
Begin
    Action ="OpenQuery"
    Argument ="Warning-QryItem-NoBaseCost"
    Argument ="0"
    Argument ="1"
End
Begin
    Action ="OpenQuery"
    Argument ="warning-QryItem-NoBasePrice"
    Argument ="0"
    Argument ="1"
End
Begin
    Action ="OpenQuery"
    Argument ="warning-QrySel-ItemLeaderNotSet-Wholesales"
    Argument ="0"
    Argument ="1"
End
Begin
    Action ="OpenQuery"
    Argument ="0-DelExport"
    Argument ="0"
    Argument ="1"
End
Begin
    Action ="OpenQuery"
    Argument ="2-Update&AppendExportTable"
    Argument ="0"
    Argument ="1"
End
Begin
    Action ="MsgBox"
    Argument ="\"update completed\""
    Argument ="-1"
    Argument ="0"
End
Begin
    Action ="TransferSpreadsheet"
    Argument ="1"
    Argument ="10"
    Argument ="Item Master Export"
    Argument ="S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Export\\ItemDump."
        "xlsx"
    Argument ="-1"
End
Begin
    Action ="Quit"
    Argument ="2"
End
Begin
    Comment ="_AXL:<?xml version=\"1.0\" encoding=\"UTF-16\" standalone=\"no\"?>\015\012<UserI"
        "nterfaceMacro MinimumClientDesignVersion=\"14.0.0000.0000\" xmlns=\"http://schem"
        "as.microsoft.com/office/accessservices/2009/11/application\"><Statements><Action"
        " Collapsed=\"true\" Name=\"SetWa"
End
Begin
    Comment ="_AXL:rnings\"/><Action Collapsed=\"true\" Name=\"OpenQuery\"><Argument Name=\"Qu"
        "eryName\">0-DelItems</Argument></Action><Action Collapsed=\"true\" Name=\"Import"
        "ExportText\"><Argument Name=\"SpecificationName\">2</Argument><Argument Name=\"T"
        "ableName\">Item Master</Argu"
End
Begin
    Comment ="_AXL:ment><Argument Name=\"FileName\">S:\\Shared_Everyone\\Business Reporting\\S"
        "hared\\Item Extract\\Data\\ITEM01.CSV</Argument><Argument Name=\"HasFieldNames\""
        ">Yes</Argument></Action><Action Collapsed=\"true\" Name=\"ImportExportText\"><Ar"
        "gument Name=\"SpecificationN"
End
Begin
    Comment ="_AXL:ame\">2</Argument><Argument Name=\"TableName\">Item Master</Argument><Argum"
        "ent Name=\"FileName\">S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extr"
        "act\\Data\\ITEM02.CSV</Argument><Argument Name=\"HasFieldNames\">Yes</Argument><"
        "/Action><Action Collapsed="
End
Begin
    Comment ="_AXL:\"true\" Name=\"ImportExportText\"><Argument Name=\"SpecificationName\">2</"
        "Argument><Argument Name=\"TableName\">Item Master</Argument><Argument Name=\"Fil"
        "eName\">S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Data\\ITE"
        "M03.CSV</Argument><Argument N"
End
Begin
    Comment ="_AXL:ame=\"HasFieldNames\">Yes</Argument></Action><Action Collapsed=\"true\" Nam"
        "e=\"ImportExportText\"><Argument Name=\"SpecificationName\">2</Argument><Argumen"
        "t Name=\"TableName\">Item Master</Argument><Argument Name=\"FileName\">S:\\Share"
        "d_Everyone\\Business Report"
End
Begin
    Comment ="_AXL:ing\\Shared\\Item Extract\\Data\\ITEM04.CSV</Argument><Argument Name=\"HasF"
        "ieldNames\">Yes</Argument></Action><Action Name=\"ImportExportText\"><Argument N"
        "ame=\"SpecificationName\">ITEM Import Specification New</Argument><Argument Name"
        "=\"TableName\">Item Maste"
End
Begin
    Comment ="_AXL:r</Argument><Argument Name=\"FileName\">S:\\Shared_Everyone\\Business Repor"
        "ting\\Shared\\Item Extract\\Data\\ITEM05.CSV</Argument><Argument Name=\"HasField"
        "Names\">Yes</Argument></Action><Action Collapsed=\"true\" Name=\"MessageBox\"><A"
        "rgument Name=\"Message\">\"imp"
End
Begin
    Comment ="_AXL:ort finished\"</Argument></Action><Action Collapsed=\"true\" Name=\"OpenQue"
        "ry\"><Argument Name=\"QueryName\">Warning-QryItem-NoBaseCost</Argument></Action>"
        "<Action Collapsed=\"true\" Name=\"OpenQuery\"><Argument Name=\"QueryName\">warni"
        "ng-QryItem-NoBasePrice</Ar"
End
Begin
    Comment ="_AXL:gument></Action><Action Collapsed=\"true\" Name=\"OpenQuery\"><Argument Nam"
        "e=\"QueryName\">warning-QrySel-ItemLeaderNotSet-Wholesales</Argument></Action><A"
        "ction Collapsed=\"true\" Name=\"OpenQuery\"><Argument Name=\"QueryName\">0-DelEx"
        "port</Argument></Action><"
End
Begin
    Comment ="_AXL:Action Collapsed=\"true\" Name=\"OpenQuery\"><Argument Name=\"QueryName\">2"
        "-Update&amp;AppendExportTable</Argument></Action><Action Collapsed=\"true\" Name"
        "=\"MessageBox\"><Argument Name=\"Message\">\"update completed\"</Argument></Acti"
        "on><Action Collapsed=\"true\""
End
Begin
    Comment ="_AXL: Name=\"ImportExportSpreadsheet\"><Argument Name=\"TransferType\">Export</A"
        "rgument><Argument Name=\"TableName\">Item Master Export</Argument><Argument Name"
        "=\"FileName\">S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Exp"
        "ort\\ItemDump.xlsx</Argumen"
End
Begin
    Comment ="_AXL:t><Argument Name=\"HasFieldNames\">Yes</Argument></Action><Action Collapsed"
        "=\"true\" Name=\"QuitAccess\"><Argument Name=\"Options\">Exit</Argument></Action"
        "></Statements></UserInterfaceMacro>"
End
