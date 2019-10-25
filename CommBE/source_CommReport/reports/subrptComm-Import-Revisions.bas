Version =20
VersionRequired =20
Begin Report
    LayoutForPrint = NotDefault
    DividingLines = NotDefault
    AllowAdditions = NotDefault
    AllowDesignChanges = NotDefault
    DateGrouping =1
    PictureAlignment =2
    DatasheetGridlinesBehavior =3
    GridX =24
    GridY =24
    Width =11400
    DatasheetFontHeight =11
    ItemSuffix =147
    Left =345
    Top =9480
    DatasheetGridlinesColor =15062992
    RecSrcDt = Begin
        0x342bc794f8a0e340
    End
    RecordSource ="qryCommStatementDetailReport-import-Revisions"
    Caption ="subrptComm-Import-Revisions"
    DatasheetFontName ="Calibri"
    PrtMip = Begin
        0x0000000000000000000000000000000000000000882c00002c01000001000000 ,
        0x010000006801000000000000a10700000100000001000000
    End
    FilterOnLoad =0
    FitToPage =1
    DisplayOnSharePointSite =1
    DatasheetAlternateBackColor =16053492
    DatasheetGridlinesColor12 =15062992
    FitToScreen =1
    Begin
        Begin Label
            BackStyle =0
            TextFontCharSet =161
            FontSize =9
            FontWeight =700
            BorderColor =5066944
            ForeColor =11830108
            FontName ="Calibri"
            GridlineColor =-2147483609
        End
        Begin Rectangle
            BorderLineStyle =0
            BackColor =5054976
            BorderColor =-2147483617
            GridlineColor =-2147483609
        End
        Begin Line
            OldBorderStyle =0
            BorderLineStyle =0
            BorderColor =5066944
            GridlineColor =-2147483609
        End
        Begin Image
            BorderLineStyle =0
            SizeMode =3
            PictureAlignment =2
            BackColor =5054976
            BorderColor =-2147483617
            GridlineColor =-2147483609
        End
        Begin CommandButton
            TextFontCharSet =161
            FontSize =9
            FontWeight =400
            ForeColor =14919545
            FontName ="Calibri"
            GridlineColor =-2147483609
            BorderLineStyle =0
        End
        Begin OptionButton
            OldBorderStyle =0
            BorderLineStyle =0
            LabelX =230
            LabelY =-30
            BorderColor =5066944
            GridlineColor =-2147483609
        End
        Begin CheckBox
            BorderLineStyle =0
            LabelX =230
            LabelY =-30
            GridlineColor =-2147483609
        End
        Begin OptionGroup
            OldBorderStyle =0
            BorderLineStyle =0
            BorderColor =5066944
        End
        Begin BoundObjectFrame
            SizeMode =3
            OldBorderStyle =0
            BorderLineStyle =0
            BackStyle =0
            LabelX =-1800
            BorderColor =5066944
            GridlineColor =-2147483609
        End
        Begin TextBox
            FELineBreak = NotDefault
            OldBorderStyle =0
            TextFontCharSet =161
            BorderLineStyle =0
            BackStyle =0
            LabelX =-1800
            FontSize =9
            BorderColor =5066944
            FontName ="Calibri"
            AsianLineBreak =1
            GridlineColor =-2147483609
            ShowDatePicker =0
        End
        Begin ListBox
            TextFontCharSet =161
            OldBorderStyle =0
            BorderLineStyle =0
            LabelX =-1800
            FontSize =9
            BorderColor =5066944
            FontName ="Calibri"
            GridlineColor =-2147483609
            AllowValueListEdits =1
            InheritValueList =1
        End
        Begin ComboBox
            OldBorderStyle =0
            TextFontCharSet =161
            BorderLineStyle =0
            BackStyle =0
            LabelX =-1800
            FontSize =9
            BorderColor =5066944
            FontName ="Calibri"
            GridlineColor =-2147483609
            AllowValueListEdits =1
            InheritValueList =1
        End
        Begin Subform
            BorderLineStyle =0
            BorderColor =5066944
            GridlineColor =-2147483609
        End
        Begin UnboundObjectFrame
            BackStyle =0
            BorderColor =5066944
            GridlineColor =-2147483609
        End
        Begin CustomControl
            OldBorderStyle =1
            BorderColor =5066944
            GridlineColor =-2147483609
        End
        Begin ToggleButton
            TextFontCharSet =161
            FontSize =9
            FontWeight =400
            ForeColor =14919545
            FontName ="Calibri"
            GridlineColor =-2147483609
            BorderLineStyle =0
        End
        Begin Tab
            TextFontCharSet =161
            BackStyle =0
            FontSize =9
            FontName ="Calibri"
            BorderLineStyle =0
        End
        Begin BreakLevel
            GroupHeader = NotDefault
            GroupFooter = NotDefault
            ControlSource ="salesperson_key_id"
        End
        Begin BreakLevel
            GroupHeader = NotDefault
            GroupFooter = NotDefault
            ControlSource ="report_group_txt"
        End
        Begin BreakLevel
            ControlSource ="transaction_dt"
        End
        Begin BreakLevel
            ControlSource ="line_id"
        End
        Begin FormHeader
            KeepTogether = NotDefault
            Height =480
            Name ="ReportHeader"
            Begin
                Begin TextBox
                    FontItalic = NotDefault
                    TextFontCharSet =162
                    IMESentenceMode =3
                    Left =1080
                    Top =60
                    Width =4560
                    Height =420
                    ColumnWidth =3480
                    FontSize =12
                    FontWeight =700
                    Name ="master_report_group_txt"
                    ControlSource ="master_report_group_txt"

                    LayoutCachedLeft =1080
                    LayoutCachedTop =60
                    LayoutCachedWidth =5640
                    LayoutCachedHeight =480
                End
            End
        End
        Begin PageHeader
            Height =0
            Name ="PageHeaderSection"
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            Height =120
            Name ="GroupHeader0"
            AlternateBackColor =16777215
            Begin
                Begin Line
                    OldBorderStyle =1
                    Top =60
                    Width =11400
                    BorderColor =0
                    Name ="Line111"
                    LayoutCachedTop =60
                    LayoutCachedWidth =11400
                    LayoutCachedHeight =60
                End
            End
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            Height =315
            BreakLevel =1
            Name ="GroupHeader1"
            AlternateBackColor =16777215
            Begin
                Begin TextBox
                    TextFontCharSet =162
                    IMESentenceMode =3
                    Left =1080
                    Width =3840
                    Height =270
                    FontSize =10
                    FontWeight =700
                    Name ="Text129"
                    ControlSource ="report_group_txt"

                    LayoutCachedLeft =1080
                    LayoutCachedWidth =4920
                    LayoutCachedHeight =270
                End
                Begin Line
                    OldBorderStyle =1
                    Left =1080
                    Top =300
                    Width =10275
                    BorderColor =0
                    Name ="Line140"
                    LayoutCachedLeft =1080
                    LayoutCachedTop =300
                    LayoutCachedWidth =11355
                    LayoutCachedHeight =300
                End
            End
        End
        Begin Section
            KeepTogether = NotDefault
            Height =300
            Name ="Detail"
            AlternateBackColor =16777215
            Begin
                Begin TextBox
                    IMESentenceMode =3
                    Left =3359
                    Top =60
                    Width =3060
                    FontSize =8
                    Name ="transaction_txt"
                    ControlSource ="transaction_txt"

                    LayoutCachedLeft =3359
                    LayoutCachedTop =60
                    LayoutCachedWidth =6419
                    LayoutCachedHeight =300
                End
                Begin TextBox
                    DecimalPlaces =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8519
                    Width =1080
                    FontSize =8
                    TabIndex =1
                    Name ="comm_amt"
                    ControlSource ="comm_amt"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =8519
                    LayoutCachedWidth =9599
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    IMESentenceMode =3
                    Left =1080
                    Top =60
                    Width =2220
                    FontSize =8
                    TabIndex =2
                    Name ="Text139"
                    ControlSource ="customer_nm"

                    LayoutCachedLeft =1080
                    LayoutCachedTop =60
                    LayoutCachedWidth =3300
                    LayoutCachedHeight =300
                End
            End
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =270
            BreakLevel =1
            Name ="GroupFooter5"
            Begin
                Begin TextBox
                    IMESentenceMode =3
                    Left =1080
                    Width =3060
                    Height =270
                    FontSize =10
                    FontWeight =700
                    Name ="Text141"
                    ControlSource ="=\"Total \" & [report_group_txt]"

                    LayoutCachedLeft =1080
                    LayoutCachedWidth =4140
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    DecimalPlaces =0
                    TextFontCharSet =162
                    IMESentenceMode =3
                    Left =8519
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =1
                    Name ="Text142"
                    ControlSource ="=Sum([comm_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =8519
                    LayoutCachedWidth =9599
                    LayoutCachedHeight =270
                End
                Begin Line
                    OldBorderStyle =1
                    Left =1080
                    Width =10305
                    BorderColor =0
                    Name ="Line143"
                    LayoutCachedLeft =1080
                    LayoutCachedWidth =11385
                End
            End
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =0
            Name ="GroupFooter4"
        End
        Begin PageFooter
            Height =0
            Name ="PageFooterSection"
        End
        Begin FormFooter
            KeepTogether = NotDefault
            Height =540
            Name ="ReportFooter"
            Begin
                Begin TextBox
                    FontItalic = NotDefault
                    TextFontCharSet =162
                    IMESentenceMode =3
                    Left =1080
                    Width =4680
                    Height =480
                    FontSize =12
                    FontWeight =700
                    Name ="Text145"
                    ControlSource ="=\"Total \" & [master_report_group_txt]"

                    LayoutCachedLeft =1080
                    LayoutCachedWidth =5760
                    LayoutCachedHeight =480
                End
                Begin TextBox
                    DecimalPlaces =0
                    TextFontCharSet =162
                    IMESentenceMode =3
                    Left =8519
                    Top =60
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =1
                    Name ="Text146"
                    ControlSource ="=Sum([comm_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =8519
                    LayoutCachedTop =60
                    LayoutCachedWidth =9599
                    LayoutCachedHeight =330
                End
            End
        End
    End
End
CodeBehindForm
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
