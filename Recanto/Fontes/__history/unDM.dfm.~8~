object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 611
  Width = 954
  object Banco: TIBDatabase
    Connected = True
    DatabaseName = 'C:\Recanto\Banco\RECANTO.FDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 56
    Top = 40
  end
  object Transacao: TIBTransaction
    Active = True
    DefaultDatabase = Banco
    Left = 128
    Top = 40
  end
  object qryUSUARIO: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from USUARIO')
    Left = 40
    Top = 160
  end
  object dspUSUARIO: TDataSetProvider
    DataSet = qryUSUARIO
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 104
    Top = 160
  end
  object cdsUSUARIO: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from USUARIO'
    Params = <>
    ProviderName = 'dspUSUARIO'
    Left = 160
    Top = 160
  end
  object dsUSUARIO: TDataSource
    DataSet = cdsUSUARIO
    Left = 224
    Top = 160
  end
  object qryCONSULTA: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from USUARIO')
    Left = 313
    Top = 27
  end
  object dspCONSULTA: TDataSetProvider
    DataSet = qryCONSULTA
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 377
    Top = 27
  end
  object cdsCONSULTA: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from USUARIO'
    Params = <>
    ProviderName = 'dspCONSULTA'
    Left = 433
    Top = 27
  end
  object dsCONSULTA: TDataSource
    DataSet = cdsCONSULTA
    Left = 497
    Top = 27
  end
  object qryCLIENTE: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from CLIENTE')
    Left = 48
    Top = 240
  end
  object dspCLIENTE: TDataSetProvider
    DataSet = qryCLIENTE
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 112
    Top = 240
  end
  object cdsCLIENTE: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from CLIENTE'
    Params = <>
    ProviderName = 'dspCLIENTE'
    Left = 168
    Top = 240
    object cdsCLIENTECODIGO_CLI: TIntegerField
      FieldName = 'CODIGO_CLI'
      Required = True
    end
    object cdsCLIENTENOME_CLI: TWideStringField
      FieldName = 'NOME_CLI'
      Size = 40
    end
    object cdsCLIENTECPF_CLI: TWideStringField
      FieldName = 'CPF_CLI'
      Size = 15
    end
    object cdsCLIENTEIDENTIDADE_CLI: TWideStringField
      FieldName = 'IDENTIDADE_CLI'
      Size = 15
    end
    object cdsCLIENTEENDERECO_CLI: TWideStringField
      FieldName = 'ENDERECO_CLI'
      Size = 50
    end
    object cdsCLIENTENUMEND_CLI: TWideStringField
      FieldName = 'NUMEND_CLI'
      Size = 6
    end
    object cdsCLIENTEBAIRRO_CLI: TWideStringField
      FieldName = 'BAIRRO_CLI'
      Size = 30
    end
    object cdsCLIENTEUF_CLI: TWideStringField
      FieldName = 'UF_CLI'
      FixedChar = True
      Size = 2
    end
    object cdsCLIENTETELEFONE_CLI: TWideStringField
      FieldName = 'TELEFONE_CLI'
      Size = 15
    end
    object cdsCLIENTECELULAR_CLI: TWideStringField
      FieldName = 'CELULAR_CLI'
      Size = 15
    end
    object cdsCLIENTECIDADE_CLI: TIntegerField
      FieldName = 'CIDADE_CLI'
    end
  end
  object dsCLIENTE: TDataSource
    DataSet = cdsCLIENTE
    Left = 232
    Top = 240
  end
end
