program Recanto;

uses
  Vcl.Forms,
  unLogin in 'unLogin.pas' {frmLogin},
  unDM in 'unDM.pas' {DataModule1: TDataModule},
  unConsGRP in 'unConsGRP.pas' {fmrConsGRP},
  unPrincipal in 'unPrincipal.pas' {frmPRINCIPAL},
  frmPadrao in 'C:\valerio\delphi\Formularios\frmPadrao.pas' {frmPadrao_},
  frmPadraoManutencao in 'C:\valerio\delphi\Formularios\frmPadraoManutencao.pas' {frmPadraoManutencao_},
  unTMO in 'unTMO.pas' {frmTMO},
  unCadTMO in 'unCadTMO.pas' {frmCadTMO},
  unFUN in 'unFUN.pas' {frmFUN},
  unCadFUN in 'unCadFUN.pas' {frmCadFUN},
  unPAGBXA in 'unPAGBXA.pas' {frmPAGBXA},
  unCADITE in 'unCADITE.pas' {frmCadITE},
  unTER in 'unTER.pas' {frmTER},
  unCadTER in 'unCadTER.pas' {frmCadTER},
  unConsUSUARIO in 'unConsUSUARIO.pas' {Form1},
  unITE in 'unITE.pas' {frmITE},
  unRELFOR in 'unRELFOR.pas' {frmRELFOR},
  unESTMOV in 'unESTMOV.pas' {frmESTMOV},
  unMOVESTMOV in 'unMOVESTMOV.pas' {frmMOVESTMOV},
  unConsFORNECEDOR in 'unConsFORNECEDOR.pas' {fmrConsFORNECEDOR},
  unRELPREVREC in 'unRELPREVREC.pas' {frmRELPREVREC},
  unGRP in 'unGRP.pas' {frmGRP},
  unCadGRP in 'unCadGRP.pas' {frmCadGRP},
  unCLI in 'unCLI.pas' {frmCLI},
  unCadCLI in 'unCadCLI.pas' {frmCadCLI},
  unRECTIT in 'unRECTIT.pas' {frmRECTIT},
  unMOVRECTIT in 'unMOVRECTIT.pas' {frmMOVRECTIT},
  unConsCLIENTE in 'unConsCLIENTE.pas' {fmrConsCLIENTE},
  unFOR in 'unFOR.pas' {frmFOR},
  unCadFOR in 'unCadFOR.pas' {frmCadFOR},
  unPAGTIT in 'unPAGTIT.pas' {frmPAGTIT},
  unMOVPAGTIT in 'unMOVPAGTIT.pas' {frmMOVPAGTIT},
  unRELCLI in 'unRELCLI.pas' {frmRELCLI};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmPadrao_, frmPadrao_);
  Application.CreateForm(TfrmPadraoManutencao_, frmPadraoManutencao_);
  Application.Run;
end.
