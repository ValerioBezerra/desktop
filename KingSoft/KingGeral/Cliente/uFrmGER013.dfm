inherited frmGER013: TfrmGER013
  Caption = 'frmGER013'
  ClientHeight = 153
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  ExplicitWidth = 497
  ExplicitHeight = 182
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Height = 122
    ExplicitHeight = 136
    inherited btnFechar: TBitBtn
      Top = 85
      ExplicitTop = 85
    end
  end
  inherited Panel2: TPanel
    Height = 122
    ExplicitHeight = 136
  end
  inherited pnlPrincipal: TPanel
    Height = 122
    ExplicitHeight = 136
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
      Left = 16
      Top = 39
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object dbeGER_DESCRICAO_FPG: TDBEdit
      Left = 16
      Top = 52
      Width = 339
      Height = 21
      DataField = 'GER_DESCRICAO_FPG'
      DataSource = cmKingGeral.dsGER_FPG
      MaxLength = 50
      TabOrder = 1
    end
    object dbneGER_ID_FPG: TKsDBNumberEdit
      Left = 16
      Top = 14
      Width = 41
      Height = 21
      TabStop = False
      DataField = 'GER_ID_FPG'
      DataSource = cmKingGeral.dsGER_FPG
      Decimals = 0
      Enabled = False
      Negativo = False
      ReadOnly = True
      ShowSeparator = True
      TabOrder = 0
    end
    object dbcbGER_GERATITULO_FPG: TDBCheckBox
      Left = 16
      Top = 91
      Width = 97
      Height = 17
      Caption = 'Gera T'#237'tulo'
      DataField = 'GER_GERATITULO_FPG'
      DataSource = cmKingGeral.dsGER_FPG
      TabOrder = 2
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  inherited stbInformacao: TStatusBar
    Top = 134
    ExplicitTop = 148
  end
end
