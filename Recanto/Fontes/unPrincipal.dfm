object frmPRINCIPAL: TfrmPRINCIPAL
  Left = 0
  Top = 0
  Caption = 'Sistema de Controle - Recanto'
  ClientHeight = 569
  ClientWidth = 909
  Color = clWhite
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
    Left = 192
    Top = 64
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object ContasaReceber1: TMenuItem
        Caption = 'Contas a Receber'
        object Cliente1: TMenuItem
          Caption = 'Cliente'
          OnClick = Cliente1Click
        end
      end
      object ContasaPagar1: TMenuItem
        Caption = 'Contas a Pagar'
        object Fornecedor1: TMenuItem
          Caption = 'Fornecedor'
          OnClick = Fornecedor1Click
        end
      end
      object FolhadePagamento1: TMenuItem
        Caption = 'Folha de Pagamento'
        object Funcionrio1: TMenuItem
          Caption = 'Funcion'#225'rio'
          OnClick = Funcionrio1Click
        end
      end
      object Hospedagem1: TMenuItem
        Caption = 'Hospedagem'
        object erapias1: TMenuItem
          Caption = 'Terapias'
          OnClick = erapias1Click
        end
      end
      object Estoque1: TMenuItem
        Caption = 'Estoque'
        object Grupo1: TMenuItem
          Caption = 'Grupo'
          OnClick = Grupo1Click
        end
        object Item1: TMenuItem
          Caption = 'Item'
          OnClick = Item1Click
        end
      end
    end
    object Movimento1: TMenuItem
      Caption = 'Movimento'
      object ContasaPagar2: TMenuItem
        Caption = 'Contas a Pagar'
        object tulo1: TMenuItem
          Caption = 'T'#237'tulo'
          OnClick = tulo1Click
        end
        object BaixadeTtulo1: TMenuItem
          Caption = 'Baixa de T'#237'tulo'
        end
      end
      object ContasaReceber3: TMenuItem
        Caption = 'Contas a Receber'
        object tulo2: TMenuItem
          Caption = 'T'#237'tulo'
          OnClick = tulo2Click
        end
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object ContasaReceber2: TMenuItem
        Caption = 'Contas a Receber'
        object Clientes1: TMenuItem
          Caption = 'Clientes'
          OnClick = Clientes1Click
        end
        object tulos1: TMenuItem
          Caption = 'T'#237'tulos'
        end
      end
      object ContasaPagar3: TMenuItem
        Caption = 'Contas a Pagar'
        object Fornecedores1: TMenuItem
          Caption = 'Fornecedores'
          OnClick = Fornecedores1Click
        end
        object tulos2: TMenuItem
          Caption = 'T'#237'tulos'
        end
      end
    end
    object Sair1: TMenuItem
      Caption = 'Sair'
    end
  end
end
