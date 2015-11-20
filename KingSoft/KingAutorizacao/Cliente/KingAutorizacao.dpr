program KingAutorizacao;

uses
  Vcl.Forms,
  uKingAutorizacao in 'uKingAutorizacao.pas' {Form1},
  uCCKingAutorizacao in 'uCCKingAutorizacao.pas',
  uCMKingAutorizacao in 'uCMKingAutorizacao.pas' {cmKingAutorizacao: TDataModule},
  uSicronizacao in '..\..\KingLib\uSicronizacao.pas',
  uParametro in '..\..\KingLib\uParametro.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TcmKingAutorizacao, cmKingAutorizacao);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
