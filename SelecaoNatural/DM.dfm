object DataModule2: TDataModule2
  OldCreateOrder = False
  Height = 504
  Width = 662
  object dspPRO: TDataSetProvider
    DataSet = qryPRO
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 104
    Top = 152
  end
  object cdsPRO: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from produto'
    Params = <>
    ProviderName = 'dspPRO'
    Left = 168
    Top = 160
  end
  object dsPRO: TDataSource
    DataSet = cdsPRO
    Left = 240
    Top = 168
  end
  object dspCONSULTA: TDataSetProvider
    DataSet = qryCONSULTA
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 96
    Top = 224
  end
  object cdsCONSULTA: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from produto'
    Params = <>
    ProviderName = 'dspCONSULTA'
    Left = 160
    Top = 224
  end
  object dsCONSULTA: TDataSource
    DataSet = cdsCONSULTA
    Left = 232
    Top = 232
  end
  object Banco: TIBDatabase
    Connected = True
    DatabaseName = 'C:\BANCO\banco.fdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    ServerType = 'IBServer'
    Left = 56
    Top = 48
  end
  object Transacao: TIBTransaction
    Active = True
    DefaultDatabase = Banco
    Left = 136
    Top = 48
  end
  object qryPRO: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from produto')
    Left = 40
    Top = 152
  end
  object qryCONSULTA: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from produto')
    Left = 32
    Top = 224
  end
  object dspGRAVAR: TDataSetProvider
    DataSet = qryGRAVAR
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 100
    Top = 292
  end
  object cdsGRAVAR: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from produto'
    Params = <>
    ProviderName = 'dspCONSULTA'
    Left = 164
    Top = 292
  end
  object dsGRAVAR: TDataSource
    DataSet = cdsGRAVAR
    Left = 236
    Top = 300
  end
  object qryGRAVAR: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from produto')
    Left = 36
    Top = 292
  end
  object dspPEDIDO: TDataSetProvider
    DataSet = qryPEDIDO
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 95
    Top = 349
  end
  object cdsPEDIDO: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from produto'
    Params = <>
    ProviderName = 'dspPEDIDO'
    Left = 159
    Top = 349
  end
  object dsPEDIDO: TDataSource
    DataSet = cdsPEDIDO
    Left = 231
    Top = 357
  end
  object qryPEDIDO: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from produto')
    Left = 31
    Top = 349
  end
  object dspPROXPED: TDataSetProvider
    DataSet = qryPPROXPED
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 98
    Top = 410
  end
  object cdsPROXPED: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from produto'
    Params = <>
    ProviderName = 'dspPROXPED'
    Left = 162
    Top = 410
  end
  object dsPROXPED: TDataSource
    DataSet = cdsPROXPED
    Left = 234
    Top = 418
  end
  object qryPPROXPED: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from produto')
    Left = 34
    Top = 410
  end
end
