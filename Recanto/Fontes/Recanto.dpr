program Recanto;

uses
  Vcl.Forms,
  unLogin in 'unLogin.pas' {frmLogin},
  unDM in 'unDM.pas' {DataModule1: TDataModule},
  unConsFORNECEDOR in 'unConsFORNECEDOR.pas' {fmrConsFORNECEDOR},
  unPrincipal in 'unPrincipal.pas' {frmPRINCIPAL},
  frmPadrao in 'C:\valerio\delphi\Formularios\frmPadrao.pas' {frmPadrao_},
  frmPadraoManutencao in 'C:\valerio\delphi\Formularios\frmPadraoManutencao.pas' {frmPadraoManutencao_},
  unFOR in 'unFOR.pas' {frmFOR},
  unCadFOR in 'unCadFOR.pas' {frmCadFOR},
  unFUN in 'unFUN.pas' {frmFUN},
  unCadFUN in 'unCadFUN.pas' {frmCadFUN},
  unPAGBXA in 'unPAGBXA.pas' {frmPAGBXA},
  unMOVPAGTIT in 'unMOVPAGTIT.pas' {frmMOVPAGTIT},
  unCLI in 'unCLI.pas' {frmCLI},
  unCadCLI in 'unCadCLI.pas' {frmCadCLI},
  unConsUSUARIO in 'unConsUSUARIO.pas' {Form1},
  unPAGTIT in 'unPAGTIT.pas' {frmPAGTIT},
  unRELCLI in 'unRELCLI.pas' {frmRELCLI};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfmrConsFORNECEDOR, fmrConsFORNECEDOR);
  Application.CreateForm(TfrmPRINCIPAL, frmPRINCIPAL);
  Application.CreateForm(TfrmPadrao_, frmPadrao_);
  Application.CreateForm(TfrmPadraoManutencao_, frmPadraoManutencao_);
  Application.CreateForm(TfrmCLI, frmCLI);
  Application.CreateForm(TfrmCadCLI, frmCadCLI);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmRELCLI, frmRELCLI);
  Application.Run;
end.
