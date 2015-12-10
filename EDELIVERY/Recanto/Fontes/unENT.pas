unit unENT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPadrao, Data.DB, Datasnap.DBClient,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons;

type
  TfrmENT = class(TfrmPadrao_)
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
  frmENT: TfrmENT;

implementation

{$R *.dfm}

uses  unDM, unCadEnt;

procedure TfrmENT.btnApagarClick(Sender: TObject);
var
buttonSelected : Integer;
begin
  buttonSelected := MessageDlg('Confirma a exclusão do registro?',mtCustom,
                               [mbYes,mbNo], 0);


   if buttonSelected = mrYes    then
      begin
        cdspadrao.Close;
        cdsPadrao.CommandText := 'select * from cliente where cod_ent = ' + cdsConsulta.FieldByName('COD_ent').AsString;
        cdspadrao.Open;
         inherited;
      end;

end;

procedure TfrmENT.btnEditarClick(Sender: TObject);
begin
   where  := where + 'AND COD_ent = ' + DataModule1.cdsCONSULTA.FieldByName('COD_ent').AsString;
   inherited;
   Application.CreateForm(TFrmCADENT,frmCadENT);
   cdsPadrao.Open;
   cdsPadrao.Edit;
  frmCadEnt.ShowModal;


end;

procedure TfrmENT.btnNovoClick(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmCADENT,frmCadENT);
   cdsPadrao.Open;
   cdsPadrao.Insert;
  frmCadEnt.ShowModal;
end;

procedure TfrmENT.FormCreate(Sender: TObject);
begin
  inherited;
    cdsPadrao := DataModule1.cdsENT;
    cdsConsulta := DataModule1.cdsCONSULTA;

    campos := '*';
    tabela := 'ENTREGADOR';
    where := '';
    join := '';
    campoConsulta := 'NOME_ENT';
end;

end.
