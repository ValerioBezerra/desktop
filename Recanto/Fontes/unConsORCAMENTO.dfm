object frmConsORCAMENTO: TfrmConsORCAMENTO
  Left = 0
  Top = 0
  Caption = 'Consultar Or'#231'amentos'
  ClientHeight = 234
  ClientWidth = 568
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
    Width = 552
    Height = 185
    DataSource = DataModule1.dsORCAMENTO
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
        FieldName = 'SEQ_ORC'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_ORC'
        Title.Caption = 'Emiss'#227'o'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CLI'
        Title.Caption = 'Cliente'
        Width = 240
        Visible = True
      end>
  end
  object edConsultar: TEdit
    Left = 8
    Top = 205
    Width = 446
    Height = 21
    TabOrder = 1
  end
  object btConsultar: TButton
    Left = 460
    Top = 206
    Width = 100
    Height = 25
    Caption = 'Consultar'
    TabOrder = 2
    OnClick = btConsultarClick
  end
end
