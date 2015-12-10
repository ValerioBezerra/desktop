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
    ContasaPagar2: TMenuItem;
    tulo1: TMenuItem;
    BaixadeTtulo1: TMenuItem;
    ContasaReceber2: TMenuItem;
    Clientes1: TMenuItem;
    ContasaPagar3: TMenuItem;
    Fornecedores1: TMenuItem;
    tulos1: TMenuItem;
    tulos2: TMenuItem;
    procedure Cliente1Click(Sender: TObject);
    procedure Fornecedor1Click(Sender: TObject);
    procedure Funcionrio1Click(Sender: TObject);
    procedure tulo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPRINCIPAL: TfrmPRINCIPAL;

implementation

{$R *.dfm}

uses unCLI, unFOR, unFUN, unPAGTIT;

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

procedure TfrmPRINCIPAL.tulo1Click(Sender: TObject);
begin
        Application.CreateForm(TfrmPAGTIT,frmPAGTIT);
     frmPAGTIT.ShowModal;
end;

end.
