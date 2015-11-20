program SRVKingGeral;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uKingGeral in 'uKingGeral.pas' {frmKingGeral},
  uSMKingGeral in 'uSMKingGeral.pas' {SMKingGeral: TDSServerModule},
  uSCKingGeral in 'uSCKingGeral.pas' {SCKingGeral: TDataModule},
  uParametro in '..\..\KingLib\uParametro.pas',
  uConfiguracao in '..\..\KingLib\uConfiguracao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmKingGeral, frmKingGeral);
  Application.CreateForm(TSCKingGeral, SCKingGeral);
  Application.Run;
end.

