unit uFrmGER009;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask, uKsNumberEdit,
  uKsDBNumberEdit;

type
  TfrmGER009 = class(TfrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    dbeGER_NOME_BAI: TDBEdit;
    dbneGER_ID_BAI: TKsDBNumberEdit;
    Label3: TLabel;
    dbneGER_GERCID_BAI: TKsDBNumberEdit;
    sbGER003: TSpeedButton;
    edGER_NOME_CID: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbneGER_GERCID_BAIExit(Sender: TObject);
    procedure sbGER003Click(Sender: TObject);
    procedure dbneGER_GERCID_BAIKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGER009: TfrmGER009;

implementation

{$R *.dfm}

uses uCMKingGeral, uUtil, uFrmGER003Consulta;

procedure TfrmGER009.btnSalvarClick(Sender: TObject);
begin
  cdsPadrao.Post;
  erroPadrao := not(cmKingGeral.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

  if not(erroPadrao) then
    begin
      inherited;
      Close;
    end;

  if (erroPadrao) then
    begin
      cdsPadrao.Edit;
      dbeGER_NOME_BAI.SetFocus;
    end;
end;

procedure TfrmGER009.dbneGER_GERCID_BAIExit(Sender: TObject);
begin
  cmKingGeral.cdsConsulta.Close;
  cmKingGeral.cdsConsulta.CommandText := ' SELECT * FROM GER_CID WHERE GER_ID_CID = ' + IntToStr(cdsPadrao.FieldByName('GER_GERCID_BAI').AsInteger);
  cmKingGeral.cdsConsulta.Open;

  if (cmKingGeral.cdsConsulta.IsEmpty) then
    edGER_NOME_CID.Text := 'Estado n�o cadastrado'
  else
    edGER_NOME_CID.Text := cmKingGeral.cdsConsulta.FieldByName('GER_NOME_CID').AsString;
end;

procedure TfrmGER009.dbneGER_GERCID_BAIKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F1) then
    sbGER003Click(Self);
end;

procedure TfrmGER009.FormCreate(Sender: TObject);
begin
  inherited;
  cdsPadrao    := cmKingGeral.cdsGER_BAI;
  TabelaPadrao := 'GER_BAI';
end;


procedure TfrmGER009.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F2) then
    btnSalvarClick(Sender);
end;

procedure TfrmGER009.sbGER003Click(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TfrmGER003Consulta, frmGER003Consulta);
    frmGER003Consulta.MostrarConfirmar := True;
    frmGER003Consulta.ShowModal;

    if (frmGER003Consulta.Confirmou) then
      begin
        dbneGER_GERCID_BAI.SetFocus;
        cdsPadrao.FieldByName('GER_GERCID_BAI').AsInteger := frmGER003Consulta.cdsConsulta.FieldByName('GER_ID_CID').AsInteger;
        dbneGER_GERCID_BAIExit(Self);
      end;
  finally
    TUtil.CarregarModuloPrograma(cmKingGeral.cdsConsulta);
  end;
end;

end.