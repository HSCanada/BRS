Version =20
VersionRequired =20
Begin Report
    LayoutForPrint = NotDefault
    DividingLines = NotDefault
    AllowAdditions = NotDefault
    AllowDesignChanges = NotDefault
    DateGrouping =1
    GrpKeepTogether =1
    PictureAlignment =2
    DatasheetGridlinesBehavior =3
    GridX =24
    GridY =24
    Width =11400
    DatasheetFontHeight =11
    ItemSuffix =143
    DatasheetGridlinesColor =15062992
    RecSrcDt = Begin
        0x37e5e3d091a1e340
    End
    RecordSource ="qryCommStatementDetailReport-import-HSFS"
    Caption ="subrptCommS-Import-HSFS"
    DatasheetFontName ="Calibri"
    PrtMip = Begin
        0x68010000f000000068010000f000000000000000882c00006801000001000000 ,
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
            ControlSource ="comm_group_desc"
        End
        Begin BreakLevel
            GroupHeader = NotDefault
            GroupFooter = NotDefault
            ControlSource ="source_cd"
        End
        Begin BreakLevel
            SortOrder = NotDefault
            GroupHeader = NotDefault
            GroupFooter = NotDefault
            ControlSource ="hsi_shipto_id"
        End
        Begin BreakLevel
            GroupHeader = NotDefault
            GroupFooter = NotDefault
            ControlSource ="doc_key_id"
        End
        Begin BreakLevel
            ControlSource ="transaction_dt"
        End
        Begin BreakLevel
            ControlSource ="line_id"
        End
        Begin FormHeader
            KeepTogether = NotDefault
            Height =0
            Name ="ReportHeader"
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
                    Left =60
                    Top =60
                    Width =11340
                    BorderColor =0
                    Name ="Line111"
                    LayoutCachedLeft =60
                    LayoutCachedTop =60
                    LayoutCachedWidth =11400
                    LayoutCachedHeight =60
                End
            End
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            Height =540
            BreakLevel =1
            Name ="GroupHeader1"
            AlternateBackColor =16777215
            Begin
                Begin TextBox
                    IMESentenceMode =3
                    Left =1080
                    Top =60
                    Width =4215
                    Height =270
                    ColumnWidth =5550
                    FontWeight =700
                    Name ="Text129"
                    ControlSource ="comm_group_desc"

                    LayoutCachedLeft =1080
                    LayoutCachedTop =60
                    LayoutCachedWidth =5295
                    LayoutCachedHeight =330
                End
                Begin Label
                    TextFontCharSet =0
                    TextAlign =3
                    Left =6120
                    Width =1080
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label174"
                    Caption ="Sales $"
                    LayoutCachedLeft =6120
                    LayoutCachedWidth =7200
                    LayoutCachedHeight =480
                End
                Begin Label
                    TextFontCharSet =0
                    TextAlign =3
                    Left =7260
                    Width =1080
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label175"
                    Caption ="GP $"
                    LayoutCachedLeft =7260
                    LayoutCachedWidth =8340
                    LayoutCachedHeight =480
                End
                Begin Label
                    TextFontCharSet =0
                    TextAlign =3
                    Left =8460
                    Width =1080
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label216"
                    Caption ="GP %"
                    LayoutCachedLeft =8460
                    LayoutCachedWidth =9540
                    LayoutCachedHeight =480
                End
                Begin Label
                    TextFontCharSet =0
                    TextAlign =3
                    Left =10080
                    Width =1080
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label142"
                    Caption ="Comm $"
                    LayoutCachedLeft =10080
                    LayoutCachedWidth =11160
                    LayoutCachedHeight =480
                End
            End
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =0
            BreakLevel =2
            Name ="GroupHeader9"
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            Height =0
            BreakLevel =3
            Name ="GroupHeader2"
            AlternateBackColor =16777215
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            Height =0
            BreakLevel =4
            Name ="GroupHeader3"
            AlternateBackColor =16777215
        End
        Begin Section
            KeepTogether = NotDefault
            CanGrow = NotDefault
            Height =300
            Name ="Detail"
            AlternateBackColor =16777215
            Begin
                Begin TextBox
                    IMESentenceMode =3
                    Left =3660
                    Width =2580
                    FontSize =10
                    FontWeight =700
                    Name ="transaction_txt"
                    ControlSource ="transaction_txt"

                    LayoutCachedLeft =3660
                    LayoutCachedWidth =6240
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextAlign =3
                    IMESentenceMode =3
                    Left =6239
                    Width =1080
                    FontSize =8
                    TabIndex =1
                    Name ="transaction_amt"
                    ControlSource ="transaction_amt"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =6239
                    LayoutCachedWidth =7319
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7380
                    Width =1080
                    FontSize =8
                    TabIndex =2
                    Name ="gp_ext_amt"
                    ControlSource ="gp_ext_amt"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7380
                    LayoutCachedWidth =8460
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextAlign =3
                    IMESentenceMode =3
                    Left =10080
                    Width =1080
                    FontSize =8
                    TabIndex =3
                    Name ="comm_amt"
                    ControlSource ="comm_amt"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =10080
                    LayoutCachedWidth =11160
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    IMESentenceMode =3
                    Left =1080
                    Width =2535
                    Height =270
                    TabIndex =4
                    Name ="customer_nm"
                    ControlSource ="customer_nm"

                    LayoutCachedLeft =1080
                    LayoutCachedWidth =3615
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8460
                    Width =1080
                    FontSize =8
                    TabIndex =5
                    Name ="Text140"
                    ControlSource ="=IIf([transaction_amt]<>0,[gp_ext_amt]/[transaction_amt],0)"
                    Format ="Percent"

                    LayoutCachedLeft =8460
                    LayoutCachedWidth =9540
                    LayoutCachedHeight =240
                End
            End
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =0
            BreakLevel =4
            Name ="GroupFooter7"
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =0
            BreakLevel =3
            BackColor =12765388
            Name ="GroupFooter6"
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =0
            BreakLevel =2
            Name ="GroupFooter8"
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =420
            BreakLevel =1
            Name ="GroupFooter5"
            Begin
                Begin TextBox
                    IMESentenceMode =3
                    Left =1080
                    Width =2400
                    Height =300
                    FontWeight =700
                    Name ="Text134"
                    ControlSource ="=\"Total HSFS (revenue)\""

                    LayoutCachedLeft =1080
                    LayoutCachedWidth =3480
                    LayoutCachedHeight =300
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextAlign =3
                    IMESentenceMode =3
                    Left =6239
                    Width =1080
                    FontSize =8
                    TabIndex =1
                    Name ="Text136"
                    ControlSource ="=Sum([transaction_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =6239
                    LayoutCachedWidth =7319
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7380
                    Width =1080
                    FontSize =8
                    TabIndex =2
                    Name ="Text137"
                    ControlSource ="=Sum([gp_ext_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7380
                    LayoutCachedWidth =8460
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextAlign =3
                    IMESentenceMode =3
                    Left =10080
                    Width =1080
                    FontSize =8
                    TabIndex =3
                    Name ="Text138"
                    ControlSource ="=Sum([comm_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =10080
                    LayoutCachedWidth =11160
                    LayoutCachedHeight =240
                End
                Begin Line
                    OldBorderStyle =1
                    BorderWidth =2
                    Top =300
                    Width =11400
                    Height =15
                    BorderColor =0
                    Name ="Line139"
                    LayoutCachedTop =300
                    LayoutCachedWidth =11400
                    LayoutCachedHeight =315
                End
                Begin Line
                    LineSlant = NotDefault
                    OldBorderStyle =1
                    Left =1080
                    Width =10320
                    BorderColor =0
                    Name ="Line110"
                    LayoutCachedLeft =1080
                    LayoutCachedWidth =11400
                End
                Begin TextBox
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8460
                    Width =1080
                    FontSize =8
                    TabIndex =4
                    Name ="Text141"
                    ControlSource ="=IIf(Sum([transaction_amt])<>0,Sum([gp_ext_amt])/Sum([transaction_amt]),0)"
                    Format ="Percent"

                    LayoutCachedLeft =8460
                    LayoutCachedWidth =9540
                    LayoutCachedHeight =240
                End
            End
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =0
            BackColor =12765388
            Name ="GroupFooter4"
            AutoHeight =255
        End
        Begin PageFooter
            Height =0
            Name ="PageFooterSection"
        End
        Begin FormFooter
            KeepTogether = NotDefault
            Height =0
            Name ="ReportFooter"
            AutoHeight =1
        End
    End
End
CodeBehindForm
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database
