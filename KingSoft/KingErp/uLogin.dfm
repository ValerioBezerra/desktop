object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'KingErp - Login'
  ClientHeight = 168
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 7
    Width = 49
    Height = 13
    Caption = 'Empresa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 9
    Top = 48
    Width = 274
    Height = 2
    Shape = bsBottomLine
  end
  object Label2: TLabel
    Left = 9
    Top = 53
    Width = 30
    Height = 13
    Caption = 'Login'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 9
    Top = 89
    Width = 35
    Height = 13
    Caption = 'Senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cbEmpresa: TComboBox
    Left = 9
    Top = 20
    Width = 274
    Height = 21
    Style = csDropDownList
    TabOrder = 0
  end
  object edtLogin: TEdit
    Left = 9
    Top = 66
    Width = 155
    Height = 21
    MaxLength = 20
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 9
    Top = 102
    Width = 155
    Height = 21
    MaxLength = 12
    PasswordChar = #8226
    TabOrder = 2
  end
  object Button1: TButton
    Left = 9
    Top = 133
    Width = 274
    Height = 25
    Caption = 'Entrar'
    TabOrder = 3
  end
end
