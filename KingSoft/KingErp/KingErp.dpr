program KingErp;

uses
  Vcl.Forms,
  uLogin in 'uLogin.pas' {frmLogin},
  Vcl.Themes,
  Vcl.Styles,
  uCMKingAutorizacao in '..\KingAutorizacao\Cliente\uCMKingAutorizacao.pas' {cmKingAutorizacao: TDataModule},
  uCCKingAutorizacao in '..\KingAutorizacao\Cliente\uCCKingAutorizacao.pas',
  uParametro in '..\KingLib\uParametro.pas',
  uSicronizacao in '..\KingLib\uSicronizacao.pas',
  uUtil in '..\KingLib\uUtil.pas',
  uCarregarAutorizacoes in 'uCarregarAutorizacoes.pas' {frmCarregarAutorizacoes},
  uKingErp in 'uKingErp.pas' {frmKingErp},
  uEmpresa in '..\KingLib\uEmpresa.pas',
  uUsuario in '..\KingLib\uUsuario.pas',
  uPerfil in '..\KingLib\uPerfil.pas',
  uPrograma in '..\KingLib\uPrograma.pas',
  uModulo in '..\KingLib\uModulo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Aqua Light Slate');
  Application.CreateForm(TcmKingAutorizacao, cmKingAutorizacao);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
