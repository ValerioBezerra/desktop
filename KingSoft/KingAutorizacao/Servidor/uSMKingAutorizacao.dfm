object SMKingAutorizacao: TSMKingAutorizacao
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 379
  Width = 527
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
    Left = 464
    Top = 8
  end
  object dspConsulta: TDataSetProvider
    DataSet = fdqConsulta
    Options = [poFetchBlobsOnDemand, poFetchDetailsOnDemand, poAllowCommandText]
    Left = 465
    Top = 55
  end
  object fdqAUT_PER: TFDQuery
    Connection = FDConnection
    Left = 40
    Top = 115
  end
  object dspAUT_PER: TDataSetProvider
    DataSet = fdqAUT_PER
    Options = [poFetchBlobsOnDemand, poFetchDetailsOnDemand, poAllowCommandText]
    Left = 40
    Top = 162
  end
  object fdqAUT_USU: TFDQuery
    Connection = FDConnection
    Left = 119
    Top = 115
  end
  object dspAUT_USU: TDataSetProvider
    DataSet = fdqAUT_USU
    Options = [poFetchBlobsOnDemand, poFetchDetailsOnDemand, poAllowCommandText]
    Left = 119
    Top = 162
  end
  object fdqAUT_MOD: TFDQuery
    Connection = FDConnection
    Left = 203
    Top = 115
  end
  object dspAUT_MOD: TDataSetProvider
    DataSet = fdqAUT_MOD
    Options = [poFetchBlobsOnDemand, poFetchDetailsOnDemand, poAllowCommandText]
    Left = 203
    Top = 162
  end
  object fdqAUT_PRO: TFDQuery
    Connection = FDConnection
    Left = 282
    Top = 115
  end
  object dspAUT_PRO: TDataSetProvider
    DataSet = fdqAUT_PRO
    Options = [poFetchBlobsOnDemand, poFetchDetailsOnDemand, poAllowCommandText]
    Left = 282
    Top = 162
  end
  object fdqAUT_APE: TFDQuery
    Connection = FDConnection
    Left = 363
    Top = 115
  end
  object dspAUT_APE: TDataSetProvider
    DataSet = fdqAUT_APE
    Options = [poFetchBlobsOnDemand, poFetchDetailsOnDemand, poAllowCommandText]
    Left = 363
    Top = 162
  end
  object fdqAUT_AUS: TFDQuery
    Connection = FDConnection
    Left = 442
    Top = 115
  end
  object dspAUT_AUS: TDataSetProvider
    DataSet = fdqAUT_AUS
    Options = [poFetchBlobsOnDemand, poFetchDetailsOnDemand, poAllowCommandText]
    Left = 442
    Top = 162
  end
end
