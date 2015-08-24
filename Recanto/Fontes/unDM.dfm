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
      
        'select * from PAGTIT LEFT OUTER JOIN FORNECEDOR ON CODIGO_FOR = ' +
        'CODFOR_PAGTIT')
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
    CommandText = 
      'select * from PAGTIT LEFT OUTER JOIN FORNECEDOR ON CODIGO_FOR = ' +
      'CODFOR_PAGTIT'
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
  object qryFUNCIONARIO: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from FORNECEDOR')
    Left = 40
    Top = 352
  end
  object dspFUNCIONARIO: TDataSetProvider
    DataSet = qryFUNCIONARIO
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 104
    Top = 352
  end
  object cdsFUNCIONARIO: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from FUNCIONARIO'
    Params = <>
    ProviderName = 'dspFUNCIONARIO'
    Left = 160
    Top = 352
  end
  object dsFUNCIONARIO: TDataSource
    DataSet = cdsFUNCIONARIO
    Left = 224
    Top = 352
  end
  object qryPAGTIT: TIBQuery
    Database = Banco
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      
        'select * from PAGTIT LEFT OUTER JOIN FORNECEDOR ON CODIGO_FOR = ' +
        'CODFOR_PAGTIT')
    Left = 368
    Top = 160
  end
  object dspPAGTIT: TDataSetProvider
    DataSet = qryPAGTIT
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 432
    Top = 160
  end
  object cdsPAGTIT: TClientDataSet
    Active = True
    Aggregates = <>
    CommandText = 
      'select * from PAGTIT LEFT OUTER JOIN FORNECEDOR ON CODIGO_FOR = ' +
      'CODFOR_PAGTIT'
    Params = <>
    ProviderName = 'dspPAGTIT'
    Left = 488
    Top = 160
    object cdsPAGTITSEQ_PAGTIT: TIntegerField
      FieldName = 'SEQ_PAGTIT'
      Origin = '"PAGTIT"."SEQ_PAGTIT"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsPAGTITORIGEM_PAGTIT: TIntegerField
      FieldName = 'ORIGEM_PAGTIT'
      Origin = '"PAGTIT"."ORIGEM_PAGTIT"'
    end
    object cdsPAGTITDATAEMISSAO_PAGTTIT: TDateField
      FieldName = 'DATAEMISSAO_PAGTTIT'
      Origin = '"PAGTIT"."DATAEMISSAO_PAGTTIT"'
    end
    object cdsPAGTITDATAVENC_PAGTIT: TDateField
      FieldName = 'DATAVENC_PAGTIT'
      Origin = '"PAGTIT"."DATAVENC_PAGTIT"'
    end
    object cdsPAGTITVALORTOTAL_PAGTIT: TBCDField
      FieldName = 'VALORTOTAL_PAGTIT'
      Origin = '"PAGTIT"."VALORTOTAL_PAGTIT"'
      DisplayFormat = 'R$ #,##0.00'
      currency = True
      Precision = 18
      Size = 2
    end
    object cdsPAGTITVALORPAGO_PAGTIT: TBCDField
      FieldName = 'VALORPAGO_PAGTIT'
      Origin = '"PAGTIT"."VALORPAGO_PAGTIT"'
      Precision = 18
      Size = 2
    end
    object cdsPAGTITCODFOR_PAGTIT: TIntegerField
      FieldName = 'CODFOR_PAGTIT'
      Origin = '"PAGTIT"."CODFOR_PAGTIT"'
    end
    object cdsPAGTITCODIGO_FOR: TIntegerField
      FieldName = 'CODIGO_FOR'
      Origin = '"FORNECEDOR"."CODIGO_FOR"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsPAGTITNOME_FOR: TWideStringField
      FieldName = 'NOME_FOR'
      Origin = '"FORNECEDOR"."NOME_FOR"'
      Size = 30
    end
    object cdsPAGTITCPFCNPJ_FOR: TWideStringField
      FieldName = 'CPFCNPJ_FOR'
      Origin = '"FORNECEDOR"."CPFCNPJ_FOR"'
      Size = 18
    end
    object cdsPAGTITENDERECO_FOR: TWideStringField
      FieldName = 'ENDERECO_FOR'
      Origin = '"FORNECEDOR"."ENDERECO_FOR"'
      Size = 50
    end
    object cdsPAGTITNUM_FOR: TIntegerField
      FieldName = 'NUM_FOR'
      Origin = '"FORNECEDOR"."NUM_FOR"'
    end
    object cdsPAGTITBAIRRO_FOR: TWideStringField
      FieldName = 'BAIRRO_FOR'
      Origin = '"FORNECEDOR"."BAIRRO_FOR"'
      Size = 30
    end
    object cdsPAGTITCIDADE_FOR: TWideStringField
      FieldName = 'CIDADE_FOR'
      Origin = '"FORNECEDOR"."CIDADE_FOR"'
      Size = 30
    end
    object cdsPAGTITUF_FOR: TWideStringField
      FieldName = 'UF_FOR'
      Origin = '"FORNECEDOR"."UF_FOR"'
      FixedChar = True
      Size = 2
    end
    object cdsPAGTITTELEFONE_FOR: TWideStringField
      FieldName = 'TELEFONE_FOR'
      Origin = '"FORNECEDOR"."TELEFONE_FOR"'
      Size = 15
    end
    object cdsPAGTITCELULAR_FOR: TWideStringField
      FieldName = 'CELULAR_FOR'
      Origin = '"FORNECEDOR"."CELULAR_FOR"'
      Size = 15
    end
    object cdsPAGTITINSCEST_FOR: TWideStringField
      FieldName = 'INSCEST_FOR'
      Origin = '"FORNECEDOR"."INSCEST_FOR"'
      Size = 10
    end
    object cdsPAGTITPFPJ_FOR: TIntegerField
      FieldName = 'PFPJ_FOR'
      Origin = '"FORNECEDOR"."PFPJ_FOR"'
    end
  end
  object dsPAGTIT: TDataSource
    DataSet = cdsPAGTIT
    Left = 552
    Top = 160
  end
end
