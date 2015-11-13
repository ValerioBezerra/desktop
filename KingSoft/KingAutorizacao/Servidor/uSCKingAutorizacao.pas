unit uSCKingAutorizacao;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSAuth, IPPeerServer;

type
  TSCKingAutorizacao = class(TDataModule)
    DSServer: TDSServer;
    DSTCPServerTransport: TDSTCPServerTransport;
    DSServerClass: TDSServerClass;
    procedure DSServerClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
  end;

var
  SCKingAutorizacao: TSCKingAutorizacao;

implementation


{$R *.dfm}

uses Winapi.Windows, uSMKingAutorizacao;

procedure TSCKingAutorizacao.DSServerClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := uSMKingAutorizacao.TSMKingAutorizacao;
end;


end.

