inherited frmCadEnt: TfrmCadEnt
  Caption = 'Cadastro - Entregador'
  ClientHeight = 160
  ClientWidth = 616
  OnCreate = FormCreate
  ExplicitWidth = 622
  ExplicitHeight = 189
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Left = 495
    Height = 110
    ExplicitLeft = 495
    ExplicitHeight = 177
    inherited Panel5: TPanel
      Height = 100
      ExplicitHeight = 167
    end
    inherited Panel6: TPanel
      Top = 100
      ExplicitTop = 167
    end
    inherited Panel7: TPanel
      Height = 100
      ExplicitHeight = 167
      inherited btnFechar: TBitBtn
        Left = 4
        Top = 68
        ExplicitLeft = 4
        ExplicitTop = 68
      end
    end
  end
  inherited stbInformacao: TStatusBar
    Top = 122
    Width = 616
    ExplicitTop = 189
    ExplicitWidth = 616
  end
  inherited stbStatus: TStatusBar
    Top = 141
    Width = 616
    ExplicitTop = 208
    ExplicitWidth = 616
  end
  inherited Panel1: TPanel
    Width = 616
    ExplicitWidth = 616
  end
  inherited pnlPrincipal: TPanel
    Width = 495
    Height = 110
    ExplicitWidth = 495
    ExplicitHeight = 177
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
      DataField = 'COD_ENT'
      DataSource = DataModule1.dsENT
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 24
      Top = 77
      Width = 446
      Height = 21
      DataField = 'NOME_ENT'
      DataSource = DataModule1.dsENT
      TabOrder = 1
    end
  end
end
