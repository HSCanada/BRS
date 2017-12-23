Version =20
VersionRequired =20
Begin Report
    LayoutForPrint = NotDefault
    DividingLines = NotDefault
    AllowDesignChanges = NotDefault
    DateGrouping =1
    GrpKeepTogether =1
    PictureAlignment =2
    DatasheetGridlinesBehavior =3
    GridX =24
    GridY =24
    Width =11520
    DatasheetFontHeight =11
    ItemSuffix =233
    DatasheetGridlinesColor =15062992
    RecSrcDt = Begin
        0xa5905193ac3ae440
    End
    RecordSource ="qryCommStatementDetailReport"
    Caption ="CommStatementDetailReport"
    DatasheetFontName ="Calibri"
    PrtMip = Begin
        0x6801000068010000680100006801000000000000002d00002c01000001000000 ,
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
            ControlSource ="master_report_sort_id"
        End
        Begin BreakLevel
            SortOrder = NotDefault
            GroupHeader = NotDefault
            GroupFooter = NotDefault
            ControlSource ="source_cd"
        End
        Begin BreakLevel
            GroupHeader = NotDefault
            GroupFooter = NotDefault
            ControlSource ="source_cd"
        End
        Begin BreakLevel
            ControlSource ="customer_nm"
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
            Height =1800
            Name ="PageHeaderSection"
            Begin
                Begin TextBox
                    Enabled = NotDefault
                    FontItalic = NotDefault
                    IMESentenceMode =3
                    Width =10740
                    Height =480
                    FontSize =14
                    FontWeight =700
                    Name ="Text153"
                    ControlSource ="=\"HSC FSC Sales & Commission Details - \" & [fiscal_begin_dt] & \"-\" & [fiscal"
                        "_end_dt]"

                    LayoutCachedWidth =10740
                    LayoutCachedHeight =480
                End
                Begin TextBox
                    IMESentenceMode =3
                    Left =1740
                    Top =780
                    Width =4020
                    Height =270
                    TabIndex =1
                    Name ="Text154"
                    ControlSource ="salesperson_nm"

                    LayoutCachedLeft =1740
                    LayoutCachedTop =780
                    LayoutCachedWidth =5760
                    LayoutCachedHeight =1050
                    Begin
                        Begin Label
                            Left =60
                            Top =780
                            Width =1335
                            Height =270
                            FontSize =10
                            ForeColor =0
                            Name ="Label155"
                            Caption ="FSC NAME"
                            LayoutCachedLeft =60
                            LayoutCachedTop =780
                            LayoutCachedWidth =1395
                            LayoutCachedHeight =1050
                        End
                    End
                End
                Begin TextBox
                    IMESentenceMode =3
                    Left =1740
                    Top =1140
                    Width =4020
                    Height =270
                    TabIndex =2
                    Name ="Text156"
                    ControlSource ="comm_plan_nm"

                    LayoutCachedLeft =1740
                    LayoutCachedTop =1140
                    LayoutCachedWidth =5760
                    LayoutCachedHeight =1410
                    Begin
                        Begin Label
                            Left =60
                            Top =1140
                            Width =1320
                            Height =270
                            FontSize =10
                            ForeColor =0
                            Name ="Label157"
                            Caption ="FSC Plan"
                            LayoutCachedLeft =60
                            LayoutCachedTop =1140
                            LayoutCachedWidth =1380
                            LayoutCachedHeight =1410
                        End
                    End
                End
                Begin TextBox
                    IMESentenceMode =3
                    Left =1740
                    Top =1440
                    Width =4020
                    Height =270
                    TabIndex =3
                    Name ="Text158"
                    ControlSource ="salesperson_cd"

                    LayoutCachedLeft =1740
                    LayoutCachedTop =1440
                    LayoutCachedWidth =5760
                    LayoutCachedHeight =1710
                    Begin
                        Begin Label
                            Left =60
                            Top =1440
                            Width =1260
                            Height =270
                            FontSize =10
                            ForeColor =0
                            Name ="Label159"
                            Caption ="FSC Code"
                            LayoutCachedLeft =60
                            LayoutCachedTop =1440
                            LayoutCachedWidth =1320
                            LayoutCachedHeight =1710
                        End
                    End
                End
                Begin Rectangle
                    BackStyle =0
                    Top =600
                    Width =11520
                    Height =1200
                    Name ="Box160"
                    LayoutCachedTop =600
                    LayoutCachedWidth =11520
                    LayoutCachedHeight =1800
                End
            End
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            RepeatSection = NotDefault
            Height =660
            Name ="GroupHeader0"
            AlternateBackColor =11450043
            Begin
                Begin Rectangle
                    OldBorderStyle =0
                    Top =60
                    Width =11520
                    Height =600
                    BackColor =12765388
                    Name ="Box134"
                    LayoutCachedTop =60
                    LayoutCachedWidth =11520
                    LayoutCachedHeight =660
                End
                Begin Line
                    OldBorderStyle =1
                    Top =600
                    Width =11475
                    BorderColor =0
                    Name ="Line111"
                    LayoutCachedTop =600
                    LayoutCachedWidth =11475
                    LayoutCachedHeight =600
                End
                Begin Label
                    Top =60
                    Width =1020
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label169"
                    Caption ="Ship to #"
                    LayoutCachedTop =60
                    LayoutCachedWidth =1020
                    LayoutCachedHeight =540
                End
                Begin Label
                    TextAlign =1
                    Left =1080
                    Top =60
                    Width =1440
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label170"
                    Caption ="Customer Name"
                    LayoutCachedLeft =1080
                    LayoutCachedTop =60
                    LayoutCachedWidth =2520
                    LayoutCachedHeight =540
                End
                Begin Label
                    Left =2520
                    Top =60
                    Width =840
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label171"
                    Caption ="Order# / Vendor"
                    LayoutCachedLeft =2520
                    LayoutCachedTop =60
                    LayoutCachedWidth =3360
                    LayoutCachedHeight =540
                End
                Begin Label
                    Left =3360
                    Top =60
                    Width =900
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label172"
                    Caption ="Inv Date / Item #"
                    LayoutCachedLeft =3360
                    LayoutCachedTop =60
                    LayoutCachedWidth =4260
                    LayoutCachedHeight =540
                End
                Begin Label
                    Left =4320
                    Top =60
                    Width =1860
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label173"
                    Caption ="Item Description"
                    LayoutCachedLeft =4320
                    LayoutCachedTop =60
                    LayoutCachedWidth =6180
                    LayoutCachedHeight =540
                End
                Begin Label
                    TextAlign =3
                    Left =6240
                    Top =60
                    Width =1080
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label174"
                    Caption ="Sales $"
                    LayoutCachedLeft =6240
                    LayoutCachedTop =60
                    LayoutCachedWidth =7320
                    LayoutCachedHeight =540
                End
                Begin Label
                    TextAlign =3
                    Left =7380
                    Top =60
                    Width =1080
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label175"
                    Caption ="GP $"
                    LayoutCachedLeft =7380
                    LayoutCachedTop =60
                    LayoutCachedWidth =8460
                    LayoutCachedHeight =540
                End
                Begin Label
                    TextAlign =1
                    Left =9720
                    Top =60
                    Width =1740
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label177"
                    Caption ="Comm Group"
                    LayoutCachedLeft =9720
                    LayoutCachedTop =60
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =540
                End
                Begin Label
                    TextFontCharSet =0
                    TextAlign =3
                    Left =8520
                    Top =60
                    Width =1080
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label216"
                    Caption ="GP %"
                    LayoutCachedLeft =8520
                    LayoutCachedTop =60
                    LayoutCachedWidth =9600
                    LayoutCachedHeight =540
                End
            End
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            Height =0
            BreakLevel =2
            Name ="GroupHeader1"
            AlternateBackColor =16777215
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =600
            BreakLevel =3
            Name ="GroupHeader4"
            AlternateBackColor =15921906
            AlternateBackThemeColorIndex =1
            AlternateBackShade =95.0
            Begin
                Begin TextBox
                    FontUnderline = NotDefault
                    TextFontCharSet =0
                    IMESentenceMode =3
                    Left =60
                    Top =60
                    Width =11460
                    Height =480
                    FontSize =14
                    FontWeight =700
                    ForeColor =11830108
                    Name ="Text222"
                    ControlSource ="=IIf([source_cd]=\"IMPORT\",\"Additional GP$ Adjustments\",\"\")"

                    LayoutCachedLeft =60
                    LayoutCachedTop =60
                    LayoutCachedWidth =11520
                    LayoutCachedHeight =540
                End
            End
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            RepeatSection = NotDefault
            Height =360
            BreakLevel =5
            Name ="GroupHeader2"
            AlternateBackColor =16777215
            Begin
                Begin TextBox
                    IMESentenceMode =3
                    Top =60
                    Width =1080
                    Height =270
                    FontSize =10
                    FontWeight =700
                    Name ="hsi_shipto_id"
                    ControlSource ="hsi_shipto_id"

                    LayoutCachedTop =60
                    LayoutCachedWidth =1080
                    LayoutCachedHeight =330
                End
                Begin TextBox
                    IMESentenceMode =3
                    Left =1080
                    Top =60
                    Width =3240
                    Height =270
                    FontSize =10
                    FontWeight =700
                    TabIndex =1
                    Name ="customer_nm"
                    ControlSource ="customer_nm"

                    LayoutCachedLeft =1080
                    LayoutCachedTop =60
                    LayoutCachedWidth =4320
                    LayoutCachedHeight =330
                End
            End
        End
        Begin BreakHeader
            KeepTogether = NotDefault
            Height =300
            BreakLevel =6
            Name ="GroupHeader3"
            AlternateBackColor =16777215
            Begin
                Begin TextBox
                    IMESentenceMode =3
                    Left =2580
                    Width =780
                    Height =270
                    Name ="doc_id"
                    ControlSource ="doc_id"

                    LayoutCachedLeft =2580
                    LayoutCachedWidth =3360
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    TextAlign =1
                    IMESentenceMode =3
                    Left =3360
                    Width =1200
                    Height =255
                    ColumnWidth =2940
                    TabIndex =1
                    Name ="transaction_dt"
                    ControlSource ="transaction_dt"
                    Format ="Medium Date"

                    LayoutCachedLeft =3360
                    LayoutCachedWidth =4560
                    LayoutCachedHeight =255
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
                    Left =3360
                    Width =960
                    FontSize =8
                    Name ="hsi_item_id"
                    ControlSource ="hsi_item_id"

                    LayoutCachedLeft =3360
                    LayoutCachedWidth =4320
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextAlign =3
                    IMESentenceMode =3
                    Left =6240
                    Width =1080
                    FontSize =8
                    TabIndex =1
                    Name ="transaction_amt"
                    ControlSource ="transaction_amt"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =6240
                    LayoutCachedWidth =7320
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    TextFontCharSet =162
                    IMESentenceMode =3
                    Left =4320
                    Width =1935
                    FontSize =6
                    TabIndex =2
                    Name ="transaction_txt"
                    ControlSource ="transaction_txt"

                    LayoutCachedLeft =4320
                    LayoutCachedWidth =6255
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7380
                    Width =1080
                    FontSize =8
                    TabIndex =3
                    Name ="gp_ext_amt"
                    ControlSource ="gp_ext_amt"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7380
                    LayoutCachedWidth =8460
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    TextFontCharSet =162
                    IMESentenceMode =3
                    Left =9720
                    Width =1740
                    ColumnWidth =5550
                    FontSize =6
                    TabIndex =4
                    Name ="report_group_txt"
                    ControlSource ="report_group_txt"

                    LayoutCachedLeft =9720
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    IMESentenceMode =3
                    Left =2580
                    Width =780
                    Height =270
                    TabIndex =5
                    Name ="Text208"
                    ControlSource ="hsi_manuf_cd"

                    LayoutCachedLeft =2580
                    LayoutCachedWidth =3360
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8520
                    Width =1080
                    FontSize =8
                    TabIndex =6
                    Name ="Text217"
                    ControlSource ="=IIf([transaction_amt]<>0,[gp_ext_amt]/[transaction_amt],0)"
                    Format ="Percent"

                    LayoutCachedLeft =8520
                    LayoutCachedWidth =9600
                    LayoutCachedHeight =240
                End
            End
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =360
            BreakLevel =6
            Name ="GroupFooter7"
            Begin
                Begin TextBox
                    IMESentenceMode =3
                    Left =1080
                    Top =60
                    Width =1620
                    Height =270
                    FontSize =10
                    FontWeight =700
                    Name ="Text103"
                    ControlSource ="=\"Sub Total\""

                    LayoutCachedLeft =1080
                    LayoutCachedTop =60
                    LayoutCachedWidth =2700
                    LayoutCachedHeight =330
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextFontCharSet =162
                    TextAlign =3
                    IMESentenceMode =3
                    Left =6240
                    Top =60
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =1
                    Name ="sumoftransactionamt"
                    ControlSource ="=Sum([transaction_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =6240
                    LayoutCachedTop =60
                    LayoutCachedWidth =7320
                    LayoutCachedHeight =330
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextFontCharSet =162
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7380
                    Top =60
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =2
                    Name ="sumofGP"
                    ControlSource ="=Sum([gp_ext_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7380
                    LayoutCachedTop =60
                    LayoutCachedWidth =8460
                    LayoutCachedHeight =330
                End
                Begin Line
                    OldBorderStyle =1
                    Left =1140
                    Top =30
                    Width =10335
                    BorderColor =0
                    Name ="Line110"
                    LayoutCachedLeft =1140
                    LayoutCachedTop =30
                    LayoutCachedWidth =11475
                    LayoutCachedHeight =30
                End
                Begin TextBox
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8520
                    Top =60
                    Width =1080
                    FontSize =8
                    TabIndex =3
                    Name ="Text218"
                    ControlSource ="=IIf(Sum([transaction_amt])<>0,Sum([gp_ext_amt])/Sum([transaction_amt]),0)"
                    Format ="Percent"

                    LayoutCachedLeft =8520
                    LayoutCachedTop =60
                    LayoutCachedWidth =9600
                    LayoutCachedHeight =300
                End
            End
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =360
            BreakLevel =5
            BackColor =12765388
            Name ="GroupFooter6"
            Begin
                Begin TextBox
                    IMESentenceMode =3
                    Width =1080
                    Height =270
                    FontSize =10
                    FontWeight =700
                    Name ="Text113"
                    ControlSource ="hsi_shipto_id"

                    LayoutCachedWidth =1080
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    IMESentenceMode =3
                    Left =1080
                    Width =3240
                    Height =270
                    FontSize =10
                    FontWeight =700
                    TabIndex =1
                    Name ="Text114"
                    ControlSource ="customer_nm"

                    LayoutCachedLeft =1080
                    LayoutCachedWidth =4320
                    LayoutCachedHeight =270
                End
                Begin Line
                    LineSlant = NotDefault
                    OldBorderStyle =1
                    Top =300
                    Width =11520
                    BorderColor =0
                    Name ="Line115"
                    LayoutCachedTop =300
                    LayoutCachedWidth =11520
                    LayoutCachedHeight =300
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextFontCharSet =162
                    TextAlign =3
                    IMESentenceMode =3
                    Left =6240
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =2
                    Name ="Text116"
                    ControlSource ="=Sum([transaction_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =6240
                    LayoutCachedWidth =7320
                    LayoutCachedHeight =270
                End
                Begin TextBox
                    DecimalPlaces =2
                    TextFontCharSet =162
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7380
                    Width =1080
                    Height =270
                    FontSize =8
                    TabIndex =3
                    Name ="Text117"
                    ControlSource ="=Sum([gp_ext_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7380
                    LayoutCachedWidth =8460
                    LayoutCachedHeight =270
                End
                Begin Line
                    OldBorderStyle =1
                    Left =1140
                    Width =10380
                    BorderColor =0
                    Name ="Line126"
                    LayoutCachedLeft =1140
                    LayoutCachedWidth =11520
                End
                Begin TextBox
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8520
                    Width =1080
                    FontSize =8
                    TabIndex =4
                    Name ="Text219"
                    ControlSource ="=IIf(Sum([transaction_amt])<>0,Sum([gp_ext_amt])/Sum([transaction_amt]),0)"
                    Format ="Percent"

                    LayoutCachedLeft =8520
                    LayoutCachedWidth =9600
                    LayoutCachedHeight =240
                End
            End
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =0
            BreakLevel =3
            Name ="GroupFooter8"
        End
        Begin BreakFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            CanShrink = NotDefault
            Height =780
            BreakLevel =2
            Name ="GroupFooter5"
            Begin
                Begin Label
                    Visible = NotDefault
                    TextFontCharSet =0
                    TextAlign =3
                    Left =6180
                    Width =1080
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label224"
                    Caption ="Sales $"
                    LayoutCachedLeft =6180
                    LayoutCachedWidth =7260
                    LayoutCachedHeight =480
                End
                Begin Label
                    Visible = NotDefault
                    TextFontCharSet =0
                    TextAlign =3
                    Left =7320
                    Width =1080
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label225"
                    Caption ="GP $"
                    LayoutCachedLeft =7320
                    LayoutCachedWidth =8400
                    LayoutCachedHeight =480
                End
                Begin Label
                    Visible = NotDefault
                    TextFontCharSet =0
                    TextAlign =3
                    Left =8460
                    Width =1080
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label226"
                    Caption ="GP %"
                    LayoutCachedLeft =8460
                    LayoutCachedWidth =9540
                    LayoutCachedHeight =480
                End
                Begin TextBox
                    DecimalPlaces =0
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =6180
                    Top =300
                    Width =1140
                    Height =360
                    FontSize =10
                    FontWeight =700
                    Name ="Text227"
                    ControlSource ="=Sum([transaction_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =6180
                    LayoutCachedTop =300
                    LayoutCachedWidth =7320
                    LayoutCachedHeight =660
                End
                Begin TextBox
                    Visible = NotDefault
                    DecimalPlaces =0
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7380
                    Top =300
                    Width =1140
                    Height =360
                    FontSize =10
                    FontWeight =700
                    TabIndex =1
                    Name ="Text228"
                    ControlSource ="=Sum([gp_ext_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7380
                    LayoutCachedTop =300
                    LayoutCachedWidth =8520
                    LayoutCachedHeight =660
                End
                Begin Line
                    OldBorderStyle =1
                    Left =1080
                    Top =720
                    Width =8520
                    BorderColor =0
                    Name ="Line229"
                    LayoutCachedLeft =1080
                    LayoutCachedTop =720
                    LayoutCachedWidth =9600
                    LayoutCachedHeight =720
                End
                Begin TextBox
                    FontItalic = NotDefault
                    TextFontCharSet =0
                    IMESentenceMode =3
                    Left =1080
                    Top =300
                    Width =4260
                    Height =300
                    FontSize =12
                    FontWeight =700
                    TabIndex =2
                    Name ="Text230"
                    ControlSource ="=\"Subtotal \""

                    LayoutCachedLeft =1080
                    LayoutCachedTop =300
                    LayoutCachedWidth =5340
                    LayoutCachedHeight =600
                End
                Begin TextBox
                    Visible = NotDefault
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8580
                    Top =300
                    Width =960
                    Height =360
                    FontSize =10
                    FontWeight =700
                    TabIndex =3
                    Name ="Text231"
                    ControlSource ="=IIf(Sum([transaction_amt])<>0,Sum([gp_ext_amt])/Sum([transaction_amt]),0)"
                    Format ="Percent"

                    LayoutCachedLeft =8580
                    LayoutCachedTop =300
                    LayoutCachedWidth =9540
                    LayoutCachedHeight =660
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
            Height =360
            Name ="PageFooterSection"
            Begin
                Begin TextBox
                    TextAlign =1
                    IMESentenceMode =3
                    Left =60
                    Top =60
                    Width =4200
                    Height =300
                    Name ="Text63"
                    ControlSource ="=Now()"
                    Format ="General Date"

                    LayoutCachedLeft =60
                    LayoutCachedTop =60
                    LayoutCachedWidth =4260
                    LayoutCachedHeight =360
                End
                Begin Line
                    OldBorderStyle =1
                    BorderWidth =2
                    Width =11460
                    BorderColor =12632256
                    Name ="Line69"
                    GridlineColor =0
                    LayoutCachedWidth =11460
                End
                Begin TextBox
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7860
                    Top =60
                    Width =3600
                    Height =270
                    TabIndex =1
                    Name ="Text199"
                    ControlSource ="=\"Page \" & [Page] & \" of \" & [Pages]"

                    LayoutCachedLeft =7860
                    LayoutCachedTop =60
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =330
                End
            End
        End
        Begin FormFooter
            KeepTogether = NotDefault
            CanGrow = NotDefault
            Height =2220
            Name ="ReportFooter"
            Begin
                Begin Label
                    Visible = NotDefault
                    TextAlign =3
                    Left =6240
                    Width =1080
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label204"
                    Caption ="Sales $"
                    LayoutCachedLeft =6240
                    LayoutCachedWidth =7320
                    LayoutCachedHeight =480
                End
                Begin Label
                    Visible = NotDefault
                    TextAlign =3
                    Left =7380
                    Width =1080
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label205"
                    Caption ="GP $"
                    LayoutCachedLeft =7380
                    LayoutCachedWidth =8460
                    LayoutCachedHeight =480
                End
                Begin Subform
                    Locked = NotDefault
                    Top =1020
                    Width =11460
                    Height =479
                    Name ="subrptCommS-Import-HSFS"
                    SourceObject ="Report.subrptComm-Import-HSFS"
                    LinkChildFields ="salesperson_key_id"
                    LinkMasterFields ="salesperson_key_id"
                    EventProcPrefix ="subrptCommS_Import_HSFS"

                    LayoutCachedTop =1020
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =1499
                End
                Begin Label
                    Visible = NotDefault
                    TextFontCharSet =0
                    TextAlign =3
                    Left =8520
                    Width =1080
                    Height =480
                    FontSize =10
                    ForeColor =0
                    Name ="Label210"
                    Caption ="GP %"
                    LayoutCachedLeft =8520
                    LayoutCachedWidth =9600
                    LayoutCachedHeight =480
                End
                Begin TextBox
                    DecimalPlaces =0
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =6240
                    Top =300
                    Width =1140
                    Height =360
                    FontSize =10
                    FontWeight =700
                    TabIndex =1
                    Name ="Text211"
                    ControlSource ="=Sum([transaction_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =6240
                    LayoutCachedTop =300
                    LayoutCachedWidth =7380
                    LayoutCachedHeight =660
                End
                Begin TextBox
                    Visible = NotDefault
                    DecimalPlaces =0
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =7440
                    Top =300
                    Width =1140
                    Height =360
                    FontSize =10
                    FontWeight =700
                    TabIndex =2
                    Name ="Text212"
                    ControlSource ="=Sum([gp_ext_amt])"
                    Format ="$#,##0.00;($#,##0.00)"

                    LayoutCachedLeft =7440
                    LayoutCachedTop =300
                    LayoutCachedWidth =8580
                    LayoutCachedHeight =660
                End
                Begin Line
                    Visible = NotDefault
                    OldBorderStyle =1
                    Left =60
                    Top =240
                    Width =9540
                    BorderColor =0
                    Name ="Line214"
                    LayoutCachedLeft =60
                    LayoutCachedTop =240
                    LayoutCachedWidth =9600
                    LayoutCachedHeight =240
                End
                Begin TextBox
                    FontItalic = NotDefault
                    TextFontCharSet =0
                    IMESentenceMode =3
                    Left =60
                    Top =300
                    Width =5700
                    Height =300
                    FontSize =12
                    FontWeight =700
                    TabIndex =3
                    Name ="Text187"
                    ControlSource ="=\"Total  **\""

                    LayoutCachedLeft =60
                    LayoutCachedTop =300
                    LayoutCachedWidth =5760
                    LayoutCachedHeight =600
                End
                Begin Line
                    OldBorderStyle =1
                    BorderWidth =2
                    Left =60
                    Top =780
                    Width =9540
                    BorderColor =0
                    Name ="Line215"
                    LayoutCachedLeft =60
                    LayoutCachedTop =780
                    LayoutCachedWidth =9600
                    LayoutCachedHeight =780
                End
                Begin TextBox
                    Visible = NotDefault
                    DecimalPlaces =1
                    TextFontCharSet =0
                    TextAlign =3
                    IMESentenceMode =3
                    Left =8640
                    Top =300
                    Width =960
                    Height =360
                    FontSize =10
                    FontWeight =700
                    TabIndex =4
                    Name ="Text220"
                    ControlSource ="=IIf(Sum([transaction_amt])<>0,Sum([gp_ext_amt])/Sum([transaction_amt]),0)"
                    Format ="Percent"

                    LayoutCachedLeft =8640
                    LayoutCachedTop =300
                    LayoutCachedWidth =9600
                    LayoutCachedHeight =660
                End
                Begin TextBox
                    TextFontCharSet =0
                    IMESentenceMode =3
                    Top =1620
                    Width =11460
                    Height =480
                    FontSize =12
                    FontWeight =700
                    TabIndex =5
                    ForeColor =11830108
                    Name ="Text232"
                    ControlSource ="=\"** Above does not include manual adjustments\""

                    LayoutCachedTop =1620
                    LayoutCachedWidth =11460
                    LayoutCachedHeight =2100
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
