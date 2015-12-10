inherited frmITE: TfrmITE
  Caption = 'Estoque - Item'
  ClientHeight = 274
  ClientWidth = 794
  ExplicitWidth = 800
  ExplicitHeight = 303
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Left = 657
    Height = 224
    ExplicitLeft = 657
    ExplicitHeight = 272
    inherited Panel4: TPanel
      Height = 214
      ExplicitHeight = 262
    end
    inherited Panel5: TPanel
      Height = 214
      ExplicitHeight = 262
    end
    inherited Panel6: TPanel
      Top = 214
      ExplicitTop = 262
    end
    inherited Panel7: TPanel
      Height = 214
      ExplicitHeight = 262
    end
  end
  inherited stbStatus: TStatusBar
    Top = 236
    Width = 794
    ExplicitTop = 284
    ExplicitWidth = 794
  end
  inherited stbInformacao: TStatusBar
    Top = 255
    Width = 794
    ExplicitTop = 303
    ExplicitWidth = 794
  end
  inherited Panel1: TPanel
    Width = 794
    ExplicitWidth = 794
  end
  inherited pnlPrincipal: TPanel
    Width = 646
    Height = 224
    ExplicitWidth = 646
    ExplicitHeight = 272
    inherited gpFiltro: TGroupBox
      Caption = 'Item'
    end
    inherited dbgdPadrao: TDBGrid
      Width = 634
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO_ITE'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODGRP_ITE'
          Width = 0
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO_ITE'
          Title.Caption = 'Descri'#231#227'o'
          Width = 180
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECO_ITE'
          Title.Caption = 'Pre'#231'o'
          Visible = True
        end>
    end
  end
  inherited Panel3: TPanel
    Height = 224
    ExplicitHeight = 272
  end
end
