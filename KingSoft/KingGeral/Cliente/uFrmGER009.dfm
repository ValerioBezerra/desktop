inherited frmGER009: TfrmGER009
  Caption = 'frmGER009'
  ClientHeight = 167
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  ExplicitWidth = 497
  ExplicitHeight = 196
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Height = 136
    ExplicitHeight = 121
    inherited btnFechar: TBitBtn
      Top = 85
      ExplicitTop = 85
    end
  end
  inherited Panel2: TPanel
    Height = 136
    ExplicitHeight = 121
  end
  inherited pnlPrincipal: TPanel
    Height = 136
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
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object dbeGER_DESCRICAO_TPP: TDBEdit
      Left = 16
      Top = 52
      Width = 339
      Height = 21
      DataField = 'GER_DESCRICAO_TPP'
      DataSource = cmKingGeral.dsGER_TPP
      MaxLength = 50
      TabOrder = 1
    end
    object dbneGER_ID_TPP: TKsDBNumberEdit
      Left = 16
      Top = 14
      Width = 41
      Height = 21
      TabStop = False
      DataField = 'GER_ID_TPP'
      DataSource = cmKingGeral.dsGER_TPP
      Decimals = 0
      Enabled = False
      Negativo = False
      ReadOnly = True
      ShowSeparator = True
      TabOrder = 0
    end
    object dbrgGER_TIPO_TPP: TDBRadioGroup
      Left = 16
      Top = 79
      Width = 265
      Height = 47
      Caption = 'Tipo'
      Columns = 3
      DataField = 'GER_TIPO_TPP'
      DataSource = cmKingGeral.dsGER_TPP
      Items.Strings = (
        'Cliente'
        'Fornecedor'
        'Outros')
      TabOrder = 2
      Values.Strings = (
        'C'
        'F'
        'O')
    end
  end
  inherited stbInformacao: TStatusBar
    Top = 148
    ExplicitTop = 133
  end
end
