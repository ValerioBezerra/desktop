unit unMenuGerenciador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TMenuGerenciador = class(TForm)
    MainMenu1: TMainMenu;
    Licena1: TMenuItem;
    Usurios1: TMenuItem;
    procedure Licena1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MenuGerenciador: TMenuGerenciador;

implementation

{$R *.dfm}

uses unLicenca;

procedure TMenuGerenciador.Licena1Click(Sender: TObject);
begin
     Application.CreateForm(TfrmLicenca,frmLicenca);
     frmLicenca.ShowModal;
end;

end.
