// 
// Created by the DataSnap proxy generator.
// 19/11/2015 11:13:36 PM
// 

unit uCCKingAutorizacao;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, uParametro, Data.DBXJSONReflect;

type
  TSMKingAutorizacaoClient = class(TDSAdminClient)
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
    function TestarDados(Parametro: TParametro): string;
    procedure StartTransaction;
    procedure Commit;
    procedure RollBack;
  end;

implementation

procedure TSMKingAutorizacaoClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FDBXConnection.CreateCommand;
    FDSServerModuleCreateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDSServerModuleCreateCommand.Text := 'TSMKingAutorizacao.DSServerModuleCreate';
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

function TSMKingAutorizacaoClient.TestarDados(Parametro: TParametro): string;
begin
  if FTestarDadosCommand = nil then
  begin
    FTestarDadosCommand := FDBXConnection.CreateCommand;
    FTestarDadosCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FTestarDadosCommand.Text := 'TSMKingAutorizacao.TestarDados';
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
  FTestarDadosCommand.ExecuteUpdate;
  Result := FTestarDadosCommand.Parameters[1].Value.GetWideString;
end;

procedure TSMKingAutorizacaoClient.StartTransaction;
begin
  if FStartTransactionCommand = nil then
  begin
    FStartTransactionCommand := FDBXConnection.CreateCommand;
    FStartTransactionCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FStartTransactionCommand.Text := 'TSMKingAutorizacao.StartTransaction';
    FStartTransactionCommand.Prepare;
  end;
  FStartTransactionCommand.ExecuteUpdate;
end;

procedure TSMKingAutorizacaoClient.Commit;
begin
  if FCommitCommand = nil then
  begin
    FCommitCommand := FDBXConnection.CreateCommand;
    FCommitCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FCommitCommand.Text := 'TSMKingAutorizacao.Commit';
    FCommitCommand.Prepare;
  end;
  FCommitCommand.ExecuteUpdate;
end;

procedure TSMKingAutorizacaoClient.RollBack;
begin
  if FRollBackCommand = nil then
  begin
    FRollBackCommand := FDBXConnection.CreateCommand;
    FRollBackCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FRollBackCommand.Text := 'TSMKingAutorizacao.RollBack';
    FRollBackCommand.Prepare;
  end;
  FRollBackCommand.ExecuteUpdate;
end;


constructor TSMKingAutorizacaoClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TSMKingAutorizacaoClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TSMKingAutorizacaoClient.Destroy;
begin
  FDSServerModuleCreateCommand.DisposeOf;
  FTestarDadosCommand.DisposeOf;
  FStartTransactionCommand.DisposeOf;
  FCommitCommand.DisposeOf;
  FRollBackCommand.DisposeOf;
  inherited;
end;

end.
