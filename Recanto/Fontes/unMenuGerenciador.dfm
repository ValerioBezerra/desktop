object MenuGerenciador: TMenuGerenciador
  Left = 0
  Top = 0
  Caption = 'Recanto - Gerenciador'
  ClientHeight = 558
  ClientWidth = 864
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
    Left = 128
    Top = 104
    object Licena1: TMenuItem
      Caption = 'Licen'#231'a'
      OnClick = Licena1Click
    end
    object Usurios1: TMenuItem
      Caption = 'Usu'#225'rios'
    end
  end
end
