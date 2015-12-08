program KingAutorizacao;

uses
  Vcl.Forms,
  uCMKingAutorizacao in 'uCMKingAutorizacao.pas' {cmKingAutorizacao: TDataModule},
  uSicronizacao in '..\..\KingLib\uSicronizacao.pas',
  uParametro in '..\..\KingLib\uParametro.pas',
  uEmpresa in '..\..\KingLib\uEmpresa.pas',
  uModulo in '..\..\KingLib\uModulo.pas',
  uPrograma in '..\..\KingLib\uPrograma.pas',
  uUsuario in '..\..\KingLib\uUsuario.pas',
  uUtil in '..\..\KingLib\uUtil.pas',
  uPerfil in '..\..\KingLib\uPerfil.pas',
  uKingAutorizacao in 'uKingAutorizacao.pas',
  uFrmPadraoConsulta in '..\..\KingLib\uFrmPadraoConsulta.pas' {frmPadraoConsulta},
  Vcl.Themes,
  Vcl.Styles,
  uFrmAUT005Consulta in 'uFrmAUT005Consulta.pas' {frmAUT005Consulta},
  uFrmPadrao in '..\..\KingLib\uFrmPadrao.pas' {frmPadrao},
  uFrmAUT003 in 'uFrmAUT003.pas' {frmAUT003},
  uCCKingAutorizacao in 'uCCKingAutorizacao.pas',
  uFrmAUT004Consulta in 'uFrmAUT004Consulta.pas' {frmAUT004Consulta},
  uFrmAUT004 in 'uFrmAUT004.pas' {frmAUT004},
  uFrmAUT002Consulta in 'uFrmAUT002Consulta.pas' {frmAUT002Consulta},
  uFrmAUT005 in 'uFrmAUT005.pas' {frmAUT005},
  uFrmAUT003Consulta in 'uFrmAUT003Consulta.pas' {frmAUT003Consulta},
  uFrmAUT002 in 'uFrmAUT002.pas' {frmAUT002};

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm      := False;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.CreateForm(TcmKingAutorizacao, cmKingAutorizacao);
  Application.Run;
  TKingAutorizacao.AbrirPrograma;
  Application.Terminate;
end.
