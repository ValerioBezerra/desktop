object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Consultar Usu'#225'rio'
  ClientHeight = 234
  ClientWidth = 376
  Color = clBtnFace
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
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 361
    Height = 185
    DataSource = DM.dsUSUARIO
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO_USU'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_USU'
        Title.Caption = 'Usu'#225'rio'
        Width = 240
        Visible = True
      end>
  end
  object edConsultar: TEdit
    Left = 8
    Top = 208
    Width = 257
    Height = 21
    TabOrder = 1
  end
  object btConsultar: TButton
    Left = 271
    Top = 206
    Width = 100
    Height = 25
    Caption = 'Consultar'
    TabOrder = 2
    OnClick = btConsultarClick
  end
end