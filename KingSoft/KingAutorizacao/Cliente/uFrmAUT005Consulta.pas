unit uFrmAUT005Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadraoConsulta, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, uKsDBGrid, Vcl.ExtCtrls,
  Data.DB, Datasnap.DBClient, Vcl.Mask, uKsNumberEdit;

type
  TfrmAUT005Consulta = class(TfrmPadraoConsulta)
    neAUT_AUTMOD_PRO: TKsNumberEdit;
    edAUT_DESCRICAO_MOD: TEdit;
    Label1: TLabel;
    sbAUT004: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPesquisarClick(Sender: TObject);
    procedure sbAUT004Click(Sender: TObject);
    procedure neAUT_AUTMOD_PROExit(Sender: TObject);
    procedure neAUT_AUTMOD_PROKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure PreencherCdsPadrao(Id: Integer);
  public
    { Public declarations }
  end;

var
  frmAUT005Consulta: TfrmAUT005Consulta;

implementation

{$R *.dfm}

uses uCMKingAutorizacao, uCCKingAutorizacao, uUtil, uFrmAUT005,
  uFrmAUT004Consulta;

procedure TfrmAUT005Consulta.btnApagarClick(Sender: TObject);
begin
  OperacaoPadrao := 'D';
  if (TUtil.ExibirPergunta('Tem certeza que deseja excluir?')) then
    begin
      PreencherCdsPadrao(cdsConsulta.FieldByName('AUT_ID_PRO').AsInteger);
      erroPadrao := not(cmKingAutorizacao.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

      if not(erroPadrao) then
        begin
          inherited;
          cdsConsulta.Close;
          cdsConsulta.Open;
        end;
    end;
end;

procedure TfrmAUT005Consulta.btnEditarClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(cdsConsulta.FieldByName('AUT_ID_PRO').AsInteger);
    Application.CreateForm(TfrmAUT005, frmAUT005);
    frmAUT005.OperacaoPadrao := 'U';
    frmAUT005.ShowModal;
    frmAUT005.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmAUT005Consulta.btnNovoClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(0);
    Application.CreateForm(TfrmAUT005, frmAUT005);
    frmAUT005.OperacaoPadrao := 'I';
    frmAUT005.ShowModal;
    frmAUT005.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmAUT005Consulta.btnPesquisarClick(Sender: TObject);
begin
  Where := '';

  if (neAUT_AUTMOD_PRO.Value <> 0) then
    Where := Where + ' AND AUT_AUTMOD_PRO = ' + VarToStr(neAUT_AUTMOD_PRO.Value);

  inherited;
end;

procedure TfrmAUT005Consulta.FormCreate(Sender: TObject);
begin
  inherited;
  Campos        := '*';
  Tabela        := 'AUT_PRO';
  CampoConsulta := 'AUT_DESCRICAO_PRO';
  Join          := 'LEFT OUTER JOIN AUT_MOD ON AUT_ID_MOD = AUT_AUTMOD_PRO';
  OrderBy       := 'AUT_ORDEM_MOD, AUT_CODIGO_PRO';

  cdsPadrao    := cmKingAutorizacao.cdsAUT_PRO;
  TabelaPadrao := 'AUT_PRO';

  cdsVerificarAutorizacao := cmKingAutorizacao.cdsConsulta;
  SiglaModulo             := 'AUT';
  CodigoPrograma          := '005';
end;

procedure TfrmAUT005Consulta.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmAUT005Consulta.neAUT_AUTMOD_PROExit(Sender: TObject);
begin
  inherited;
  edAUT_DESCRICAO_MOD.Clear;
  if (neAUT_AUTMOD_PRO.Value <> 0) then
    begin
      cmKingAutorizacao.cdsConsulta.Close;
      cmKingAutorizacao.cdsConsulta.CommandText := ' SELECT * FROM AUT_MOD WHERE AUT_ID_MOD = ' + VarToStr(neAUT_AUTMOD_PRO.Value);
      cmKingAutorizacao.cdsConsulta.Open;

      if (cmKingAutorizacao.cdsConsulta.IsEmpty) then
        edAUT_DESCRICAO_MOD.Text := 'M�dulo n�o cadastrado'
      else
        edAUT_DESCRICAO_MOD.Text := cmKingAutorizacao.cdsConsulta.FieldByName('AUT_DESCRICAO_MOD').AsString;
    end;
end;

procedure TfrmAUT005Consulta.neAUT_AUTMOD_PROKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F1) then
    sbAUT004Click(Self);
end;

procedure TfrmAUT005Consulta.PreencherCdsPadrao(Id: Integer);
begin
  cdsPadrao.Close;
  cdsPadrao.CommandText := ' SELECT * FROM AUT_PRO WHERE AUT_ID_PRO = ' + IntToStr(Id);
  cdsPadrao.Open;

  if (cdsPadrao.IsEmpty) then
    cdsPadrao.Insert
  else
    cdsPadrao.Edit;
end;

procedure TfrmAUT005Consulta.sbAUT004Click(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TfrmAUT004Consulta, frmAUT004Consulta);
    frmAUT004Consulta.MostrarConfirmar := True;
    frmAUT004Consulta.ShowModal;

    if (frmAUT004Consulta.Confirmou) then
      begin
        neAUT_AUTMOD_PRO.SetFocus;
        neAUT_AUTMOD_PRO.Text := frmAUT004Consulta.cdsConsulta.FieldByName('AUT_ID_MOD').AsString;
        neAUT_AUTMOD_PROExit(Self);
      end;
  finally
    TUtil.CarregarModuloPrograma(cmKingAutorizacao.cdsConsulta);
  end;
end;

end.
