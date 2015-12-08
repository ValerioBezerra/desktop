object SCKingGeral: TSCKingGeral
  OldCreateOrder = False
  Height = 271
  Width = 415
  object DSServer: TDSServer
    Left = 96
    Top = 11
  end
  object DSTCPServerTransport: TDSTCPServerTransport
    Port = 201501
    Server = DSServer
    Filters = <>
    Left = 96
    Top = 73
  end
  object DSServerClass: TDSServerClass
    OnGetClass = DSServerClassGetClass
    Server = DSServer
    Left = 200
    Top = 11
  end
end
