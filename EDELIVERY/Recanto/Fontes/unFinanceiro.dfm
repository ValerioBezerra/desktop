object frmFinanceiro: TfrmFinanceiro
  Left = 0
  Top = 0
  Caption = 'Financeiro'
  ClientHeight = 391
  ClientWidth = 677
  Color = clGradientInactiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 40
    Width = 661
    Height = 343
    ActivePage = TabSheet1
    Style = tsButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Hist'#243'rico do Cliente'
      object Label1: TLabel
        Left = 3
        Top = 13
        Width = 33
        Height = 13
        Caption = 'Cliente'
      end
      object edCOD_CLI: TEdit
        Left = 3
        Top = 32
        Width = 57
        Height = 21
        TabOrder = 0
      end
      object Button1: TButton
        Left = 66
        Top = 30
        Width = 33
        Height = 25
        Caption = '?'
        TabOrder = 1
      end
      object edNOME_CLI: TEdit
        Left = 112
        Top = 32
        Width = 273
        Height = 21
        Color = cl3DLight
        ReadOnly = True
        TabOrder = 2
      end
      object DateTimePicker1: TDateTimePicker
        Left = 408
        Top = 32
        Width = 105
        Height = 21
        Date = 42349.711845000000000000
        Time = 42349.711845000000000000
        TabOrder = 3
      end
      object DateTimePicker2: TDateTimePicker
        Left = 536
        Top = 32
        Width = 98
        Height = 21
        Date = 42349.712324780090000000
        Time = 42349.712324780090000000
        TabOrder = 4
      end
      object DBGrid1: TDBGrid
        Left = 3
        Top = 128
        Width = 647
        Height = 181
        TabOrder = 5
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object RadioGroup1: TRadioGroup
        Left = 3
        Top = 69
        Width = 233
        Height = 41
        Caption = 'Op'#231#227'o'
        Columns = 3
        Items.Strings = (
          'Pagos'
          'Em Aberto'
          'Todos')
        TabOrder = 6
      end
      object Button2: TButton
        Left = 408
        Top = 85
        Width = 226
        Height = 25
        Caption = 'Carregar'
        TabOrder = 7
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Baixar Contas em Aberto'
      ImageIndex = 1
    end
  end
end
