unit unGRP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPadrao, Data.DB, Datasnap.DBClient,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons;

type
  TfrmGRP = class(TfrmPadrao_)
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
  frmGRP: TfrmGRP;

implementation

{$R *.dfm}

uses  unDM, unCadGRP;

procedure TfrmGRP.btnApagarClick(Sender: TObject);
var
buttonSelected : Integer;
begin
  buttonSelected := MessageDlg('Confirma a exclusão do registro?',mtCustom,
                               [mbYes,mbNo], 0);


   if buttonSelected = mrYes    then
      begin
        cdspadrao.Close;
        cdsPadrao.CommandText := 'select * from estgrp where codigo_grp = ' + cdsConsulta.FieldByName('CODIGO_GRP').AsString;
        cdspadrao.Open;
         inherited;
      end;

end;

procedure TfrmGRP.btnEditarClick(Sender: TObject);
begin
   where  := where + 'AND CODIGO_GRP = ' + DataModule1.cdsCONSULTA.FieldByName('CODIGO_GRP').AsString;
   inherited;
   Application.CreateForm(TfrmCadGRP,frmCadGRP);
   cdsPadrao.Open;
   cdsPadrao.Edit;
  frmCadGRP.ShowModal;
   btnPesquisarClick(Self);

end;

procedure TfrmGRP.btnNovoClick(Sender: TObject);
begin

  Application.CreateForm(TfrmCadGRP,frmCadGRP);
   cdsPadrao.Open;
   cdsPadrao.Insert;
  frmCadGRP.ShowModal;
    inherited;
end;

procedure TfrmGRP.FormCreate(Sender: TObject);
begin
  inherited;
    cdsPadrao := DataModule1.cdsESTGRP;
    cdsConsulta := DataModule1.cdsCONSULTA;

    campos := '*';
    tabela := 'ESTGRP';
    where := '';
    join := '';
    campoConsulta := 'DESCRICAO_GRP';
end;

end.
