unit uFrmAUT003Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadraoConsulta, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, uKsDBGrid, Vcl.ExtCtrls,
  Data.DB, Datasnap.DBClient, Vcl.Mask, uKsNumberEdit;

type
  TfrmAUT003Consulta = class(TfrmPadraoConsulta)
    neAUT_AUTPER_USU: TKsNumberEdit;
    edAUT_DESCRICAO_PER: TEdit;
    Label1: TLabel;
    sbAUT002: TSpeedButton;
    cdsConsultaATIVO: TBooleanField;
    cdsConsultaAUT_ID_USU: TIntegerField;
    cdsConsultaAUT_NOME_USU: TStringField;
    cdsConsultaAUT_AUTPER_USU: TIntegerField;
    cdsConsultaAUT_SENHA_USU: TStringField;
    cdsConsultaAUT_KING_USU: TSmallintField;
    cdsConsultaAUT_ATIVO_USU: TSmallintField;
    cdsConsultaAUT_LOGIN_USU: TStringField;
    cdsConsultaAUT_ID_PER: TIntegerField;
    cdsConsultaAUT_DESCRICAO_PER: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPesquisarClick(Sender: TObject);
    procedure sbAUT002Click(Sender: TObject);
    procedure neAUT_AUTPER_USUExit(Sender: TObject);
    procedure neAUT_AUTPER_USUKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsConsultaCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure PreencherCdsPadrao(Id: Integer);
  public
    { Public declarations }
  end;

var
  frmAUT003Consulta: TfrmAUT003Consulta;

implementation

{$R *.dfm}

uses uCMKingAutorizacao, uCCKingAutorizacao, uUtil, uFrmAUT003,
  uFrmAUT002Consulta;

procedure TfrmAUT003Consulta.btnApagarClick(Sender: TObject);
begin
  OperacaoPadrao := 'D';
  if (TUtil.ExibirPergunta('Tem certeza que deseja excluir?')) then
    begin
      PreencherCdsPadrao(cdsConsulta.FieldByName('AUT_ID_USU').AsInteger);
      erroPadrao := not(cmKingAutorizacao.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

      if not(erroPadrao) then
        begin
          inherited;
          cdsConsulta.Close;
          cdsConsulta.Open;
        end;
    end;
end;

procedure TfrmAUT003Consulta.btnEditarClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(cdsConsulta.FieldByName('AUT_ID_USU').AsInteger);
    Application.CreateForm(TfrmAUT003, frmAUT003);
    frmAUT003.OperacaoPadrao := 'U';
    frmAUT003.ShowModal;
    frmAUT003.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmAUT003Consulta.btnNovoClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(0);
    Application.CreateForm(TfrmAUT003, frmAUT003);
    frmAUT003.OperacaoPadrao := 'I';
    frmAUT003.ShowModal;
    frmAUT003.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmAUT003Consulta.btnPesquisarClick(Sender: TObject);
begin
  Where := ' AND AUT_KING_USU = 0 ';

  if (neAUT_AUTPER_USU.Value <> 0) then
    Where := Where + ' AND AUT_AUTPER_USU = ' + VarToStr(neAUT_AUTPER_USU.Value);

  inherited;
end;

procedure TfrmAUT003Consulta.cdsConsultaCalcFields(DataSet: TDataSet);
begin
  inherited;
  cdsConsulta.FieldByName('ATIVO').AsBoolean := (cdsConsulta.FieldByName('AUT_ATIVO_USU').AsInteger = 1);
end;

procedure TfrmAUT003Consulta.FormCreate(Sender: TObject);
begin
  inherited;
  Campos        := '*';
  Tabela        := 'AUT_USU';
  CampoConsulta := 'AUT_NOME_USU';
  Join          := 'LEFT OUTER JOIN AUT_PER ON AUT_ID_PER = AUT_AUTPER_USU';
  Where         := 'AND AUT_KING_USU = 0 ';
  OrderBy       := 'AUT_NOME_USU';

  cdsPadrao    := cmKingAutorizacao.cdsAUT_USU;
  TabelaPadrao := 'AUT_USU';
end;

procedure TfrmAUT003Consulta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ((Ord(Key) = VK_F2) and (btnNovo.Enabled)) then
    btnNovoClick(Sender);
  if ((Ord(Key) = VK_F3) and (btnEditar.Enabled)) then
    btnEditarClick(Sender);
  if ((Ord(Key) = VK_F4) and (btnApagar.Enabled)) then
    btnApagarClick(Sender);
  if (Ord(Key) = VK_F5) then
    btnPesquisarClick(Sender);
  if ((Ord(Key) = VK_F6) and (btnConfirmar.Visible) and (btnConfirmar.Enabled)) then
    btnConfirmarClick(Sender);
end;

procedure TfrmAUT003Consulta.neAUT_AUTPER_USUExit(Sender: TObject);
begin
  inherited;
  edAUT_DESCRICAO_PER.Clear;
  if (neAUT_AUTPER_USU.Value <> 0) then
    begin
      cmKingAutorizacao.cdsConsulta.Close;
      cmKingAutorizacao.cdsConsulta.CommandText := ' SELECT * FROM AUT_PER WHERE AUT_ID_PER = ' + VarToStr(neAUT_AUTPER_USU.Value);
      cmKingAutorizacao.cdsConsulta.Open;

      if (cmKingAutorizacao.cdsConsulta.IsEmpty) then
        edAUT_DESCRICAO_PER.Text := 'Perfil não cadastrado'
      else
        edAUT_DESCRICAO_PER.Text := cmKingAutorizacao.cdsConsulta.FieldByName('AUT_DESCRICAO_PER').AsString;
    end;
end;

procedure TfrmAUT003Consulta.neAUT_AUTPER_USUKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F1) then
    sbAUT002Click(Self);
end;

procedure TfrmAUT003Consulta.PreencherCdsPadrao(Id: Integer);
begin
  cdsPadrao.Close;
  cdsPadrao.CommandText := ' SELECT * FROM AUT_USU WHERE AUT_ID_USU = ' + IntToStr(Id);
  cdsPadrao.Open;

  if (cdsPadrao.IsEmpty) then
    cdsPadrao.Insert
  else
    cdsPadrao.Edit;
end;

procedure TfrmAUT003Consulta.sbAUT002Click(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TfrmAUT002Consulta, frmAUT002Consulta);
  frmAUT002Consulta.MostrarConfirmar := True;
  frmAUT002Consulta.ShowModal;

  if (frmAUT002Consulta.Confirmou) then
    begin
      neAUT_AUTPER_USU.SetFocus;
      neAUT_AUTPER_USU.Text := frmAUT002Consulta.cdsConsulta.FieldByName('AUT_ID_PER').AsString;
      neAUT_AUTPER_USUExit(Self);
    end;
end;

end.
