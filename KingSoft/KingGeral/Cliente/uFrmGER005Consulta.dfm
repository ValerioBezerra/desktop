inherited frmGER005Consulta: TfrmGER005Consulta
  Caption = 'frmGER005Consulta'
  ClientWidth = 743
  OnKeyDown = FormKeyDown
  ExplicitWidth = 749
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 743
    ExplicitWidth = 743
  end
  inherited pnlPrincipal: TPanel
    Width = 623
    ExplicitWidth = 623
    inherited gpFiltro: TGroupBox
      Width = 599
      ExplicitWidth = 599
      inherited cbContido: TCheckBox
        Left = 527
        ExplicitLeft = 527
      end
      inherited edConsulta: TEdit
        Left = 9
        Width = 512
        ExplicitLeft = 9
        ExplicitWidth = 512
      end
      inherited cbConsulta: TComboBox
        Left = 3
        Top = 53
        Visible = False
        ExplicitLeft = 3
        ExplicitTop = 53
      end
    end
    inherited KsDBGrid: TKsDBGrid
      Width = 599
      Columns = <
        item
          Expanded = False
          FieldName = 'GER_ID_TLG'
          Title.Alignment = taRightJustify
          Title.Caption = 'Id'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GER_DESCRICAO_TLG'
          Title.Caption = 'Nome'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 360
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GER_NOME_EST'
          Title.Caption = 'Estado'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 140
          Visible = True
        end>
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      Columns = <
        item
          Expanded = False
          FieldName = 'GER_ID_TLG'
          Title.Alignment = taRightJustify
          Title.Caption = 'Id'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GER_DESCRICAO_TLG'
          Title.Caption = 'Nome'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 360
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GER_NOME_EST'
          Title.Caption = 'Estado'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 140
          Visible = True
        end>
    end
  end
  inherited stbInformacao: TStatusBar
    Width = 743
    ExplicitWidth = 743
  end
  inherited pnlBotoes: TPanel
    Left = 623
    ExplicitLeft = 623
    inherited btnNovo: TBitBtn
      OnClick = btnNovoClick
    end
    inherited btnEditar: TBitBtn
      OnClick = btnEditarClick
    end
  end
  inherited Panel2: TPanel
    Left = 735
    ExplicitLeft = 735
  end
  inherited cdsConsulta: TClientDataSet
    CommandText = 
      'SELECT * FROM GER_CID LEFT OUTER JOIN GER_EST ON GER_ID_EST = GE' +
      'R_GEREST_CID WHERE 1 = 0'
    ProviderName = 'dspConsulta'
    RemoteServer = cmKingGeral.DSProviderConnection
  end
end
