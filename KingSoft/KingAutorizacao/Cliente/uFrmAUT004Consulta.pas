unit uFrmAUT004Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadraoConsulta, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, uKsDBGrid, Vcl.ExtCtrls,
  Data.DB, Datasnap.DBClient;

type
  TfrmAUT004Consulta = class(TfrmPadraoConsulta)
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
  frmAUT004Consulta: TfrmAUT004Consulta;

implementation

{$R *.dfm}

uses uCMKingAutorizacao, uCCKingAutorizacao, uUtil, uFrmAUT004;

procedure TfrmAUT004Consulta.btnApagarClick(Sender: TObject);
begin
  OperacaoPadrao := 'D';
  if (TUtil.ExibirPergunta('Tem certeza que deseja excluir?')) then
    begin
      PreencherCdsPadrao(cdsConsulta.FieldByName('AUT_ID_MOD').AsInteger);
      erroPadrao := not(cmKingAutorizacao.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

      if not(erroPadrao) then
        begin
          inherited;
          cdsConsulta.Close;
          cdsConsulta.Open;
        end;
    end;
end;

procedure TfrmAUT004Consulta.btnEditarClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(cdsConsulta.FieldByName('AUT_ID_MOD').AsInteger);
    Application.CreateForm(TfrmAUT004, frmAUT004);
    frmAUT004.OperacaoPadrao := 'U';
    frmAUT004.ShowModal;
    frmAUT004.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmAUT004Consulta.btnNovoClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(0);
    Application.CreateForm(TfrmAUT004, frmAUT004);
    frmAUT004.OperacaoPadrao := 'I';
    frmAUT004.ShowModal;
    frmAUT004.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmAUT004Consulta.FormCreate(Sender: TObject);
begin
  inherited;
  Campos        := '*';
  Tabela        := 'AUT_MOD';
  CampoConsulta := 'AUT_DESCRICAO_MOD';
  OrderBy       := 'AUT_DESCRICAO_MOD';


  cdsPadrao    := cmKingAutorizacao.cdsAUT_MOD;
  TabelaPadrao := 'AUT_MOD';
end;

procedure TfrmAUT004Consulta.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmAUT004Consulta.PreencherCdsPadrao(Id: Integer);
begin
  cdsPadrao.Close;
  cdsPadrao.CommandText := ' SELECT * FROM AUT_MOD WHERE AUT_ID_MOD = ' + IntToStr(Id);
  cdsPadrao.Open;

  if (cdsPadrao.IsEmpty) then
    cdsPadrao.Insert
  else
    cdsPadrao.Edit;
end;

end.
