object SMKingAutorizacao: TSMKingAutorizacao
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 373
  Width = 510
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=C:\KingErp\Dados\KINGSOFT.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'DriverID=FB')
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_5\bin\fbclient.dll'
    Left = 128
    Top = 25
  end
  object fdqConsulta: TFDQuery
    Connection = FDConnection
    Left = 32
    Top = 104
  end
  object dspConsulta: TDataSetProvider
    DataSet = fdqConsulta
    Options = [poFetchBlobsOnDemand, poFetchDetailsOnDemand, poAllowCommandText]
    Left = 33
    Top = 151
  end
  object fdqAUT_PER: TFDQuery
    Connection = FDConnection
    Left = 120
    Top = 104
  end
  object dspAUT_PER: TDataSetProvider
    DataSet = fdqAUT_PER
    Options = [poFetchBlobsOnDemand, poFetchDetailsOnDemand, poAllowCommandText]
    Left = 120
    Top = 151
  end
end
