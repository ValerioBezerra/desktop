program KingAutorizacao;

uses
  Vcl.Forms,
  uCCKingAutorizacao in 'uCCKingAutorizacao.pas',
  uCMKingAutorizacao in 'uCMKingAutorizacao.pas' {cmKingAutorizacao: TDataModule},
  uSicronizacao in '..\..\KingLib\uSicronizacao.pas',
  uParametro in '..\..\KingLib\uParametro.pas',
  uEmpresa in '..\..\KingLib\uEmpresa.pas',
  uModulo in '..\..\KingLib\uModulo.pas',
  uPrograma in '..\..\KingLib\uPrograma.pas',
  uUsuario in '..\..\KingLib\uUsuario.pas',
  uUtil in '..\..\KingLib\uUtil.pas',
  uPerfil in '..\..\KingLib\uPerfil.pas',
  uKingAutorizacao in 'uKingAutorizacao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TcmKingAutorizacao, cmKingAutorizacao);
  TKingAutorizacao.AbrirPrograma;
  Application.Run;
end.
