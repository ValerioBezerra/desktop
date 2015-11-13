program KingGeral;

uses
  Vcl.Forms,
  uKingGeral in 'uKingGeral.pas' {Form1},
  uCCKingGeral in 'uCCKingGeral.pas',
  uCMKingGeral in 'uCMKingGeral.pas' {ClientModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.Run;
end.
