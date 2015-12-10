program KingGeral;

uses
  Vcl.Forms,
  uCMKingGeral in 'uCMKingGeral.pas' {cmKingGeral: TDataModule},
  uCCKingGeral in 'uCCKingGeral.pas',
  uEmpresa in '..\..\KingLib\uEmpresa.pas',
  uFrmPadrao in '..\..\KingLib\uFrmPadrao.pas' {frmPadrao},
  uFrmPadraoConsulta in '..\..\KingLib\uFrmPadraoConsulta.pas' {frmPadraoConsulta},
  uModulo in '..\..\KingLib\uModulo.pas',
  uParametro in '..\..\KingLib\uParametro.pas',
  uPerfil in '..\..\KingLib\uPerfil.pas',
  uPrograma in '..\..\KingLib\uPrograma.pas',
  uUsuario in '..\..\KingLib\uUsuario.pas',
  uUtil in '..\..\KingLib\uUtil.pas',
  uKingGeral in 'uKingGeral.pas',
  Vcl.Themes,
  Vcl.Styles,
  uSicronizacao in '..\..\KingLib\uSicronizacao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm      := False;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.CreateForm(TcmKingGeral, cmKingGeral);
  Application.Run;
  TKingGeral.AbrirPrograma;
  Application.Terminate;
end.
