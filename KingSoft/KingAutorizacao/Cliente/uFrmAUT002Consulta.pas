unit uFrmAUT002Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadraoConsulta, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, uKsDBGrid, Vcl.ExtCtrls,
  Data.DB, Datasnap.DBClient;

type
  TfrmAUT002Consulta = class(TfrmPadraoConsulta)
    procedure FormCreate(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure PreencherCdsPadrao(Id: Integer);
  public
    { Public declarations }
  end;

var
  frmAUT002Consulta: TfrmAUT002Consulta;

implementation

{$R *.dfm}

uses uCMKingAutorizacao, uCCKingAutorizacao, uUtil, uFrmAUT002;

procedure TfrmAUT002Consulta.btnApagarClick(Sender: TObject);
begin
  OperacaoPadrao := 'D';
  if (TUtil.ExibirPergunta('Tem certeza que deseja excluir?')) then
    begin
      PreencherCdsPadrao(cdsConsulta.FieldByName('AUT_ID_PER').AsInteger);
      erroPadrao := not(cmKingAutorizacao.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

      if not(erroPadrao) then
        begin
          inherited;
          cdsConsulta.Close;
          cdsConsulta.Open;
        end;
    end;
end;

procedure TfrmAUT002Consulta.btnEditarClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(cdsConsulta.FieldByName('AUT_ID_PER').AsInteger);
    Application.CreateForm(TfrmAUT002, frmAUT002);
    frmAUT002.OperacaoPadrao := 'U';
    frmAUT002.ShowModal;
    frmAUT002.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmAUT002Consulta.btnNovoClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(0);
    Application.CreateForm(TfrmAUT002, frmAUT002);
    frmAUT002.OperacaoPadrao := 'I';
    frmAUT002.ShowModal;
    frmAUT002.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmAUT002Consulta.FormCreate(Sender: TObject);
begin
  inherited;
  Campos        := '*';
  Tabela        := 'AUT_PER';
  CampoConsulta := 'AUT_DESCRICAO_PER';
  OrderBy       := 'AUT_DESCRICAO_PER';

  cdsPadrao    := cmKingAutorizacao.cdsAUT_PER;
  TabelaPadrao := 'AUT_PER';

  cdsVerificarAutorizacao := cmKingAutorizacao.cdsConsulta;
  SiglaModulo             := 'AUT';
  CodigoPrograma          := '002';
end;

procedure TfrmAUT002Consulta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ((Ord(Key) = VK_F2) and (btnNovo.Enabled)) then
    btnNovoClick(Sender);
  if ((Ord(Key) = VK_F3) and (btnEditar.Enabled)) then
    btnEditarClick(Sender);
  if ((Ord(Key) = VK_F4) and (btnApagar.Enabled)) then
    btnApagarClick(Sender);
  if (Ord(Key) = VK_F6) then
    btnPesquisarClick(Sender);
  if ((Ord(Key) = VK_F7) and (btnConfirmar.Visible) and (btnConfirmar.Enabled)) then
    btnConfirmarClick(Sender);
end;

procedure TfrmAUT002Consulta.PreencherCdsPadrao(Id: Integer);
begin
  cdsPadrao.Close;
  cdsPadrao.CommandText := ' SELECT * FROM AUT_PER WHERE AUT_ID_PER = ' + IntToStr(Id);
  cdsPadrao.Open;

  if (cdsPadrao.IsEmpty) then
    cdsPadrao.Insert
  else
    cdsPadrao.Edit;
end;

end.
