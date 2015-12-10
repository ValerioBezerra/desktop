unit unRECTIT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPadrao, Data.DB, Datasnap.DBClient,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons;

type
  TfrmRECTIT = class(TfrmPadrao_)
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
  frmRECTIT: TfrmRECTIT;

implementation

{$R *.dfm}

uses unCadCLI, unDM, unMOVPAGTIT;

procedure TfrmRECTIT.btnApagarClick(Sender: TObject);
var
buttonSelected : Integer;
begin
  buttonSelected := MessageDlg('Confirma a exclusão do registro?',mtCustom,
                               [mbYes,mbNo], 0);


   if buttonSelected = mrYes    then
      begin
        cdspadrao.Close;
        cdsPadrao.CommandText := 'select * from PAGTIT where SEQ_RECTIT = ' + cdsConsulta.FieldByName('SEQ_RECTIT').AsString;
        cdspadrao.Open;
         inherited;
      end;

end;

procedure TfrmRECTIT.btnEditarClick(Sender: TObject);
begin
 where := where +' and SEQ_RECTIT =' + DataModule1.cdsCONSULTA.FieldByName('SEQ_RECTIT').AsString;
  inherited;
   Application.CreateForm(TFrmMOVPAGTIT,frmMOVPAGTIT);
   cdsPadrao.Open;
   cdsPadrao.Edit;
   frmMOVPAGTIT.DBEdit4Exit(Self);
  frmMOVPAGTIT.ShowModal;


end;

procedure TfrmRECTIT.btnNovoClick(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFrmMOVPAGTIT,frmMOVPAGTIT);
   cdsPadrao.Open;
   cdsPadrao.Insert;
  frmMOVPAGTIT.ShowModal;
end;

procedure TfrmRECTIT.btnPesquisarClick(Sender: TObject);
begin
     where := '';
     if CheckBox1.Checked then
     begin
          if DateTimePicker1.Date > DateTimePicker2.Date then
          begin
                 showmessage('Data Inicial não pode ser maior que Data Final!');
                 Exit;
          end
          else
          begin

          if RadioGroup2.ItemIndex = 0 then
              where := where + 'and DATAEMISSAO_RECTIT between ' +  QuotedStr(StringReplace((DatetoStr(DateTimePicker1.Date)),'/','.', [rfReplaceAll, rfIgnoreCase])) + 'and ' + QuotedStr(StringReplace((DatetoStr(DateTimePicker2.Date)),'/','.', [rfReplaceAll, rfIgnoreCase]))
          else
              where := where + 'and DATAVENC_RECTIT between ' + QuotedStr(StringReplace((DatetoStr(DateTimePicker1.Date)),'/','.', [rfReplaceAll, rfIgnoreCase])) + 'and ' + QuotedStr(StringReplace((DatetoStr(DateTimePicker2.Date)),'/','.', [rfReplaceAll, rfIgnoreCase]));
          end;
     end;

     if RadioGroup1.ItemIndex = 0 then
        where := where + 'and VALORPAGO_RECTIT <> VALORTOTAL_RECTIT '
     else if RadioGroup1.ItemIndex = 1 then
         where := where + 'and VALORPAGO_RECTIT = VALORTOTAL_RECTIT ';
  inherited;

end;

procedure TfrmRECTIT.executarSQL;
begin



  inherited;

end;

procedure TfrmRECTIT.FormCreate(Sender: TObject);
begin
  inherited;
    cdsPadrao := DataModule1.cdsRECTIT;
    cdsConsulta := DataModule1.cdsCONSULTA;



    campos := ' SEQ_RECTIT, ORIGEM_RECTIT,DATAEMISSAO_RECTIT,DATAVENC_RECTIT,VALORTOTAL_RECTIT,' +
              ' VALORPAGO_RECTIT, NOME_CLI,CODIGO_CLI,(VALORTOTAL_RECTIT - VALORPAGO_RECTIT) AS VALORABERTO ';
    tabela := 'RECTIT';
    where := '';
    join := 'LEFT OUTER JOIN CLIENTE ON CODIGO_CLI = CODCLI_RECTIT ';
    campoConsulta := 'NOME_CLI';
end;

end.
