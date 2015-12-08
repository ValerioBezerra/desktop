program SRVKingAutorizacao;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uKingAutorizacao in 'uKingAutorizacao.pas' {Form1},
  uSMKingAutorizacao in 'uSMKingAutorizacao.pas' {SMKingAutorizacao: TDSServerModule},
  uSCKingAutorizacao in 'uSCKingAutorizacao.pas' {SCKingAutorizacao: TDataModule},
  uConfiguracao in '..\..\KingLib\uConfiguracao.pas',
  uParametro in '..\..\KingLib\uParametro.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TSCKingAutorizacao, SCKingAutorizacao);
  Application.Run;
end.

