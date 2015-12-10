unit uSMKingGeral;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, Data.DB,
  FireDAC.Comp.Client, Dialogs, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Datasnap.Provider, FireDAC.Comp.DataSet,
  FireDAC.Phys.IBBase, uParametro;

type
  TSMKingGeral = class(TDSServerModule)
    FDConnection: TFDConnection;
    fdqConsulta: TFDQuery;
    dspConsulta: TDataSetProvider;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    fdqGER_PAI: TFDQuery;
    dspGER_PAI: TDataSetProvider;
    fdqGER_EST: TFDQuery;
    dspGER_EST: TDataSetProvider;
    fdqGER_CID: TFDQuery;
    dspGER_CID: TDataSetProvider;
    fdqGER_BAI: TFDQuery;
    dspGER_BAI: TDataSetProvider;
    fdqGER_TLG: TFDQuery;
    dspGER_TLG: TDataSetProvider;
    fdqGER_LOG: TFDQuery;
    dspGER_LOG: TDataSetProvider;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function TestarDados(Parametro: TParametro; Dados: OleVariant): String;
    procedure StartTransaction;
    procedure Commit;
    procedure RollBack;
  end;

implementation


{$R *.dfm}


uses System.StrUtils, uConfiguracao;

procedure TSMKingGeral.Commit;
begin
  if (FDConnection.InTransaction) then
    FDConnection.Commit;
end;

procedure TSMKingGeral.DSServerModuleCreate(Sender: TObject);
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

procedure TSMKingGeral.RollBack;
begin
  if (FDConnection.InTransaction) then
    FDConnection.Rollback;
end;

procedure TSMKingGeral.StartTransaction;
begin
  FDConnection.StartTransaction;
end;

function TSMKingGeral.TestarDados(Parametro: TParametro; Dados: OleVariant): String;
begin

end;

end.

