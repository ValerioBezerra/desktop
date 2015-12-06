unit uCMKingAutorizacao;

interface

uses
  System.SysUtils, System.Classes, uCCKingAutorizacao, Data.DBXDataSnap,
  IPPeerClient, Data.DBXCommon, Data.DB, Data.SqlExpr, Datasnap.DBClient,
  Datasnap.DSConnect, uParametro;

type
  TcmKingAutorizacao = class(TDataModule)
    SQLConnection: TSQLConnection;
    DSProviderConnection: TDSProviderConnection;
    cdsConsulta: TClientDataSet;
    dsConsulta: TDataSource;
    cdsAUT_PER: TClientDataSet;
    dsAUT_PER: TDataSource;
    cdsAUT_USU: TClientDataSet;
    dsAUT_USU: TDataSource;
    cdsAUT_MOD: TClientDataSet;
    dsAUT_MOD: TDataSource;
    cdsAUT_PRO: TClientDataSet;
    dsAUT_PRO: TDataSource;
    cdsAUT_APE: TClientDataSet;
    dsAUT_APE: TDataSource;
    cdsAUT_AUS: TClientDataSet;
    dsAUT_AUS: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    FInstanceOwner: Boolean;
    FSMKingAutorizacaoClient: TSMKingAutorizacaoClient;
    function GetSMKingAutorizacaoClient: TSMKingAutorizacaoClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property SMKingAutorizacaoClient: TSMKingAutorizacaoClient read GetSMKingAutorizacaoClient write FSMKingAutorizacaoClient;
    function TestarDados(AIdEmpresa: Integer; ATabela, AOperacao: String; ADados: Variant): Boolean;

end;

var
  cmKingAutorizacao: TcmKingAutorizacao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uSicronizacao, uUtil;

{$R *.dfm}

constructor TcmKingAutorizacao.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

procedure TcmKingAutorizacao.DataModuleCreate(Sender: TObject);
var
  Sicronizacao: TSicronizacao;
begin
  Sicronizacao := TSicronizacao.Create;
  SQLConnection.Params.Values['HostName'] := Sicronizacao.HostName;
end;

destructor TcmKingAutorizacao.Destroy;
begin
  FSMKingAutorizacaoClient.Free;
  inherited;
end;

function TcmKingAutorizacao.GetSMKingAutorizacaoClient: TSMKingAutorizacaoClient;
begin
  if FSMKingAutorizacaoClient = nil then
  begin
    SQLConnection.Open;
    FSMKingAutorizacaoClient:= TSMKingAutorizacaoClient.Create(SQLConnection.DBXConnection, FInstanceOwner);
  end;
  Result := FSMKingAutorizacaoClient;
end;

function TcmKingAutorizacao.TestarDados(AIdEmpresa: Integer; ATabela, AOperacao: String; ADados: Variant): Boolean;
begin
  Result := TUtil.TestarRetorno(AOperacao, SMKingAutorizacaoClient.TestarDados(TParametro.Create(AIdEmpresa, ATabela, AOperacao), ADados));
end;

end.
