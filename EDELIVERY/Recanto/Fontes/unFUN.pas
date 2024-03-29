unit unFUN;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPadrao, Data.DB, Datasnap.DBClient,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons;

type
  TfrmFUN = class(TfrmPadrao_)
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFUN: TfrmFUN;

implementation

{$R *.dfm}

uses unCadCLI, unDM, unCadFUN;

procedure TfrmFUN.btnApagarClick(Sender: TObject);
var
buttonSelected : Integer;
begin
  buttonSelected := MessageDlg('Confirma a exclus�o do registro?',mtCustom,
                               [mbYes,mbNo], 0);


   if buttonSelected = mrYes    then
      begin
        cdspadrao.Close;
        cdsPadrao.CommandText := 'select * from funcionario where codigo_fun = ' + cdsConsulta.FieldByName('CODIGO_FUN').AsString;
        cdspadrao.Open;
         inherited;
      end;

end;

procedure TfrmFUN.btnEditarClick(Sender: TObject);
begin

   Application.CreateForm(TFrmCADFUN,frmCadFUN);
   cdsPadrao.Open;
   cdsPadrao.Edit;
  frmCadFun.ShowModal;
  inherited;

end;

procedure TfrmFUN.btnNovoClick(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmCADFUN,frmCadFUN);
   cdsPadrao.Open;
   cdsPadrao.Insert;
  frmCadFun.ShowModal;
end;

procedure TfrmFUN.FormCreate(Sender: TObject);
begin
  inherited;
    cdsPadrao := DataModule1.cdsFUNCIONARIO;
    cdsConsulta := DataModule1.cdsCONSULTA;

    campos := '*';
    tabela := 'FUNCIONARIO';
    where := '';
    join := '';
    campoConsulta := 'NOME_FUN';
end;

end.
