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
    fdqAUT_USU: TFDQuery;
    dspAUT_USU: TDataSetProvider;
    fdqAUT_MOD: TFDQuery;
    dspAUT_MOD: TDataSetProvider;
    fdqAUT_PRO: TFDQuery;
    dspAUT_PRO: TDataSetProvider;
    fdqAUT_APE: TFDQuery;
    dspAUT_APE: TDataSetProvider;
    fdqAUT_AUS: TFDQuery;
    dspAUT_AUS: TDataSetProvider;
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


uses System.StrUtils, uConfiguracao;

procedure TSMKingAutorizacao.Commit;
begin
  if (FDConnection.InTransaction) then
    FDConnection.Commit;
end;

procedure TSMKingAutorizacao.DSServerModuleCreate(Sender: TObject);
var
  Configuracao: TConfiguracao;
begin
  Configuracao := TConfiguracao.Create;

  FDConnection.Close;
  FDConnection.Params.Values['DriverID']  := 'FB';
  FDConnection.Params.Values['Database']  := Configuracao.DataBase;
  FDConnection.Params.Values['User_Name'] := 'SYSDBA';
  FDConnection.Params.Values['Password']  := 'masterkey';
  FDConnection.Params.Values['Protocol']  := 'TCPIP';
  FDConnection.Params.Values['Server']    := Configuracao.Server;
  FDPhysFBDriverLink.VendorLib            := Configuracao.VendorLib;
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

