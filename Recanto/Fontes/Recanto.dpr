program Recanto;

uses
  Vcl.Forms,
  unLogin in 'unLogin.pas' {frmLogin},
  unDM in 'unDM.pas' {DataModule1: TDataModule},
  unConsGRP in 'unConsGRP.pas' {fmrConsGRP},
  unPrincipal in 'unPrincipal.pas' {frmPRINCIPAL},
  frmPadrao in 'C:\valerio\delphi\Formularios\frmPadrao.pas' {frmPadrao_},
  frmPadraoManutencao in 'C:\valerio\delphi\Formularios\frmPadraoManutencao.pas' {frmPadraoManutencao_},
  unFOR in 'unFOR.pas' {frmFOR},
  unCadFOR in 'unCadFOR.pas' {frmCadFOR},
  unFUN in 'unFUN.pas' {frmFUN},
  unCadFUN in 'unCadFUN.pas' {frmCadFUN},
  unPAGBXA in 'unPAGBXA.pas' {frmPAGBXA},
  unCADITE in 'unCADITE.pas' {frmCadITE},
  unTER in 'unTER.pas' {frmTER},
  unCadTER in 'unCadTER.pas' {frmCadTER},
  unConsUSUARIO in 'unConsUSUARIO.pas' {Form1},
  unITE in 'unITE.pas' {frmITE},
  unRELFOR in 'unRELFOR.pas' {frmRELFOR},
  unPAGTIT in 'unPAGTIT.pas' {frmPAGTIT},
  unMOVPAGTIT in 'unMOVPAGTIT.pas' {frmMOVPAGTIT},
  unConsFORNECEDOR in 'unConsFORNECEDOR.pas' {fmrConsFORNECEDOR},
  unRELCLI in 'unRELCLI.pas' {frmRELCLI},
  unGRP in 'unGRP.pas' {frmGRP},
  unCadGRP in 'unCadGRP.pas' {frmCadGRP},
  unCLI in 'unCLI.pas' {frmCLI},
  unCadCLI in 'unCadCLI.pas' {frmCadCLI},
  unRECTIT in 'unRECTIT.pas' {frmRECTIT},
  unMOVRECTIT in 'unMOVRECTIT.pas' {frmMOVRECTIT},
  unConsCLIENTE in 'unConsCLIENTE.pas' {fmrConsCLIENTE};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmPRINCIPAL, frmPRINCIPAL);
  Application.CreateForm(TfrmPadrao_, frmPadrao_);
  Application.CreateForm(TfrmPadraoManutencao_, frmPadraoManutencao_);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
