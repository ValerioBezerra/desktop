object frmPRINCIPAL: TfrmPRINCIPAL
  Left = 0
  Top = 0
  Caption = 'Sistema de Controle - Recanto'
  ClientHeight = 569
  ClientWidth = 909
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 192
    Top = 64
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object ContasaReceber1: TMenuItem
        Caption = 'Contas a Receber'
        object Cliente1: TMenuItem
          Caption = 'Cliente'
          OnClick = Cliente1Click
        end
      end
    end
  end
end
