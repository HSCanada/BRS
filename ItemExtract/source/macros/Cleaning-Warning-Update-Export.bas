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
    Argument ="ITEM Import Specification New"
    Argument ="Item Master"
    Argument ="S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Data\\ITEM01.CSV"
    Argument ="-1"
End
Begin
    Action ="TransferText"
    Argument ="0"
    Argument ="ITEM Import Specification New"
    Argument ="Item Master"
    Argument ="S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Data\\ITEM02.CSV"
    Argument ="-1"
End
Begin
    Action ="TransferText"
    Argument ="0"
    Argument ="ITEM Import Specification New"
    Argument ="Item Master"
    Argument ="S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Data\\ITEM03.CSV"
    Argument ="-1"
End
Begin
    Action ="TransferText"
    Argument ="0"
    Argument ="ITEM Import Specification New"
    Argument ="Item Master"
    Argument ="S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Data\\ITEM04.CSV"
    Argument ="-1"
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
    Action ="TransferSpreadsheet"
    Argument ="1"
    Argument ="10"
    Argument ="Item Master Export"
    Argument ="S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Export\\ItemDump."
        "xlsx"
    Argument ="-1"
End
Begin
    Action ="Beep"
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
        "eryName\">0-DelItems</Argument></Action><Action Name=\"ImportExportText\"><Argum"
        "ent Name=\"SpecificationName\">ITEM Import Specification New</Argument><Argument"
        " Name=\"TableName\">Item M"
End
Begin
    Comment ="_AXL:aster</Argument><Argument Name=\"FileName\">S:\\Shared_Everyone\\Business R"
        "eporting\\Shared\\Item Extract\\Data\\ITEM01.CSV</Argument><Argument Name=\"HasF"
        "ieldNames\">Yes</Argument></Action><Action Name=\"ImportExportText\"><Argument N"
        "ame=\"SpecificationName\">I"
End
Begin
    Comment ="_AXL:TEM Import Specification New</Argument><Argument Name=\"TableName\">Item Ma"
        "ster</Argument><Argument Name=\"FileName\">S:\\Shared_Everyone\\Business Reporti"
        "ng\\Shared\\Item Extract\\Data\\ITEM02.CSV</Argument><Argument Name=\"HasFieldNa"
        "mes\">Yes</Argument></Act"
End
Begin
    Comment ="_AXL:ion><Action Name=\"ImportExportText\"><Argument Name=\"SpecificationName\">"
        "ITEM Import Specification New</Argument><Argument Name=\"TableName\">Item Master"
        "</Argument><Argument Name=\"FileName\">S:\\Shared_Everyone\\Business Reporting\\"
        "Shared\\Item Extract\\Data"
End
Begin
    Comment ="_AXL:\\ITEM03.CSV</Argument><Argument Name=\"HasFieldNames\">Yes</Argument></Act"
        "ion><Action Name=\"ImportExportText\"><Argument Name=\"SpecificationName\">ITEM "
        "Import Specification New</Argument><Argument Name=\"TableName\">Item Master</Arg"
        "ument><Argument Name=\""
End
Begin
    Comment ="_AXL:FileName\">S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\D"
        "ata\\ITEM04.CSV</Argument><Argument Name=\"HasFieldNames\">Yes</Argument></Actio"
        "n><Action Collapsed=\"true\" Name=\"OpenQuery\"><Argument Name=\"QueryName\">War"
        "ning-QryItem-NoBaseCost</Arg"
End
Begin
    Comment ="_AXL:ument></Action><Action Collapsed=\"true\" Name=\"OpenQuery\"><Argument Name"
        "=\"QueryName\">warning-QryItem-NoBasePrice</Argument></Action><Action Collapsed="
        "\"true\" Name=\"OpenQuery\"><Argument Name=\"QueryName\">warning-QrySel-ItemLead"
        "erNotSet-Wholesales</Argu"
End
Begin
    Comment ="_AXL:ment></Action><Action Collapsed=\"true\" Name=\"OpenQuery\"><Argument Name="
        "\"QueryName\">0-DelExport</Argument></Action><Action Collapsed=\"true\" Name=\"O"
        "penQuery\"><Argument Name=\"QueryName\">2-Update&amp;AppendExportTable</Argument"
        "></Action><Action Name=\"I"
End
Begin
    Comment ="_AXL:mportExportSpreadsheet\"><Argument Name=\"TransferType\">Export</Argument><"
        "Argument Name=\"TableName\">Item Master Export</Argument><Argument Name=\"FileNa"
        "me\">S:\\Shared_Everyone\\Business Reporting\\Shared\\Item Extract\\Export\\Item"
        "Dump.xlsx</Argument><Argum"
End
Begin
    Comment ="_AXL:ent Name=\"HasFieldNames\">Yes</Argument></Action><Action Name=\"Beep\"/><A"
        "ction Collapsed=\"true\" Name=\"QuitAccess\"><Argument Name=\"Options\">Exit</Ar"
        "gument></Action></Statements></UserInterfaceMacro>"
End
