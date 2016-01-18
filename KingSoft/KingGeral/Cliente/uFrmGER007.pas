unit uFrmGER007;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask, uKsNumberEdit,
  uKsDBNumberEdit;

type
  TfrmGER007 = class(TfrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    dbeGER_FANTASIA_EMP: TDBEdit;
    dbneGER_ID_EMP: TKsDBNumberEdit;
    Label3: TLabel;
    dbneGER_GERTLG_LOG: TKsDBNumberEdit;
    sbGER005: TSpeedButton;
    edGER_DESCRICAO_TLG: TEdit;
    dbneGER_GERBAI_LOG: TKsDBNumberEdit;
    sbGER004: TSpeedButton;
    edGER_NOME_BAI: TEdit;
    Label4: TLabel;
    dbeGER_RAZAOSOCIAL_EMP: TDBEdit;
    Label5: TLabel;
    dbrgGER_TIPOPESSOA_EMP: TDBRadioGroup;
    dbeGER_CPFCNPJ_EMP: TDBEdit;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbneGER_GERTLG_LOGExit(Sender: TObject);
    procedure sbGER005Click(Sender: TObject);
    procedure dbneGER_GERTLG_LOGKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbneGER_GERBAI_LOGExit(Sender: TObject);
    procedure sbGER004Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGER007: TfrmGER007;

implementation

{$R *.dfm}

uses uCMKingGeral, uUtil, uFrmGER002Consulta, uFrmGER005Consulta,
  uFrmGER004Consulta;

procedure TfrmGER007.btnSalvarClick(Sender: TObject);
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
      dbeGER_NOME_CID.SetFocus;
    end;
end;

procedure TfrmGER007.dbneGER_GERBAI_LOGExit(Sender: TObject);
begin

    cmKingGeral.cdsConsulta.Close;
  cmKingGeral.cdsConsulta.CommandText := ' SELECT * FROM GER_BAI WHERE GER_ID_BAI = ' + IntToStr(cdsPadrao.FieldByName('GER_GERBAI_LOG').AsInteger);
  cmKingGeral.cdsConsulta.Open;

  if (cmKingGeral.cdsConsulta.IsEmpty) then
    edGER_NOME_BAI.Text := 'Bairro n�o cadastrado'
  else
    edGER_NOME_BAI.Text := cmKingGeral.cdsConsulta.FieldByName('GER_NOME_BAI').AsString;
end;

procedure TfrmGER007.dbneGER_GERTLG_LOGExit(Sender: TObject);
begin
  cmKingGeral.cdsConsulta.Close;
  cmKingGeral.cdsConsulta.CommandText := ' SELECT * FROM GER_TLG WHERE GER_ID_TLG = ' + IntToStr(cdsPadrao.FieldByName('GER_GERTLG_LOG').AsInteger);
  cmKingGeral.cdsConsulta.Open;

  if (cmKingGeral.cdsConsulta.IsEmpty) then
    edGER_DESCRICAO_TLG.Text := 'Tipo n�o cadastrado'
  else
    edGER_DESCRICAO_TLG.Text := cmKingGeral.cdsConsulta.FieldByName('GER_DESCRICAO_TLG').AsString;
end;

procedure TfrmGER007.dbneGER_GERTLG_LOGKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F1) then
    sbGER005Click(Self);
end;

procedure TfrmGER007.FormCreate(Sender: TObject);
begin
  inherited;
  cdsPadrao    := cmKingGeral.cdsGER_LOG;
  TabelaPadrao := 'GER_LOG';
end;


procedure TfrmGER007.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F2) then
    btnSalvarClick(Sender);
end;

procedure TfrmGER007.sbGER004Click(Sender: TObject);
begin
    inherited;
  try
    Application.CreateForm(TfrmGER004Consulta, frmGER004Consulta);
    frmGER004Consulta.MostrarConfirmar := True;
    frmGER004Consulta.ShowModal;

    if (frmGER004Consulta.Confirmou) then
      begin
        dbneGER_GERBAI_LOG.SetFocus;
        cdsPadrao.FieldByName('GER_GERBAI_LOG').AsInteger := frmGER004Consulta.cdsConsulta.FieldByName('GER_ID_BAI').AsInteger;
        dbneGER_GERBAI_LOGExit(Self);
      end;
  finally
    TUtil.CarregarModuloPrograma(cmKingGeral.cdsConsulta);
  end;

end;

procedure TfrmGER007.sbGER005Click(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TfrmGER005Consulta, frmGER005Consulta);
    frmGER005Consulta.MostrarConfirmar := True;
    frmGER005Consulta.ShowModal;

    if (frmGER005Consulta.Confirmou) then
      begin
        dbneGER_GERTLG_LOG.SetFocus;
        cdsPadrao.FieldByName('GER_GERTLG_LOG').AsInteger := frmGER005Consulta.cdsConsulta.FieldByName('GER_ID_TLG').AsInteger;
        dbneGER_GERTLG_LOGExit(Self);
      end;
  finally
    TUtil.CarregarModuloPrograma(cmKingGeral.cdsConsulta);
  end;
end;

end.
