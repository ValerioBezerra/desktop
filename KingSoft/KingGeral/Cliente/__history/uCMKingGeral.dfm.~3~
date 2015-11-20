object ClientModule1: TClientModule1
  OldCreateOrder = False
  Height = 271
  Width = 415
  object SQLConnection: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'Port=201501'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/')
    Connected = True
    Left = 48
    Top = 40
  end
  object DSProviderConnection: TDSProviderConnection
    ServerClassName = 'TSMKingGeral'
    Connected = True
    SQLConnection = SQLConnection
    Left = 152
    Top = 40
  end
  object cdsConsulta: TClientDataSet
    Active = True
    Aggregates = <>
    CommandText = 'SELECT * FROM GER_EMP'
    Params = <>
    ProviderName = 'DSPConsulta'
    RemoteServer = DSProviderConnection
    Left = 44
    Top = 104
  end
end
