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
    ContasaReceber3: TMenuItem;
    tulo2: TMenuItem;
    Hospedagem1: TMenuItem;
    erapias1: TMenuItem;
    procedure Cliente1Click(Sender: TObject);
    procedure Fornecedor1Click(Sender: TObject);
    procedure Funcionrio1Click(Sender: TObject);
    procedure tulo1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure tulo2Click(Sender: TObject);
    procedure Fornecedores1Click(Sender: TObject);
    procedure erapias1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPRINCIPAL: TfrmPRINCIPAL;

implementation

{$R *.dfm}

uses unCLI, unFOR, unFUN, unPAGTIT, unRELCLI, unRECTIT, unRELFOR, unTER;

procedure TfrmPRINCIPAL.Cliente1Click(Sender: TObject);
begin
     Application.CreateForm(TfrmCli,frmCLI);
     frmClI.ShowModal;
end;

procedure TfrmPRINCIPAL.Clientes1Click(Sender: TObject);
begin
      Application.CreateForm(TfrmRELCLI,frmRELCLI);
     frmRELCLI.ShowModal;
end;

procedure TfrmPRINCIPAL.erapias1Click(Sender: TObject);
begin
    Application.CreateForm(TfrmTER,frmTER);
     frmTER.ShowModal;
end;

procedure TfrmPRINCIPAL.Fornecedor1Click(Sender: TObject);
begin
    Application.CreateForm(TfrmFor,frmFor);
     frmFor.ShowModal;
end;

procedure TfrmPRINCIPAL.Fornecedores1Click(Sender: TObject);
begin
      Application.CreateForm(TfrmRELFOR,frmRELFOR);
     frmRELFOR.ShowModal;
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

procedure TfrmPRINCIPAL.tulo2Click(Sender: TObject);
begin
   Application.CreateForm(TfrmRECTIT,frmRECTIT);
     frmRECTIT.ShowModal;
end;

end.
