inherited frmCadTMO: TfrmCadTMO
  Caption = 'Cadastro - Fornecedor'
  ClientHeight = 212
  ClientWidth = 616
  OnCreate = FormCreate
  ExplicitWidth = 622
  ExplicitHeight = 241
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Left = 495
    Height = 162
    ExplicitLeft = 495
    ExplicitHeight = 382
    inherited Panel5: TPanel
      Height = 152
      ExplicitHeight = 372
    end
    inherited Panel6: TPanel
      Top = 152
      ExplicitTop = 372
    end
    inherited Panel7: TPanel
      Height = 152
      ExplicitHeight = 372
    end
  end
  inherited stbInformacao: TStatusBar
    Top = 174
    Width = 616
    ExplicitTop = 394
    ExplicitWidth = 616
  end
  inherited stbStatus: TStatusBar
    Top = 193
    Width = 616
    ExplicitTop = 413
    ExplicitWidth = 616
  end
  inherited Panel1: TPanel
    Width = 616
    ExplicitWidth = 616
  end
  inherited pnlPrincipal: TPanel
    Width = 495
    Height = 162
    ExplicitWidth = 495
    ExplicitHeight = 382
    object Label1: TLabel
      Left = 16
      Top = 6
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 13
      Top = 52
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBEdit2
    end
    object DBEdit1: TDBEdit
      Left = 13
      Top = 25
      Width = 134
      Height = 21
      DataField = 'CODIGO_TMO'
      DataSource = DataModule1.dsESTTMO
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 13
      Top = 71
      Width = 462
      Height = 21
      DataField = 'DESCRICAO_TMO'
      DataSource = DataModule1.dsESTTMO
      TabOrder = 2
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 213
      Top = 27
      Width = 199
      Height = 38
      Columns = 2
      DataField = 'INDICADOR_TMO'
      DataSource = DataModule1.dsESTTMO
      Items.Strings = (
        'Entrada'
        'Saida')
      TabOrder = 1
      Values.Strings = (
        '1'
        '2')
    end
  end
  inherited timer: TTimer
    Left = 435
    Top = 16
  end
end
