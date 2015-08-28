inherited frmCadGRP: TfrmCadGRP
  Caption = 'Cadastro - Grupo'
  ClientHeight = 161
  ClientWidth = 616
  OnCreate = FormCreate
  ExplicitWidth = 622
  ExplicitHeight = 190
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Left = 495
    Height = 111
    ExplicitLeft = 495
    ExplicitHeight = 382
    inherited Panel5: TPanel
      Height = 101
      ExplicitHeight = 372
    end
    inherited Panel6: TPanel
      Top = 101
      ExplicitTop = 372
    end
    inherited Panel7: TPanel
      Height = 101
      ExplicitHeight = 372
      inherited btnFechar: TBitBtn
        Left = 10
        Top = 62
        ExplicitLeft = 10
        ExplicitTop = 62
      end
    end
  end
  inherited stbInformacao: TStatusBar
    Top = 123
    Width = 616
    ExplicitTop = 394
    ExplicitWidth = 616
  end
  inherited stbStatus: TStatusBar
    Top = 142
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
    Height = 111
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
      DataField = 'CODIGO_GRP'
      DataSource = DataModule1.dsESTGRP
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 13
      Top = 71
      Width = 462
      Height = 21
      DataField = 'DESCRICAO_GRP'
      DataSource = DataModule1.dsESTGRP
      TabOrder = 1
    end
  end
end
