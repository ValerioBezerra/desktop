object cmKingAutorizacao: TcmKingAutorizacao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 249
  Width = 546
  object SQLConnection: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'Port=201502'
      'HostName=127.0.0.1'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/')
    Left = 48
    Top = 40
  end
  object DSProviderConnection: TDSProviderConnection
    ServerClassName = 'TSMKingAutorizacao'
    SQLConnection = SQLConnection
    Left = 152
    Top = 40
  end
  object cdsConsulta: TClientDataSet
    Aggregates = <>
    CommandText = 'SELECT * FROM GER_EMP WHERE 1 = 0'
    Params = <>
    ProviderName = 'dspConsulta'
    RemoteServer = DSProviderConnection
    Left = 348
    Top = 16
  end
  object dsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 348
    Top = 64
  end
  object cdsAUT_PER: TClientDataSet
    Aggregates = <>
    CommandText = 'SELECT * FROM AUT_PER WHERE 1 = 0'
    Params = <>
    ProviderName = 'dspAUT_PER'
    RemoteServer = DSProviderConnection
    Left = 44
    Top = 120
  end
  object dsAUT_PER: TDataSource
    DataSet = cdsAUT_PER
    Left = 44
    Top = 168
  end
  object cdsAUT_USU: TClientDataSet
    Aggregates = <>
    CommandText = 'SELECT * FROM AUT_USU WHERE 1 = 0'
    Params = <>
    ProviderName = 'dspAUT_USU'
    RemoteServer = DSProviderConnection
    Left = 132
    Top = 120
  end
  object dsAUT_USU: TDataSource
    DataSet = cdsAUT_USU
    Left = 132
    Top = 168
  end
  object cdsAUT_MOD: TClientDataSet
    Aggregates = <>
    CommandText = 'SELECT * FROM AUT_MOD WHERE 1 = 0'
    Params = <>
    ProviderName = 'dspAUT_MOD'
    RemoteServer = DSProviderConnection
    Left = 220
    Top = 120
  end
  object dsAUT_MOD: TDataSource
    DataSet = cdsAUT_MOD
    Left = 220
    Top = 168
  end
  object cdsAUT_PRO: TClientDataSet
    Aggregates = <>
    CommandText = 'SELECT * FROM AUT_PRO WHERE 1 = 0'
    Params = <>
    ProviderName = 'dspAUT_PRO'
    RemoteServer = DSProviderConnection
    Left = 308
    Top = 120
  end
  object dsAUT_PRO: TDataSource
    DataSet = cdsAUT_PRO
    Left = 308
    Top = 168
  end
  object cdsAUT_APE: TClientDataSet
    Aggregates = <>
    CommandText = 'SELECT * FROM AUT_APE WHERE 1 = 0'
    Params = <>
    ProviderName = 'dspAUT_APE'
    RemoteServer = DSProviderConnection
    Left = 385
    Top = 120
  end
  object dsAUT_APE: TDataSource
    DataSet = cdsAUT_APE
    Left = 385
    Top = 168
  end
  object cdsAUT_AUS: TClientDataSet
    Aggregates = <>
    CommandText = 'SELECT * FROM AUT_AUS WHERE 1 = 0'
    Params = <>
    ProviderName = 'dspAUT_AUS'
    RemoteServer = DSProviderConnection
    Left = 473
    Top = 120
  end
  object dsAUT_AUS: TDataSource
    DataSet = cdsAUT_AUS
    Left = 473
    Top = 168
  end
end
