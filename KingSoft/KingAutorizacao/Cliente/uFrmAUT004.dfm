inherited frmAUT004: TfrmAUT004
  Caption = 'frmAUT004'
  ClientHeight = 148
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  ExplicitWidth = 497
  ExplicitHeight = 177
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Height = 117
    ExplicitHeight = 117
    inherited btnFechar: TBitBtn
      Top = 83
      ExplicitTop = 83
    end
  end
  inherited Panel2: TPanel
    Height = 117
    ExplicitHeight = 117
  end
  inherited pnlPrincipal: TPanel
    Height = 117
    ExplicitHeight = 117
    object Label1: TLabel
      Left = 16
      Top = 1
      Width = 12
      Height = 13
      Caption = 'Id'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 68
      Top = 39
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label3: TLabel
      Left = 16
      Top = 39
      Width = 22
      Height = 13
      Caption = 'Sigla'
    end
    object Label4: TLabel
      Left = 16
      Top = 77
      Width = 53
      Height = 13
      Caption = 'Execut'#225'vel'
    end
    object sbAUT_EXECUTAVEL_MOD: TSpeedButton
      Left = 280
      Top = 89
      Width = 23
      Height = 23
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555FFFFFFFFFF55555000000000055555577777777775FFFF00B8B8B8B8B0
        0000775F5555555777770B0B8B8B8B8B0FF07F75F555555575F70FB0B8B8B8B8
        B0F07F575FFFFFFFF7F70BFB0000000000F07F557777777777570FBFBF0FFFFF
        FFF07F55557F5FFFFFF70BFBFB0F000000F07F55557F777777570FBFBF0FFFFF
        FFF075F5557F5FFFFFF750FBFB0F000000F0575FFF7F777777575700000FFFFF
        FFF05577777F5FF55FF75555550F00FF00005555557F775577775555550FFFFF
        0F055555557F55557F755555550FFFFF00555555557FFFFF7755555555000000
        0555555555777777755555555555555555555555555555555555}
      NumGlyphs = 2
      OnClick = sbAUT_EXECUTAVEL_MODClick
    end
    object Label5: TLabel
      Left = 309
      Top = 77
      Width = 32
      Height = 13
      Caption = 'Ordem'
    end
    object dbeAUT_DESCRICAO_MOD: TDBEdit
      Left = 68
      Top = 52
      Width = 287
      Height = 21
      DataField = 'AUT_DESCRICAO_MOD'
      DataSource = cmKingAutorizacao.dsAUT_MOD
      MaxLength = 50
      TabOrder = 2
    end
    object dbneAUT_ID_MOD: TKsDBNumberEdit
      Left = 16
      Top = 14
      Width = 41
      Height = 21
      TabStop = False
      DataField = 'AUT_ID_MOD'
      DataSource = cmKingAutorizacao.dsAUT_MOD
      Decimals = 0
      Enabled = False
      Negativo = False
      ReadOnly = True
      ShowSeparator = True
      TabOrder = 0
    end
    object dbeAUT_SIGLA_MOD: TDBEdit
      Left = 16
      Top = 52
      Width = 46
      Height = 21
      CharCase = ecUpperCase
      DataField = 'AUT_SIGLA_MOD'
      DataSource = cmKingAutorizacao.dsAUT_MOD
      MaxLength = 3
      TabOrder = 1
    end
    object dbeAUT_EXECUTAVEL_MOD: TDBEdit
      Left = 16
      Top = 90
      Width = 266
      Height = 21
      Hint = '(F1) Procurar Execut'#225'vel'
      DataField = 'AUT_EXECUTAVEL_MOD'
      DataSource = cmKingAutorizacao.dsAUT_MOD
      MaxLength = 25
      TabOrder = 3
      OnKeyDown = dbeAUT_EXECUTAVEL_MODKeyDown
    end
    object dbneAUT_ORDEM_MOD: TKsDBNumberEdit
      Left = 309
      Top = 89
      Width = 46
      Height = 21
      DataField = 'AUT_ORDEM_MOD'
      DataSource = cmKingAutorizacao.dsAUT_MOD
      Decimals = 0
      Negativo = False
      MaxLength = 3
      ShowSeparator = True
      TabOrder = 4
    end
  end
  inherited stbInformacao: TStatusBar
    Top = 129
    ExplicitTop = 129
  end
  object FileOpenDialog: TFileOpenDialog
    DefaultExtension = '*.exe'
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    Left = 280
    Top = 16
  end
end
