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
  uSicronizacao in '..\..\KingLib\uSicronizacao.pas',
<<<<<<< HEAD
  uFrmGER005 in 'uFrmGER005.pas' {frmGER005},
  uFrmGER005Consulta in 'uFrmGER005Consulta.pas' {frmGER005Consulta},
=======
  uFrmGER004 in 'uFrmGER004.pas' {frmGER004},
  uFrmGER004Consulta in 'uFrmGER004Consulta.pas' {frmGER004Consulta},
>>>>>>> e821aa6083e228586e6cd44515844c5f81de317e
  uFrmGER001Consulta in 'uFrmGER001Consulta.pas' {frmGER001Consulta},
  uFrmGER001 in 'uFrmGER001.pas' {frmGER001},
  uFrmGER002 in 'uFrmGER002.pas' {frmGER002},
  uFrmGER002Consulta in 'uFrmGER002Consulta.pas' {frmGER002Consulta},
<<<<<<< HEAD
  uFrmGER006Consulta in 'uFrmGER006Consulta.pas' {frmGER006Consulta},
  uFrmGER006 in 'uFrmGER006.pas' {frmGER006},
  uFrmGER003 in 'uFrmGER003.pas' {frmGER003},
=======
>>>>>>> e821aa6083e228586e6cd44515844c5f81de317e
  uFrmGER003Consulta in 'uFrmGER003Consulta.pas' {frmGER003Consulta};

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
