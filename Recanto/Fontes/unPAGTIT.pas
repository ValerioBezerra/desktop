unit unPAGTIT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPadrao, Data.DB, Datasnap.DBClient,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons;

type
  TfrmPAGTIT = class(TfrmPadrao_)
    RadioGroup1: TRadioGroup;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    RadioGroup2: TRadioGroup;
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
      procedure executarSQL;
  public
    { Public declarations }
  end;

var
  frmPAGTIT: TfrmPAGTIT;

implementation

{$R *.dfm}

uses unCadCLI, unDM, unMOVPAGTIT;

procedure TfrmPAGTIT.btnApagarClick(Sender: TObject);
var
buttonSelected : Integer;
begin
  buttonSelected := MessageDlg('Confirma a exclus�o do registro?',mtCustom,
                               [mbYes,mbNo], 0);


   if buttonSelected = mrYes    then
      begin
        cdspadrao.Close;
        cdsPadrao.CommandText := 'select * from PAGTIT where SEQ_PAGTIT = ' + cdsConsulta.FieldByName('SEQ_PAGTIT').AsString;
        cdspadrao.Open;
         inherited;
      end;

end;

procedure TfrmPAGTIT.btnEditarClick(Sender: TObject);
begin

   Application.CreateForm(TFrmMOVPAGTIT,frmMOVPAGTIT);
   cdsPadrao.Open;
   cdsPadrao.Edit;
  frmMOVPAGTIT.ShowModal;
  inherited;

end;

procedure TfrmPAGTIT.btnNovoClick(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmMOVPAGTIT,frmMOVPAGTIT);
   cdsPadrao.Open;
   cdsPadrao.Insert;
  frmMOVPAGTIT.ShowModal;
end;

procedure TfrmPAGTIT.btnPesquisarClick(Sender: TObject);
begin
     where := '';
     if CheckBox1.Checked then
     begin

          if RadioGroup2.ItemIndex = 0 then
              where := where + 'and DATAEMISSAO_PAGTTIT Between ' + VartoStr(DateTimePicker1.Date) + 'and ' + VartoStr(DateTimePicker2.Date)
          else
              where := where + 'and DATAVENC_PAGTIT Between ' + VartoStr(DateTimePicker1.Date) + 'and ' + VartoStr(DateTimePicker2.Date);
     end;

     if RadioGroup1.ItemIndex = 0 then
        where := where + 'and VALORPAGO_PAGTIT <> VALORTOTAL_PAGTIT '
     else if RadioGroup1.ItemIndex = 1 then
         where := where + 'and VALORPAGO_PAGTIT = VALORTOTAL_PAGTIT ';
  inherited;

end;

procedure TfrmPAGTIT.executarSQL;
begin



  inherited;

end;

procedure TfrmPAGTIT.FormCreate(Sender: TObject);
begin
  inherited;
    cdsPadrao := DataModule1.cdsPAGTIT;
    cdsConsulta := DataModule1.cdsCONSULTA;

    campos := '*';
    tabela := 'PAGTIT';
    where := '';
    join := 'LEFT OUTER JOIN FORNECEDOR ON CODIGO_FOR = CODFOR_PAGTIT ';
    campoConsulta := 'NOME_FOR';
end;

end.
