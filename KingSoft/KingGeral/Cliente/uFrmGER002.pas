unit uFrmGER002;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask, uKsNumberEdit,
  uKsDBNumberEdit;

type
  TfrmGER002 = class(TfrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    dbeGER_NOME_EST: TDBEdit;
    dbneGER_ID_EST: TKsDBNumberEdit;
    Label3: TLabel;
    dbneGER_GERPAI_EST: TKsDBNumberEdit;
    sbGER001: TSpeedButton;
    edGER_NOME_PAI: TEdit;
    dbeGER_UF_EST: TDBEdit;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbneGER_GERPAI_ESTExit(Sender: TObject);
    procedure sbGER001Click(Sender: TObject);
    procedure dbneGER_GERPAI_ESTKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGER002: TfrmGER002;

implementation

{$R *.dfm}

uses uCMKingGeral, uUtil, uFrmGER001Consulta;

procedure TfrmGER002.btnSalvarClick(Sender: TObject);
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
      dbeGER_NOME_EST.SetFocus;
    end;
end;

procedure TfrmGER002.dbneGER_GERPAI_ESTExit(Sender: TObject);
begin
  cmKingGeral.cdsConsulta.Close;
  cmKingGeral.cdsConsulta.CommandText := ' SELECT * FROM GER_PAI WHERE GER_ID_PAI = ' + IntToStr(cdsPadrao.FieldByName('GER_GERPAI_EST').AsInteger);
  cmKingGeral.cdsConsulta.Open;

  if (cmKingGeral.cdsConsulta.IsEmpty) then
    edGER_NOME_PAI.Text := 'Pa�s n�o cadastrado'
  else
    edGER_NOME_PAI.Text := cmKingGeral.cdsConsulta.FieldByName('GER_NOME_PAI').AsString;
end;

procedure TfrmGER002.dbneGER_GERPAI_ESTKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F1) then
    sbGER001Click(Self);
end;

procedure TfrmGER002.FormCreate(Sender: TObject);
begin
  inherited;
  cdsPadrao    := cmKingGeral.cdsGER_EST;
  TabelaPadrao := 'GER_EST';
end;


procedure TfrmGER002.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F2) then
    btnSalvarClick(Sender);
end;

procedure TfrmGER002.sbGER001Click(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TfrmGER001Consulta, frmGER001Consulta);
    frmGER001Consulta.MostrarConfirmar := True;
    frmGER001Consulta.ShowModal;

    if (frmGER001Consulta.Confirmou) then
      begin
        dbneGER_GERPAI_EST.SetFocus;
        cdsPadrao.FieldByName('GER_GERPAI_EST').AsInteger := frmGER001Consulta.cdsConsulta.FieldByName('GER_ID_PAI').AsInteger;
        dbneGER_GERPAI_ESTExit(Self);
      end;
  finally
    TUtil.CarregarModuloPrograma(cmKingGeral.cdsConsulta);
  end;
end;

end.