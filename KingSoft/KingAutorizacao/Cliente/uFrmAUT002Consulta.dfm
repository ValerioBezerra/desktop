inherited frmAUT002Consulta: TfrmAUT002Consulta
  Caption = 'frmAUT002Consulta'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPrincipal: TPanel
    inherited gpFiltro: TGroupBox
      inherited edConsulta: TEdit
        Left = 9
        Width = 395
        ExplicitLeft = 9
        ExplicitWidth = 395
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
      Columns = <
        item
          Expanded = False
          FieldName = 'AUT_ID_PER'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
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
          FieldName = 'AUT_DESCRICAO_PER'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Caption = 'Descri'#231#227'o'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 380
          Visible = True
        end>
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      Columns = <
        item
          Expanded = False
          FieldName = 'AUT_ID_PER'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
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
          FieldName = 'AUT_DESCRICAO_PER'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Caption = 'Descri'#231#227'o'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 380
          Visible = True
        end>
    end
  end
  inherited cdsConsulta: TClientDataSet
    CommandText = 'SELECT * FROM AUT_PER WHERE 1 = 0'
    ProviderName = 'dspConsulta'
    RemoteServer = cmKingAutorizacao.DSProviderConnection
  end
end
