object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 751
  Width = 1033
  object Banco: TIBDatabase
    Connected = True
    DatabaseName = 'C:\EDELIVERY\BANCO\TMDELIVERY.IB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = Transacao
    ServerType = 'IBServer'
    Left = 56
    Top = 40
  end
  object Transacao: TIBTransaction
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
    Top = 216
  end
  object dspUSUARIO: TDataSetProvider
    DataSet = qryUSUARIO
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 104
    Top = 216
  end
  object cdsUSUARIO: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from USUARIO'
    Params = <>
    ProviderName = 'dspUSUARIO'
    Left = 160
    Top = 216
  end
  object dsUSUARIO: TDataSource
    DataSet = cdsUSUARIO
    Left = 224
    Top = 216
  end
  object qryCONSULTA: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from ESTTMO')
    Left = 391
    Top = 27
  end
  object dspCONSULTA: TDataSetProvider
    DataSet = qryCONSULTA
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 455
    Top = 27
  end
  object cdsCONSULTA: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from ESTTMO'
    Params = <>
    ProviderName = 'dspCONSULTA'
    Left = 511
    Top = 27
  end
  object dsCONSULTA: TDataSource
    DataSet = cdsCONSULTA
    Left = 575
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
    Top = 296
  end
  object dspCLIENTE: TDataSetProvider
    DataSet = qryCLIENTE
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 112
    Top = 296
  end
  object cdsCLIENTE: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from CLIENTE'
    Params = <>
    ProviderName = 'dspCLIENTE'
    Left = 168
    Top = 296
    object cdsCLIENTECOD_CLI: TIntegerField
      FieldName = 'COD_CLI'
      Required = True
    end
    object cdsCLIENTENOME_CLI: TWideStringField
      FieldName = 'NOME_CLI'
      Size = 25
    end
    object cdsCLIENTETEL_CLI: TWideStringField
      FieldName = 'TEL_CLI'
      Size = 15
    end
    object cdsCLIENTECEL_CLI: TWideStringField
      FieldName = 'CEL_CLI'
      Size = 15
    end
    object cdsCLIENTEENDERECO: TWideStringField
      FieldName = 'ENDERECO'
      Size = 100
    end
    object cdsCLIENTEBAIRRO: TWideStringField
      FieldName = 'BAIRRO'
      Size = 30
    end
  end
  object dsCLIENTE: TDataSource
    DataSet = cdsCLIENTE
    Left = 232
    Top = 296
  end
  object qryTELASCONSULTA: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select * from PAGTIT LEFT OUTER JOIN FORNECEDOR ON CODIGO_FOR = ' +
        'CODFOR_PAGTIT')
    Left = 391
    Top = 83
  end
  object dspTELASCONSULTA: TDataSetProvider
    DataSet = qryTELASCONSULTA
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 455
    Top = 83
  end
  object cdsTELASCONSULTA: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select * from PAGTIT LEFT OUTER JOIN FORNECEDOR ON CODIGO_FOR = ' +
      'CODFOR_PAGTIT'
    Params = <>
    ProviderName = 'dspTELASCONSULTA'
    Left = 511
    Top = 83
  end
  object dsTELASCONSULTA: TDataSource
    DataSet = cdsTELASCONSULTA
    Left = 575
    Top = 83
  end
  object qryPRO: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from PRODUTOS')
    Left = 40
    Top = 352
  end
  object dspPRO: TDataSetProvider
    DataSet = qryPRO
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 104
    Top = 352
  end
  object cdsPRO: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from PRODUTOS'
    Params = <>
    ProviderName = 'dspPRO'
    Left = 160
    Top = 352
    object cdsPROCOD_PRO: TIntegerField
      FieldName = 'COD_PRO'
      Required = True
    end
    object cdsPRONOME_PRO: TWideStringField
      FieldName = 'NOME_PRO'
      Size = 50
    end
    object cdsPROTIPO_PRO: TIntegerField
      FieldName = 'TIPO_PRO'
    end
  end
  object dsPRO: TDataSource
    DataSet = cdsPRO
    Left = 224
    Top = 352
  end
  object qryENT: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from ENTREGADOR')
    Left = 32
    Top = 416
  end
  object dspENT: TDataSetProvider
    DataSet = qryENT
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 96
    Top = 416
  end
  object cdsENT: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from ENTREGADOR'
    Params = <>
    ProviderName = 'dspENT'
    Left = 152
    Top = 416
  end
  object dsENT: TDataSource
    DataSet = cdsENT
    Left = 216
    Top = 416
  end
  object qryPRODIAP: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from PRODUTO_DIA ')
    Left = 32
    Top = 480
  end
  object dspPRODIAP: TDataSetProvider
    DataSet = qryPRODIAP
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 96
    Top = 480
  end
  object cdsPRODIAP: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from PRODUTO_DIA '
    Params = <>
    ProviderName = 'dspPRODIAP'
    Left = 152
    Top = 480
  end
  object dsPRODIAP: TDataSource
    DataSet = cdsPRODIAP
    Left = 216
    Top = 480
  end
  object cdsPRODIAA: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from ENTREGADOR'
    Params = <>
    ProviderName = 'dspPRODIAA'
    Left = 152
    Top = 544
  end
  object dsPRODIAA: TDataSource
    DataSet = cdsPRODIAA
    Left = 216
    Top = 544
  end
  object dspPRODIAA: TDataSetProvider
    DataSet = qryPRODIAA
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 96
    Top = 544
  end
  object qryPRODIAA: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from ENTREGADOR')
    Left = 32
    Top = 544
  end
  object qryGravar: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select * from PAGTIT LEFT OUTER JOIN FORNECEDOR ON CODIGO_FOR = ' +
        'CODFOR_PAGTIT')
    Left = 391
    Top = 147
  end
  object dspGRAVAR: TDataSetProvider
    DataSet = qryGravar
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 455
    Top = 147
  end
  object cdsGRAVAR: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select * from PAGTIT LEFT OUTER JOIN FORNECEDOR ON CODIGO_FOR = ' +
      'CODFOR_PAGTIT'
    Params = <>
    ProviderName = 'dspGRAVAR'
    Left = 511
    Top = 147
  end
  object dsGRAVAR: TDataSource
    DataSet = cdsGRAVAR
    Left = 575
    Top = 147
  end
  object qryRELATORIO: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select * from pedido left outer join produto_pedido on seqped_px' +
        'p = seq_ped left outer join produtos on cod_pro = codpro_pxp lef' +
        't outer join cliente on cod_cli = codcli_ped')
    Left = 383
    Top = 211
  end
  object dspRELATORIO: TDataSetProvider
    DataSet = qryRELATORIO
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 447
    Top = 211
  end
  object cdsRELATORIO: TClientDataSet
    Active = True
    Aggregates = <>
    CommandText = 
      'select * from pedido left outer join produto_pedido on seqped_px' +
      'p = seq_ped left outer join produtos on cod_pro = codpro_pxp lef' +
      't outer join cliente on cod_cli = codcli_ped'
    Params = <>
    ProviderName = 'dspRELATORIO'
    Left = 503
    Top = 211
  end
  object dsRELATORIO: TDataSource
    DataSet = cdsRELATORIO
    Left = 567
    Top = 211
  end
end
