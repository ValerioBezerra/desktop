unit unPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TfrmPRINCIPAL = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    ContasaReceber1: TMenuItem;
    Cliente1: TMenuItem;
    procedure Cliente1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPRINCIPAL: TfrmPRINCIPAL;

implementation

{$R *.dfm}

uses unCLI;

procedure TfrmPRINCIPAL.Cliente1Click(Sender: TObject);
begin
     Application.CreateForm(TfrmCli,frmCLI);
     frmClI.ShowModal;
end;

end.
