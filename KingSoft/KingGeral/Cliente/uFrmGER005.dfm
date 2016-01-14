inherited frmGER005: TfrmGER005
  Caption = 'frmGER005'
  ClientHeight = 127
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  ExplicitWidth = 497
  ExplicitHeight = 156
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Height = 96
    ExplicitHeight = 121
    inherited btnFechar: TBitBtn
      Left = 10
      Top = 61
      ExplicitLeft = 10
      ExplicitTop = 61
    end
  end
  inherited Panel2: TPanel
    Height = 96
    ExplicitHeight = 121
  end
  inherited pnlPrincipal: TPanel
    Height = 96
    ExplicitHeight = 121
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
    object dbeGER_DESCRICAO_TLG: TDBEdit
      Left = 16
      Top = 52
      Width = 339
      Height = 21
      DataField = 'GER_DESCRICAO_TLG'
      DataSource = cmKingGeral.dsGER_TLG
      MaxLength = 50
      TabOrder = 1
    end
    object dbneGER_ID_TLG: TKsDBNumberEdit
      Left = 16
      Top = 14
      Width = 41
      Height = 21
      TabStop = False
      DataField = 'GER_ID_TLG'
      DataSource = cmKingGeral.dsGER_TLG
      Decimals = 0
      Enabled = False
      Negativo = False
      ReadOnly = True
      ShowSeparator = True
      TabOrder = 0
    end
  end
  inherited stbInformacao: TStatusBar
    Top = 108
    ExplicitTop = 133
  end
end
