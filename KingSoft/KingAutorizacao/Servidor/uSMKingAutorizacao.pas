unit uSMKingAutorizacao;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Datasnap.Provider, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IBBase, uParametro;

type
  TSMKingAutorizacao = class(TDSServerModule)
    FDConnection: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    fdqConsulta: TFDQuery;
    dspConsulta: TDataSetProvider;
    fdqAUT_PER: TFDQuery;
    dspAUT_PER: TDataSetProvider;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function TestarDados(Parametro: TParametro): String;
    procedure StartTransaction;
    procedure Commit;
    procedure RollBack;
  end;

implementation


{$R *.dfm}


uses System.StrUtils, uConexao;

procedure TSMKingAutorizacao.Commit;
begin
  if (FDConnection.InTransaction) then
    FDConnection.Commit;
end;

procedure TSMKingAutorizacao.DSServerModuleCreate(Sender: TObject);
var
  Conexao: TConexao;
begin
  Conexao := TConexao.Create;

  FDConnection.Close;
  FDConnection.Params.Values['DriverID']  := 'FB';
  FDConnection.Params.Values['Database']  := Conexao.DataBase;
  FDConnection.Params.Values['User_Name'] := 'SYSDBA';
  FDConnection.Params.Values['Password']  := 'masterkey';
  FDConnection.Params.Values['Protocol']  := 'TCPIP';
  FDConnection.Params.Values['Server']    := Conexao.Server;
  FDPhysFBDriverLink.VendorLib            := Conexao.VendorLib;
end;

procedure TSMKingAutorizacao.RollBack;
begin
  if (FDConnection.InTransaction) then
    FDConnection.Rollback;
end;

procedure TSMKingAutorizacao.StartTransaction;
begin
  FDConnection.StartTransaction;
end;

function TSMKingAutorizacao.TestarDados(Parametro: TParametro): String;
begin

end;

end.

