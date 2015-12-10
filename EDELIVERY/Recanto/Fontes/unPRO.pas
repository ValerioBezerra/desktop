unit unPRO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPadrao, Data.DB, Datasnap.DBClient,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons;

type
  TfrmPRO = class(TfrmPadrao_)
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
  frmPRO: TfrmPRO;

implementation

{$R *.dfm}

uses  unDM, unCadPro;

procedure TfrmPRO.btnApagarClick(Sender: TObject);
var
buttonSelected : Integer;
begin
  buttonSelected := MessageDlg('Confirma a exclusão do registro?',mtCustom,
                               [mbYes,mbNo], 0);


   if buttonSelected = mrYes    then
      begin
        cdspadrao.Close;
        cdsPadrao.CommandText := 'select * from cliente where cod_pro = ' + cdsConsulta.FieldByName('COD_pro').AsString;
        cdspadrao.Open;
         inherited;
      end;

end;

procedure TfrmPRO.btnEditarClick(Sender: TObject);
begin
   where  := where + 'AND COD_pro = ' + DataModule1.cdsCONSULTA.FieldByName('COD_pro').AsString;
   inherited;
   Application.CreateForm(TFrmCADPRO,frmCadPRO);
   cdsPadrao.Open;
   cdsPadrao.Edit;
  frmCadPro.ShowModal;


end;

procedure TfrmPRO.btnNovoClick(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmCADPRO,frmCadPRO);
   cdsPadrao.Open;
   cdsPadrao.Insert;
  frmCadPro.ShowModal;
end;

procedure TfrmPRO.FormCreate(Sender: TObject);
begin
  inherited;
    cdsPadrao := DataModule1.cdsPRO;
    cdsConsulta := DataModule1.cdsCONSULTA;

    campos := '*';
    tabela := 'PRODUTOS';
    where := '';
    join := '';
    campoConsulta := 'NOME_PRO';
end;

end.
