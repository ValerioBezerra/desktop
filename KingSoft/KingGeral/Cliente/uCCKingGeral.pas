// 
// Created by the DataSnap proxy generator.
// 10/12/2015 1:13:46 AM
// 

unit uCCKingGeral;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, uParametro, Data.DBXJSONReflect;

type
  TSMKingGeralClient = class(TDSAdminClient)
  private
    FDSServerModuleCreateCommand: TDBXCommand;
    FTestarDadosCommand: TDBXCommand;
    FStartTransactionCommand: TDBXCommand;
    FCommitCommand: TDBXCommand;
    FRollBackCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    function TestarDados(Parametro: TParametro; Dados: OleVariant): string;
    procedure StartTransaction;
    procedure Commit;
    procedure RollBack;
  end;

implementation

procedure TSMKingGeralClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FDBXConnection.CreateCommand;
    FDSServerModuleCreateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDSServerModuleCreateCommand.Text := 'TSMKingGeral.DSServerModuleCreate';
    FDSServerModuleCreateCommand.Prepare;
  end;
  if not Assigned(Sender) then
    FDSServerModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDSServerModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDSServerModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDSServerModuleCreateCommand.ExecuteUpdate;
end;

function TSMKingGeralClient.TestarDados(Parametro: TParametro; Dados: OleVariant): string;
begin
  if FTestarDadosCommand = nil then
  begin
    FTestarDadosCommand := FDBXConnection.CreateCommand;
    FTestarDadosCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FTestarDadosCommand.Text := 'TSMKingGeral.TestarDados';
    FTestarDadosCommand.Prepare;
  end;
  if not Assigned(Parametro) then
    FTestarDadosCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FTestarDadosCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FTestarDadosCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Parametro), True);
      if FInstanceOwner then
        Parametro.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FTestarDadosCommand.Parameters[1].Value.AsVariant := Dados;
  FTestarDadosCommand.ExecuteUpdate;
  Result := FTestarDadosCommand.Parameters[2].Value.GetWideString;
end;

procedure TSMKingGeralClient.StartTransaction;
begin
  if FStartTransactionCommand = nil then
  begin
    FStartTransactionCommand := FDBXConnection.CreateCommand;
    FStartTransactionCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FStartTransactionCommand.Text := 'TSMKingGeral.StartTransaction';
    FStartTransactionCommand.Prepare;
  end;
  FStartTransactionCommand.ExecuteUpdate;
end;

procedure TSMKingGeralClient.Commit;
begin
  if FCommitCommand = nil then
  begin
    FCommitCommand := FDBXConnection.CreateCommand;
    FCommitCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FCommitCommand.Text := 'TSMKingGeral.Commit';
    FCommitCommand.Prepare;
  end;
  FCommitCommand.ExecuteUpdate;
end;

procedure TSMKingGeralClient.RollBack;
begin
  if FRollBackCommand = nil then
  begin
    FRollBackCommand := FDBXConnection.CreateCommand;
    FRollBackCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FRollBackCommand.Text := 'TSMKingGeral.RollBack';
    FRollBackCommand.Prepare;
  end;
  FRollBackCommand.ExecuteUpdate;
end;


constructor TSMKingGeralClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TSMKingGeralClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TSMKingGeralClient.Destroy;
begin
  FDSServerModuleCreateCommand.DisposeOf;
  FTestarDadosCommand.DisposeOf;
  FStartTransactionCommand.DisposeOf;
  FCommitCommand.DisposeOf;
  FRollBackCommand.DisposeOf;
  inherited;
end;

end.
