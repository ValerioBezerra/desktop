unit uCMKingGeral;

interface

uses
  System.SysUtils, System.Classes, CCKingGeral, Data.DBXDataSnap,
  IPPeerClient, Data.DBXCommon, Data.DB, Data.SqlExpr, Datasnap.DBClient,
  Datasnap.DSConnect;

type
  TcmKingGeral = class(TDataModule)
    SQLConnection: TSQLConnection;
    DSProviderConnection: TDSProviderConnection;
    cdsConsulta: TClientDataSet;
  private
    FInstanceOwner: Boolean;
    FSMKingGeralClient: TSMKingGeralClient;
    function GetSMKingGeralClient: TSMKingGeralClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property SMKingGeralClient: TSMKingGeralClient read GetSMKingGeralClient write FSMKingGeralClient;

end;

var
  cmKingGeral: TcmKingGeral;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TcmKingGeral.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TcmKingGeral.Destroy;
begin
  FSMKingGeralClient.Free;
  inherited;
end;

function TcmKingGeral.GetSMKingGeralClient: TSMKingGeralClient;
begin
  if FSMKingGeralClient = nil then
  begin
    SQLConnection.Open;
    FSMKingGeralClient:= TSMKingGeralClient.Create(SQLConnection.DBXConnection, FInstanceOwner);
  end;
  Result := FSMKingGeralClient;
end;

end.
