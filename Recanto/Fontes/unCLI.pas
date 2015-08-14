unit unCLI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPadrao, Data.DB, Datasnap.DBClient,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons;

type
  TfrmCLI = class(TfrmPadrao_)
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCLI: TfrmCLI;

implementation

{$R *.dfm}

uses unCadCLI, unDM;

procedure TfrmCLI.btnNovoClick(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmCADCLI,frmCadCLI);
   cdsPadrao.Open;
   cdsPadrao.Insert;
  frmCadCli.ShowModal;
end;

procedure TfrmCLI.FormCreate(Sender: TObject);
begin
  inherited;
    cdsPadrao := DataModule1.cdsCLIENTE;
    cdsConsulta := DataModule1.cdsCONSULTA;
    campos := '*';
    tabela := 'CLIENTE';
    where := '';
    join := '';
    campoConsulta := 'NOME_CLI';
end;

end.
