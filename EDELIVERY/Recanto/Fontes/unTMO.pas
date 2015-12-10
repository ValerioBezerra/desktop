unit unTMO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPadrao, Data.DB, Datasnap.DBClient,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons;

type
  TfrmTMO = class(TfrmPadrao_)
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
  frmTMO: TfrmTMO;

implementation

{$R *.dfm}

uses  unDM, unCadTMO;

procedure TfrmTMO.btnApagarClick(Sender: TObject);
var
buttonSelected : Integer;
begin
  buttonSelected := MessageDlg('Confirma a exclusão do registro?',mtCustom,
                               [mbYes,mbNo], 0);


   if buttonSelected = mrYes    then
      begin
        cdspadrao.Close;
        cdsPadrao.CommandText := 'select * from esttmo where codigo_tmo = ' + cdsConsulta.FieldByName('CODIGO_TMO').AsString;
        cdspadrao.Open;
         inherited;
      end;

end;

procedure TfrmTMO.btnEditarClick(Sender: TObject);
begin

   Application.CreateForm(TFrmCADTMO,frmCadTMO);
   cdsPadrao.Open;
   cdsPadrao.Edit;
  frmCadTMO.ShowModal;
  inherited;

end;

procedure TfrmTMO.btnNovoClick(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmCADTMO,frmCadTMO);
   cdsPadrao.Open;
   cdsPadrao.Insert;

  frmCadTMO.ShowModal;
end;

procedure TfrmTMO.FormCreate(Sender: TObject);
begin
  inherited;
    cdsPadrao := DataModule1.cdsESTTMO;
    cdsConsulta := DataModule1.cdsCONSULTA;

    campos := '*';
    tabela := 'ESTTMO';
    where := '';
    join := '';
    campoConsulta := 'DESCRICAO_TMO';
end;

end.
