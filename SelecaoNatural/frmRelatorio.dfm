object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rios'
  ClientHeight = 251
  ClientWidth = 635
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 344
    Top = 8
    Width = 249
    Height = 209
    Caption = 'Di'#225'rio'
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 29
      Width = 15
      Height = 13
      Caption = 'Dia'
    end
    object DateTimePicker1: TDateTimePicker
      Left = 24
      Top = 48
      Width = 186
      Height = 21
      Date = 42199.410346365740000000
      Format = 'dd.MM.yyyy'
      Time = 42199.410346365740000000
      TabOrder = 0
    end
    object RadioGroup1: TRadioGroup
      Left = 25
      Top = 75
      Width = 185
      Height = 78
      Caption = 'Formato'
      ItemIndex = 1
      Items.Strings = (
        'Anal'#237'tico'
        'Sint'#233'tico')
      TabOrder = 1
    end
    object Button1: TButton
      Left = 24
      Top = 168
      Width = 186
      Height = 25
      Caption = 'Imprimir'
      TabOrder = 2
      OnClick = Button1Click
    end
    object GroupBox2: TGroupBox
      Left = 267
      Top = 0
      Width = 249
      Height = 209
      TabOrder = 3
      object Label2: TLabel
        Left = 24
        Top = 29
        Width = 15
        Height = 13
        Caption = 'Dia'
      end
      object DateTimePicker2: TDateTimePicker
        Left = 24
        Top = 48
        Width = 186
        Height = 21
        Date = 42199.410346365740000000
        Time = 42199.410346365740000000
        TabOrder = 0
      end
      object RadioGroup2: TRadioGroup
        Left = 25
        Top = 75
        Width = 185
        Height = 78
        Caption = 'Formato'
        Items.Strings = (
          'Anal'#237'tico'
          'Sint'#233'tico')
        TabOrder = 1
      end
      object Button2: TButton
        Left = 24
        Top = 168
        Width = 186
        Height = 25
        Caption = 'Imprimir'
        TabOrder = 2
      end
      object GroupBox3: TGroupBox
        Left = 80
        Top = 24
        Width = 185
        Height = 105
        Caption = 'GroupBox3'
        TabOrder = 3
      end
      object GroupBox4: TGroupBox
        Left = 72
        Top = 40
        Width = 185
        Height = 105
        Caption = 'GroupBox4'
        TabOrder = 4
      end
    end
  end
  object GroupBox5: TGroupBox
    Left = 24
    Top = 8
    Width = 273
    Height = 209
    Caption = 'por Per'#237'odo'
    TabOrder = 1
    object Label3: TLabel
      Left = 16
      Top = 24
      Width = 36
      Height = 13
      Caption = 'Per'#237'odo'
    end
    object Label4: TLabel
      Left = 120
      Top = 43
      Width = 6
      Height = 13
      Caption = 'a'
    end
    object DateTimePicker3: TDateTimePicker
      Left = 8
      Top = 40
      Width = 106
      Height = 21
      Date = 42199.415990694450000000
      Time = 42199.415990694450000000
      TabOrder = 0
    end
    object DateTimePicker4: TDateTimePicker
      Left = 140
      Top = 40
      Width = 117
      Height = 21
      Date = 42199.416498553240000000
      Time = 42199.416498553240000000
      TabOrder = 1
    end
    object RadioGroup3: TRadioGroup
      Left = 16
      Top = 75
      Width = 241
      Height = 78
      Caption = 'Formato'
      ItemIndex = 1
      Items.Strings = (
        'Anal'#237'tico'
        'Sint'#233'tico')
      TabOrder = 2
    end
    object Button3: TButton
      Left = 40
      Top = 168
      Width = 185
      Height = 25
      Caption = 'Imprimir'
      TabOrder = 3
    end
  end
end
