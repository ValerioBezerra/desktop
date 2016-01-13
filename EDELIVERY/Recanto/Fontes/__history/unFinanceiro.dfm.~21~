object frmFinanceiro: TfrmFinanceiro
  Left = 0
  Top = 0
  Caption = 'Financeiro'
  ClientHeight = 391
  ClientWidth = 677
  Color = clGradientInactiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 40
    Width = 661
    Height = 343
    ActivePage = TabSheet1
    Style = tsButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Hist'#243'rico do Cliente'
      ExplicitLeft = 12
      ExplicitTop = 35
      object Label1: TLabel
        Left = 3
        Top = 13
        Width = 33
        Height = 13
        Caption = 'Cliente'
      end
      object Label2: TLabel
        Left = 530
        Top = 211
        Width = 29
        Height = 13
        Caption = 'Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edCOD_CLI: TEdit
        Left = 3
        Top = 32
        Width = 57
        Height = 21
        TabOrder = 0
        OnExit = edCOD_CLIExit
      end
      object Button1: TButton
        Left = 66
        Top = 30
        Width = 33
        Height = 25
        Caption = '?'
        TabOrder = 1
        OnClick = Button1Click
      end
      object edNOME_CLI: TEdit
        Left = 112
        Top = 32
        Width = 273
        Height = 21
        Color = cl3DLight
        ReadOnly = True
        TabOrder = 2
      end
      object DateTimePicker1: TDateTimePicker
        Left = 408
        Top = 32
        Width = 105
        Height = 21
        Date = 42349.711845000000000000
        Time = 42349.711845000000000000
        TabOrder = 3
      end
      object DateTimePicker2: TDateTimePicker
        Left = 536
        Top = 32
        Width = 98
        Height = 21
        Date = 42349.712324780090000000
        Time = 42349.712324780090000000
        TabOrder = 4
      end
      object DBGrid1: TDBGrid
        Left = 3
        Top = 128
        Width = 510
        Height = 181
        DataSource = DataModule1.dsTELASCONSULTA
        TabOrder = 5
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'SEQ_PED'
            Title.Caption = 'Sequ'#234'ncia'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATA_PED'
            Title.Caption = 'Data'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR_PED'
            Title.Caption = 'Valor'
            Visible = True
          end>
      end
      object RadioGroup1: TRadioGroup
        Left = 3
        Top = 69
        Width = 233
        Height = 41
        Caption = 'Op'#231#227'o'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'Pagos'
          'Em Aberto'
          'Todos')
        TabOrder = 6
      end
      object Button2: TButton
        Left = 408
        Top = 85
        Width = 226
        Height = 25
        Caption = 'Carregar'
        TabOrder = 7
        OnClick = Button2Click
      end
      object edTotal: TEdit
        Left = 530
        Top = 230
        Width = 121
        Height = 21
        TabOrder = 8
        Text = 'R$ 0,00'
      end
      object Button3: TButton
        Left = 530
        Top = 284
        Width = 120
        Height = 25
        Caption = 'Imprimir'
        TabOrder = 9
        OnClick = Button3Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Baixar Contas em Aberto'
      ImageIndex = 1
    end
  end
  object ppReport1: TppReport
    AutoStop = False
    DataPipeline = ppBDEPipeline1
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279400
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'Screen'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    Left = 612
    Top = 227
    Version = '16.02'
    mmColumnWidth = 0
    DataPipelineName = 'ppBDEPipeline1'
    object ppHeaderBand1: TppHeaderBand
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 21960
      mmPrintPosition = 0
      object ppLabel1: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label1'
        Caption = 'Relat'#243'rio de Movimenta'#231#227'o do Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 13
        Font.Style = [fsBold]
        FormField = False
        Transparent = True
        mmHeight = 5027
        mmLeft = 61383
        mmTop = 4233
        mmWidth = 78317
        BandType = 0
        LayerName = Foreground
      end
      object ppSystemVariable1: TppSystemVariable
        DesignLayer = ppDesignLayer1
        UserName = 'SystemVariable1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        mmHeight = 4498
        mmLeft = 182034
        mmTop = 9790
        mmWidth = 19050
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel2: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label2'
        Caption = 'Pedido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        FormField = False
        Transparent = True
        mmHeight = 4762
        mmLeft = 14288
        mmTop = 15346
        mmWidth = 13229
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel3: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label3'
        Caption = 'Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        FormField = False
        Transparent = True
        mmHeight = 4762
        mmLeft = 37571
        mmTop = 15346
        mmWidth = 8467
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel4: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label4'
        Caption = 'Valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        FormField = False
        Transparent = True
        mmHeight = 4762
        mmLeft = 74101
        mmTop = 15346
        mmWidth = 9525
        BandType = 0
        LayerName = Foreground
      end
      object ppLine1: TppLine
        DesignLayer = ppDesignLayer1
        UserName = 'Line1'
        Weight = 0.750000000000000000
        mmHeight = 1852
        mmLeft = 529
        mmTop = 20105
        mmWidth = 202671
        BandType = 0
        LayerName = Foreground
      end
      object ppLabel7: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label7'
        Caption = 'Cliente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        FormField = False
        Transparent = True
        mmHeight = 4762
        mmLeft = 114829
        mmTop = 15346
        mmWidth = 14553
        BandType = 0
        LayerName = Foreground
      end
      object ppDBText4: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText4'
        DataField = 'NOME_CLI'
        DataPipeline = ppBDEPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        Transparent = True
        DataPipelineName = 'ppBDEPipeline1'
        mmHeight = 4498
        mmLeft = 131763
        mmTop = 15346
        mmWidth = 66411
        BandType = 0
        LayerName = Foreground
      end
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 8202
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText1'
        DataField = 'SEQ_PED'
        DataPipeline = ppBDEPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppBDEPipeline1'
        mmHeight = 4498
        mmLeft = 14288
        mmTop = 2641
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText2: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText2'
        DataField = 'DATA_PED'
        DataPipeline = ppBDEPipeline1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppBDEPipeline1'
        mmHeight = 4498
        mmLeft = 37839
        mmTop = 2641
        mmWidth = 24606
        BandType = 4
        LayerName = Foreground
      end
      object ppDBText3: TppDBText
        DesignLayer = ppDesignLayer1
        UserName = 'DBText3'
        DataField = 'VALOR_PED'
        DataPipeline = ppBDEPipeline1
        DisplayFormat = '$ ##.##'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppBDEPipeline1'
        mmHeight = 4498
        mmLeft = 75161
        mmTop = 2641
        mmWidth = 17198
        BandType = 4
        LayerName = Foreground
      end
    end
    object ppFooterBand1: TppFooterBand
      BeforePrint = ppFooterBand1BeforePrint
      Background.Brush.Style = bsClear
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
      object ppLabel5: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label5'
        Caption = 'Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        FormField = False
        Transparent = True
        mmHeight = 4498
        mmLeft = 151607
        mmTop = 3440
        mmWidth = 8466
        BandType = 8
        LayerName = Foreground
      end
      object lblTotal: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblTotal'
        Caption = 'R$0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = [fsBold]
        FormField = False
        Transparent = True
        mmHeight = 4762
        mmLeft = 168805
        mmTop = 3440
        mmWidth = 12435
        BandType = 8
        LayerName = Foreground
      end
      object ppLabel6: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'Label6'
        Caption = 'Situa'#231#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        FormField = False
        Transparent = True
        mmHeight = 4498
        mmLeft = 5027
        mmTop = 5556
        mmWidth = 16140
        BandType = 8
        LayerName = Foreground
      end
      object lblSituação: TppLabel
        DesignLayer = ppDesignLayer1
        UserName = 'lblSitua'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 11
        Font.Style = []
        FormField = False
        Transparent = True
        mmHeight = 4498
        mmLeft = 23813
        mmTop = 5556
        mmWidth = 793
        BandType = 8
        LayerName = Foreground
      end
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object ppBDEPipeline1: TppBDEPipeline
    DataSource = DataModule1.dsTELASCONSULTA
    UserName = 'BDEPipeline1'
    Left = 544
    Top = 232
  end
end
