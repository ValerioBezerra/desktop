inherited frmCadFUN: TfrmCadFUN
  Caption = 'Cadastro - Funcion'#225'rio'
  ClientHeight = 207
  ClientWidth = 616
  OnCreate = FormCreate
  ExplicitWidth = 622
  ExplicitHeight = 236
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Left = 495
    Height = 157
    ExplicitLeft = 495
    ExplicitHeight = 382
    inherited Panel5: TPanel
      Height = 147
      ExplicitHeight = 372
    end
    inherited Panel6: TPanel
      Top = 147
      ExplicitTop = 372
    end
    inherited Panel7: TPanel
      Height = 147
      ExplicitHeight = 372
    end
  end
  inherited stbInformacao: TStatusBar
    Top = 169
    Width = 616
    ExplicitTop = 394
    ExplicitWidth = 616
  end
  inherited stbStatus: TStatusBar
    Top = 188
    Width = 616
    ExplicitLeft = 8
    ExplicitTop = 419
    ExplicitWidth = 616
  end
  inherited Panel1: TPanel
    Width = 616
    ExplicitWidth = 616
  end
  inherited pnlPrincipal: TPanel
    Width = 495
    Height = 157
    ExplicitLeft = 8
    ExplicitTop = 6
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
      Width = 27
      Height = 13
      Caption = 'Nome'
      FocusControl = DBEdit2
    end
    object DBEdit1: TDBEdit
      Left = 13
      Top = 25
      Width = 134
      Height = 21
      DataField = 'CODIGO_FUN'
      DataSource = DataModule1.dsFUNCIONARIO
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 13
      Top = 71
      Width = 462
      Height = 21
      DataField = 'NOME_FUN'
      DataSource = DataModule1.dsFUNCIONARIO
      TabOrder = 1
    end
  end
end
