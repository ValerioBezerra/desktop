inherited frmTMO: TfrmTMO
  Caption = 'Fornecedores'
  ClientHeight = 278
  ClientWidth = 794
  ExplicitWidth = 800
  ExplicitHeight = 307
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Left = 657
    Height = 228
    ExplicitLeft = 657
    ExplicitHeight = 228
    inherited Panel4: TPanel
      Height = 218
      ExplicitHeight = 218
    end
    inherited Panel5: TPanel
      Height = 218
      ExplicitHeight = 218
    end
    inherited Panel6: TPanel
      Top = 218
      ExplicitTop = 218
    end
    inherited Panel7: TPanel
      Height = 218
      ExplicitHeight = 218
    end
  end
  inherited stbStatus: TStatusBar
    Top = 240
    Width = 794
    ExplicitTop = 240
    ExplicitWidth = 794
  end
  inherited stbInformacao: TStatusBar
    Top = 259
    Width = 794
    ExplicitTop = 259
    ExplicitWidth = 794
  end
  inherited Panel1: TPanel
    Width = 794
    ExplicitWidth = 794
  end
  inherited pnlPrincipal: TPanel
    Width = 646
    Height = 228
    ExplicitWidth = 646
    ExplicitHeight = 228
    inherited dbgdPadrao: TDBGrid
      Width = 634
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO_TMO'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO_TMO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INDICADOR_TMO'
          Width = 0
          Visible = True
        end>
    end
  end
  inherited Panel3: TPanel
    Height = 228
    ExplicitHeight = 228
  end
end
