unit uFrmAUT005;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask, uKsNumberEdit,
  uKsDBNumberEdit, DB;

type
  TfrmAUT005 = class(TfrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    dbeAUT_DESCRICAO_PRO: TDBEdit;
    dbneAUT_ID_PRO: TKsDBNumberEdit;
    dbeAUT_SIGLA_MOD: TDBEdit;
    Label3: TLabel;
    edAUT_DESCRICAO_MOD: TEdit;
    Label4: TLabel;
    sbAUT004: TSpeedButton;
    dbneAUT_AUTMOD_PRO: TKsDBNumberEdit;
    dbcbAUT_MENUPRINCIPAL_PRO: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbneAUT_AUTMOD_PROExit(Sender: TObject);
    procedure sbAUT004Click(Sender: TObject);
    procedure dbneAUT_AUTMOD_PROKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAUT005: TfrmAUT005;

implementation

{$R *.dfm}

uses uCMKingAutorizacao, uUtil, uFrmAUT004Consulta;

procedure TfrmAUT005.btnSalvarClick(Sender: TObject);
begin
  cdsPadrao.Post;
  erroPadrao := not(cmKingAutorizacao.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

  if not(erroPadrao) then
    begin
      inherited;
      Close;
    end;

  if (erroPadrao) then
    begin
      cdsPadrao.Edit;
      if (dbneAUT_AUTMOD_PRO.Enabled) then
        dbneAUT_AUTMOD_PRO.SetFocus
      else
        dbeAUT_DESCRICAO_PRO.SetFocus;
    end;
end;

procedure TfrmAUT005.dbneAUT_AUTMOD_PROExit(Sender: TObject);
begin
  inherited;
  cmKingAutorizacao.cdsConsulta.Close;
  cmKingAutorizacao.cdsConsulta.CommandText := ' SELECT * FROM AUT_MOD WHERE AUT_ID_MOD = ' + IntToStr(cdsPadrao.FieldByName('AUT_AUTMOD_PRO').AsInteger);
  cmKingAutorizacao.cdsConsulta.Open;

  if (cmKingAutorizacao.cdsConsulta.IsEmpty) then
    edAUT_DESCRICAO_MOD.Text := 'Perfil não cadastrado'
  else
    edAUT_DESCRICAO_MOD.Text := cmKingAutorizacao.cdsConsulta.FieldByName('AUT_DESCRICAO_MOD').AsString;
end;

procedure TfrmAUT005.dbneAUT_AUTMOD_PROKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ((Ord(Key) = VK_F1) and (sbAUT004.Enabled)) then
    sbAUT004Click(Self);
end;

procedure TfrmAUT005.FormCreate(Sender: TObject);
begin
  inherited;
  cdsPadrao    := cmKingAutorizacao.cdsAUT_PRO;
  TabelaPadrao := 'AUT_PRO';
end;


procedure TfrmAUT005.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F2) then
    btnSalvarClick(Sender);
end;

procedure TfrmAUT005.FormShow(Sender: TObject);
begin
  inherited;
  if (cdsPadrao.State = dsInsert) then
    cdsPadrao.FieldByName('AUT_MENUPRINCIPAL_PRO').AsInteger := 1;

  dbneAUT_AUTMOD_PRO.Enabled := (cdsPadrao.State = dsInsert);
  sbAUT004.Enabled           := (cdsPadrao.State = dsInsert);
  dbeAUT_SIGLA_MOD.Enabled   := (cdsPadrao.State = dsInsert);
end;

procedure TfrmAUT005.sbAUT004Click(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TfrmAUT004Consulta, frmAUT004Consulta);
  frmAUT004Consulta.MostrarConfirmar := True;
  frmAUT004Consulta.ShowModal;

  if (frmAUT004Consulta.Confirmou) then
    begin
      dbneAUT_AUTMOD_PRO.SetFocus;
      cdsPadrao.FieldByName('AUT_AUTMOD_PRO').AsInteger := frmAUT004Consulta.cdsConsulta.FieldByName('AUT_ID_MOD').AsInteger;
      dbneAUT_AUTMOD_PROExit(Self);
    end;
end;

end.
