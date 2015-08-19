program Recanto;

uses
  Vcl.Forms,
  unLogin in 'unLogin.pas' {frmLogin},
  unDM in 'unDM.pas' {DataModule1: TDataModule},
  unConsUSUARIO in 'unConsUSUARIO.pas' {Form1},
  unPrincipal in 'unPrincipal.pas' {frmPRINCIPAL},
  frmPadrao in 'C:\valerio\delphi\Formularios\frmPadrao.pas' {frmPadrao_},
  frmPadraoManutencao in 'C:\valerio\delphi\Formularios\frmPadraoManutencao.pas' {frmPadraoManutencao_},
  unCLI in 'unCLI.pas' {frmCLI},
  unCadCLI in 'unCadCLI.pas' {frmCadCLI};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmPRINCIPAL, frmPRINCIPAL);
  Application.CreateForm(TfrmPadrao_, frmPadrao_);
  Application.CreateForm(TfrmPadraoManutencao_, frmPadraoManutencao_);
  Application.CreateForm(TfrmCLI, frmCLI);
  Application.CreateForm(TfrmCadCLI, frmCadCLI);
  Application.Run;
end.
