program Gerenciador;

uses
  Vcl.Forms,
  DM_GERENCIADOR in 'DM_GERENCIADOR.pas' {DM: TDataModule},
  unLogin_GERENCIADOR in 'unLogin_GERENCIADOR.pas' {frmLogin},
  unConsUSUARIO in 'unConsUSUARIO.pas' {Form1},
  unMenuGerenciador in 'unMenuGerenciador.pas' {MenuGerenciador},
  unLicenca in 'unLicenca.pas' {frmLicenca};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TMenuGerenciador, MenuGerenciador);
  Application.CreateForm(TfrmLicenca, frmLicenca);
  Application.Run;
end.
