unit unITE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPadrao, Data.DB, Datasnap.DBClient,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons;

type
  TfrmITE = class(TfrmPadrao_)
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
  private
    { Private declarations }
      procedure executarSQL;
  public
    { Public declarations }
  end;

var
  frmITE: TfrmITE;

implementation

{$R *.dfm}

uses unCadCLI, unDM,  unCADITE;

procedure TfrmITE.btnApagarClick(Sender: TObject);
var
buttonSelected : Integer;
begin
  buttonSelected := MessageDlg('Confirma a exclusão do registro?',mtCustom,
                               [mbYes,mbNo], 0);


   if buttonSelected = mrYes    then
      begin
        cdspadrao.Close;
        cdsPadrao.CommandText := 'select * from ESTITE where CODIGO_ITE = ' + cdsConsulta.FieldByName('CODIGO_ITE').AsString;
        cdspadrao.Open;
         inherited;
      end;

end;

procedure TfrmITE.btnEditarClick(Sender: TObject);
begin
 where := where +' and CODIGO_ITE =' + DataModule1.cdsCONSULTA.FieldByName('CODIGO_ITE').AsString;
  inherited;
   Application.CreateForm(TfrmCADITE,frmCADITE);
   cdsPadrao.Open;
   cdsPadrao.Edit;
   frmCADITE.DBEdit4Exit(Self);
  frmCADITE.ShowModal;
      btnPesquisarClick(Self);

end;

procedure TfrmITE.btnNovoClick(Sender: TObject);
begin

  Application.CreateForm(TfrmCADITE,frmCADITE);
   cdsPadrao.Open;
   cdsPadrao.Insert;
  frmCADITE.ShowModal;
    inherited;
end;

procedure TfrmITE.executarSQL;
begin



  inherited;

end;

procedure TfrmITE.FormCreate(Sender: TObject);
begin
  inherited;
    cdsPadrao := DataModule1.cdsESTITE;
    cdsConsulta := DataModule1.cdsCONSULTA;



    campos := '*';
    tabela := 'ESTITE';
    where := '';
    join := '';
    campoConsulta := 'DESCRICAO_ITE';
end;

end.
