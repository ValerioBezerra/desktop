object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 751
  Width = 1033
  object Banco: TIBDatabase
    Connected = True
    DatabaseName = 
      'C:\Users\Elison\Documents\GitHub\desktop\Recanto\Banco\RECANTO.F' +
      'DB'
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
    CommandText = 'select * from ESTTMO'
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
    Top = 296
  end
  object dspCLIENTE: TDataSetProvider
    DataSet = qryCLIENTE
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 112
    Top = 296
  end
  object cdsCLIENTE: TClientDataSet
    Active = True
    Aggregates = <>
    CommandText = 'select * from CLIENTE'
    Params = <>
    ProviderName = 'dspCLIENTE'
    Left = 168
    Top = 296
  end
  object dsCLIENTE: TDataSource
    DataSet = cdsCLIENTE
    Left = 232
    Top = 296
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
    Top = 352
  end
  object dspFORNECEDOR: TDataSetProvider
    DataSet = qryFORNECEDOR
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 112
    Top = 352
  end
  object cdsFORNECEDOR: TClientDataSet
    Active = True
    Aggregates = <>
    CommandText = 'select * from FORNECEDOR'
    Params = <>
    ProviderName = 'dspFORNECEDOR'
    Left = 168
    Top = 352
  end
  object dsFORNECEDOR: TDataSource
    DataSet = cdsFORNECEDOR
    Left = 232
    Top = 352
  end
  object qryFUNCIONARIO: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from FORNECEDOR')
    Left = 40
    Top = 408
  end
  object dspFUNCIONARIO: TDataSetProvider
    DataSet = qryFUNCIONARIO
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 104
    Top = 408
  end
  object cdsFUNCIONARIO: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from FUNCIONARIO'
    Params = <>
    ProviderName = 'dspFUNCIONARIO'
    Left = 160
    Top = 408
  end
  object dsFUNCIONARIO: TDataSource
    DataSet = cdsFUNCIONARIO
    Left = 224
    Top = 408
  end
  object qryPAGTIT: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select SEQ_PAGTIT, ORIGEM_PAGTIT,DATAEMISSAO_PAGTTIT,DATAVENC_PA' +
        'GTIT,VALORTOTAL_PAGTIT,VALORPAGO_PAGTIT, NOME_FOR,CODIGO_FOR,(VA' +
        'LORTOTAL_PAGTIT - VALORPAGO_PAGTIT) AS VALORABERTO from PAGTIT L' +
        'EFT OUTER JOIN FORNECEDOR ON CODIGO_FOR = CODFOR_PAGTIT')
    Left = 408
    Top = 192
  end
  object dspPAGTIT: TDataSetProvider
    DataSet = qryPAGTIT
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 472
    Top = 192
  end
  object cdsPAGTIT: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select CODFOR_PAGTIT,SEQ_PAGTIT, ORIGEM_PAGTIT,DATAEMISSAO_PAGTT' +
      'IT,DATAVENC_PAGTIT,VALORTOTAL_PAGTIT,VALORPAGO_PAGTIT,(VALORTOTA' +
      'L_PAGTIT - VALORPAGO_PAGTIT) AS VALORABERTO from PAGTIT LEFT OUT' +
      'ER JOIN FORNECEDOR ON CODIGO_FOR = CODFOR_PAGTIT'
    Params = <>
    ProviderName = 'dspPAGTIT'
    Left = 528
    Top = 192
  end
  object dsPAGTIT: TDataSource
    DataSet = cdsPAGTIT
    Left = 592
    Top = 192
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
    Left = 313
    Top = 83
  end
  object dspTELASCONSULTA: TDataSetProvider
    DataSet = qryTELASCONSULTA
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 377
    Top = 83
  end
  object cdsTELASCONSULTA: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select * from PAGTIT LEFT OUTER JOIN FORNECEDOR ON CODIGO_FOR = ' +
      'CODFOR_PAGTIT'
    Params = <>
    ProviderName = 'dspTELASCONSULTA'
    Left = 433
    Top = 83
  end
  object dsTELASCONSULTA: TDataSource
    DataSet = cdsTELASCONSULTA
    Left = 497
    Top = 83
  end
  object qryRECTIT: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select SEQ_RECTIT, ORIGEM_RECTIT,DATAEMISSAO_RECTIT,DATAVENC_REC' +
        'TIT,VALORTOTAL_RECTIT,VALORPAGO_RECTIT, NOME_CLI,CODIGO_CLI,(VAL' +
        'ORTOTAL_RECTIT - VALORPAGO_RECTIT) AS VALORABERTO from RECTIT LE' +
        'FT OUTER JOIN CLIENTE ON CODIGO_CLI = CODCLI_RECTIT')
    Left = 410
    Top = 246
  end
  object dspRECTIT: TDataSetProvider
    DataSet = qryRECTIT
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 474
    Top = 246
  end
  object cdsRECTIT: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select SEQ_RECTIT, ORIGEM_RECTIT,DATAEMISSAO_RECTIT,DATAVENC_REC' +
      'TIT,VALORTOTAL_RECTIT,VALORPAGO_RECTIT, CODCLI_RECTIT,(VALORTOTA' +
      'L_RECTIT - VALORPAGO_RECTIT) AS VALORABERTO from RECTIT LEFT OUT' +
      'ER JOIN CLIENTE ON CODIGO_CLI = CODCLI_RECTIT'
    Params = <>
    ProviderName = 'dspRECTIT'
    Left = 530
    Top = 246
  end
  object dsRECTIT: TDataSource
    DataSet = cdsRECTIT
    Left = 594
    Top = 246
  end
  object qryHOSTER: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from HOSTER')
    Left = 28
    Top = 468
  end
  object dspHOSTER: TDataSetProvider
    DataSet = qryHOSTER
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 92
    Top = 468
  end
  object cdsHOSTER: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from HOSTER'
    Params = <>
    ProviderName = 'dspHOSTER'
    Left = 148
    Top = 468
    object cdsHOSTERCODIGO_TER: TIntegerField
      FieldName = 'CODIGO_TER'
      Required = True
    end
    object cdsHOSTERNOME_TER: TWideStringField
      FieldName = 'NOME_TER'
      Size = 30
    end
    object cdsHOSTERPRECO_TER: TBCDField
      FieldName = 'PRECO_TER'
      Precision = 18
      Size = 2
    end
    object cdsHOSTERDURACAO_TER: TTimeField
      FieldName = 'DURACAO_TER'
    end
  end
  object dsHOSTER: TDataSource
    DataSet = cdsHOSTER
    Left = 212
    Top = 468
  end
  object qryESTGRP: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from ESTGRP')
    Left = 30
    Top = 523
  end
  object dspESTGRP: TDataSetProvider
    DataSet = qryESTGRP
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 94
    Top = 523
  end
  object cdsESTGRP: TClientDataSet
    Active = True
    Aggregates = <>
    CommandText = 'select * from ESTGRP'
    Params = <>
    ProviderName = 'dspESTGRP'
    Left = 150
    Top = 523
  end
  object dsESTGRP: TDataSource
    DataSet = cdsESTGRP
    Left = 214
    Top = 523
  end
  object qryESTITE: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from ESTITE')
    Left = 33
    Top = 577
  end
  object dspESTITE: TDataSetProvider
    DataSet = qryESTITE
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 97
    Top = 577
  end
  object cdsESTITE: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from ESTITE'
    Params = <>
    ProviderName = 'dspESTITE'
    Left = 153
    Top = 577
  end
  object dsESTITE: TDataSource
    DataSet = cdsESTITE
    Left = 217
    Top = 577
  end
  object qryESTTMO: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from ESTITE')
    Left = 36
    Top = 637
  end
  object dspESTTMO: TDataSetProvider
    DataSet = qryESTTMO
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 100
    Top = 637
  end
  object cdsESTTMO: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from ESTTMO'
    Params = <>
    ProviderName = 'dspESTTMO'
    Left = 156
    Top = 637
  end
  object dsESTTMO: TDataSource
    DataSet = cdsESTTMO
    Left = 220
    Top = 637
  end
  object qryESTMOV: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from ESTMOV')
    Left = 411
    Top = 303
  end
  object dspESTMOV: TDataSetProvider
    DataSet = qryESTMOV
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 475
    Top = 303
  end
  object cdsESTMOV: TClientDataSet
    Active = True
    Aggregates = <>
    CommandText = 'select * from ESTMOV'
    Params = <>
    ProviderName = 'dspESTMOV'
    Left = 531
    Top = 303
  end
  object dsESTMOV: TDataSource
    DataSet = cdsESTMOV
    Left = 595
    Top = 303
  end
end
