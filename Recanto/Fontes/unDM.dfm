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
      'select * from FORNECEDOR')
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
    Active = True
    Aggregates = <>
    CommandText = 'select * from FORNECEDOR'
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
  end
  object dsCLIENTE: TDataSource
    DataSet = cdsCLIENTE
    Left = 232
    Top = 240
  end
  object qryFORNECEDOR: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from FORNECEDOR')
    Left = 48
    Top = 296
  end
  object dspFORNECEDOR: TDataSetProvider
    DataSet = qryFORNECEDOR
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 112
    Top = 296
  end
  object cdsFORNECEDOR: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from FORNECEDOR'
    Params = <>
    ProviderName = 'dspFORNECEDOR'
    Left = 168
    Top = 296
  end
  object dsFORNECEDOR: TDataSource
    DataSet = cdsFORNECEDOR
    Left = 232
    Top = 296
  end
end
