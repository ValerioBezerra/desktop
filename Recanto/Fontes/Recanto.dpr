program Recanto;

uses
  Vcl.Forms,
  unLogin in 'unLogin.pas' {frmLogin},
  unDM in 'unDM.pas' {DataModule1: TDataModule},
  unConsCLIENTE in 'unConsCLIENTE.pas' {fmrConsCLIENTE},
  unPrincipal in 'unPrincipal.pas' {frmPRINCIPAL},
  frmPadrao in 'C:\valerio\delphi\Formularios\frmPadrao.pas' {frmPadrao_},
  frmPadraoManutencao in 'C:\valerio\delphi\Formularios\frmPadraoManutencao.pas' {frmPadraoManutencao_},
  unFOR in 'unFOR.pas' {frmFOR},
  unCadFOR in 'unCadFOR.pas' {frmCadFOR},
  unFUN in 'unFUN.pas' {frmFUN},
  unCadFUN in 'unCadFUN.pas' {frmCadFUN},
  unPAGBXA in 'unPAGBXA.pas' {frmPAGBXA},
  unMOVRECTIT in 'unMOVRECTIT.pas' {frmMOVRECTIT},
  unCLI in 'unCLI.pas' {frmCLI},
  unCadCLI in 'unCadCLI.pas' {frmCadCLI},
  unConsUSUARIO in 'unConsUSUARIO.pas' {Form1},
  unRECTIT in 'unRECTIT.pas' {frmRECTIT},
  unRELFOR in 'unRELFOR.pas' {frmRELFOR},
  unPAGTIT in 'unPAGTIT.pas' {frmPAGTIT},
  unMOVPAGTIT in 'unMOVPAGTIT.pas' {frmMOVPAGTIT},
  unConsFORNECEDOR in 'unConsFORNECEDOR.pas' {fmrConsFORNECEDOR},
  unRELCLI in 'unRELCLI.pas' {frmRELCLI};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfmrConsCLIENTE, fmrConsCLIENTE);
  Application.CreateForm(TfrmPRINCIPAL, frmPRINCIPAL);
  Application.CreateForm(TfrmPadrao_, frmPadrao_);
  Application.CreateForm(TfrmPadraoManutencao_, frmPadraoManutencao_);
  Application.CreateForm(TfrmCLI, frmCLI);
  Application.CreateForm(TfrmCadCLI, frmCadCLI);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
