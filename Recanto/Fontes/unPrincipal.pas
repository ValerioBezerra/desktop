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
    ContasaPagar1: TMenuItem;
    Fornecedor1: TMenuItem;
    Movimento1: TMenuItem;
    Relatrios1: TMenuItem;
    Sair1: TMenuItem;
    FolhadePagamento1: TMenuItem;
    Funcionrio1: TMenuItem;
    procedure Cliente1Click(Sender: TObject);
    procedure Fornecedor1Click(Sender: TObject);
    procedure Funcionrio1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPRINCIPAL: TfrmPRINCIPAL;

implementation

{$R *.dfm}

uses unCLI, unFOR, unFUN;

procedure TfrmPRINCIPAL.Cliente1Click(Sender: TObject);
begin
     Application.CreateForm(TfrmCli,frmCLI);
     frmClI.ShowModal;
end;

procedure TfrmPRINCIPAL.Fornecedor1Click(Sender: TObject);
begin
    Application.CreateForm(TfrmFor,frmFor);
     frmFor.ShowModal;
end;

procedure TfrmPRINCIPAL.Funcionrio1Click(Sender: TObject);
begin
     Application.CreateForm(TfrmFun,frmFun);
     frmFun.ShowModal;
end;

end.
