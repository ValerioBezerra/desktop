inherited frmGER001: TfrmGER001
  Caption = 'frmGER001'
  ClientHeight = 114
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  ExplicitWidth = 497
  ExplicitHeight = 143
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Height = 83
    ExplicitHeight = 83
    inherited btnFechar: TBitBtn
      Top = 46
      ExplicitTop = 46
    end
  end
  inherited Panel2: TPanel
    Height = 83
    ExplicitHeight = 83
  end
  inherited pnlPrincipal: TPanel
    Height = 83
    ExplicitHeight = 83
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
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object dbeGER_NOME_PAI: TDBEdit
      Left = 16
      Top = 52
      Width = 339
      Height = 21
      DataField = 'GER_NOME_PAI'
      DataSource = cmKingGeral.dsGER_PAI
      MaxLength = 60
      TabOrder = 1
    end
    object dbneGER_ID_PAI: TKsDBNumberEdit
      Left = 16
      Top = 14
      Width = 41
      Height = 21
      TabStop = False
      DataField = 'GER_ID_PAI'
      DataSource = cmKingGeral.dsGER_PAI
      Decimals = 0
      Enabled = False
      Negativo = False
      ReadOnly = True
      ShowSeparator = True
      TabOrder = 0
    end
  end
  inherited stbInformacao: TStatusBar
    Top = 95
    ExplicitTop = 95
  end
end