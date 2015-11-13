unit uCMKingGeral;

interface

uses
  System.SysUtils, System.Classes, CCKingGeral, Data.DBXDataSnap,
  IPPeerClient, Data.DBXCommon, Data.DB, Data.SqlExpr, Datasnap.DBClient,
  Datasnap.DSConnect;

type
  TClientModule1 = class(TDataModule)
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
  ClientModule1: TClientModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TClientModule1.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule1.Destroy;
begin
  FSMKingGeralClient.Free;
  inherited;
end;

function TClientModule1.GetSMKingGeralClient: TSMKingGeralClient;
begin
  if FSMKingGeralClient = nil then
  begin
    SQLConnection.Open;
    FSMKingGeralClient:= TSMKingGeralClient.Create(SQLConnection.DBXConnection, FInstanceOwner);
  end;
  Result := FSMKingGeralClient;
end;

end.
