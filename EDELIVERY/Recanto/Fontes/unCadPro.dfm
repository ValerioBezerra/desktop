inherited frmCadPro: TfrmCadPro
  Caption = 'Cadastro - Produto'
  ClientHeight = 227
  ClientWidth = 616
  OnCreate = FormCreate
  ExplicitWidth = 622
  ExplicitHeight = 256
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Left = 495
    Height = 177
    ExplicitLeft = 495
    ExplicitHeight = 279
    inherited Panel5: TPanel
      Height = 167
      ExplicitHeight = 269
    end
    inherited Panel6: TPanel
      Top = 167
      ExplicitTop = 269
    end
    inherited Panel7: TPanel
      Height = 167
      ExplicitHeight = 269
    end
  end
  inherited stbInformacao: TStatusBar
    Top = 189
    Width = 616
    ExplicitTop = 291
    ExplicitWidth = 616
  end
  inherited stbStatus: TStatusBar
    Top = 208
    Width = 616
    ExplicitTop = 310
    ExplicitWidth = 616
  end
  inherited Panel1: TPanel
    Width = 616
    ExplicitWidth = 616
  end
  inherited pnlPrincipal: TPanel
    Width = 495
    Height = 177
    ExplicitWidth = 495
    ExplicitHeight = 279
    object Label1: TLabel
      Left = 24
      Top = 12
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 24
      Top = 58
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBEdit2
    end
    object DBEdit1: TDBEdit
      Left = 24
      Top = 31
      Width = 134
      Height = 21
      Hint = 'O C'#243'digo ser'#225' gerado automaticamente.'
      DataField = 'COD_PRO'
      DataSource = DataModule1.dsPRO
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 24
      Top = 77
      Width = 446
      Height = 21
      DataField = 'NOME_PRO'
      DataSource = DataModule1.dsPRO
      TabOrder = 1
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 24
      Top = 115
      Width = 233
      Height = 54
      Caption = 'Tipo'
      Columns = 2
      DataField = 'TIPO_PRO'
      DataSource = DataModule1.dsPRO
      Items.Strings = (
        'Principal'
        'Acompanhamento')
      TabOrder = 2
      Values.Strings = (
        '1'
        '0')
    end
  end
end
