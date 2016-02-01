unit uFrmGER013Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadraoConsulta, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, uKsDBGrid, Vcl.ExtCtrls,
  Data.DB, Datasnap.DBClient;

type
  TfrmGER013Consulta = class(TfrmPadraoConsulta)
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
  frmGER013Consulta: TfrmGER013Consulta;

implementation

{$R *.dfm}

uses uCMKingGeral, uCCKingGeral, uUtil, uFrmGER013;

procedure TfrmGER013Consulta.btnApagarClick(Sender: TObject);
begin
  OperacaoPadrao := 'D';
  if (TUtil.ExibirPergunta('Tem certeza que deseja excluir?')) then
    begin
      PreencherCdsPadrao(cdsConsulta.FieldByName('GER_ID_FPG').AsInteger);
      erroPadrao := not(cmKingGeral.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

      if not(erroPadrao) then
        begin
          inherited;
          cdsConsulta.Close;
          cdsConsulta.Open;
        end;
    end;
end;

procedure TfrmGER013Consulta.btnEditarClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(cdsConsulta.FieldByName('GER_ID_FPG').AsInteger);
    Application.CreateForm(TfrmGER013, frmGER013);
    frmGER013.OperacaoPadrao := 'U';
    frmGER013.ShowModal;
    frmGER013.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmGER013Consulta.btnNovoClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(0);
    Application.CreateForm(TfrmGER013, frmGER013);
    frmGER013.OperacaoPadrao := 'I';
    frmGER013.ShowModal;
    frmGER013.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmGER013Consulta.FormCreate(Sender: TObject);
begin
  inherited;
  Campos        := '*';
  Tabela        := 'GER_FPG';
  Join          := '';
  CampoConsulta := 'GER_DESCRICAO_FPG';
  OrderBy       := 'GER_DESCRICAO_FPG';

  cdsPadrao    := cmKingGeral.cdsGER_FPG;
  TabelaPadrao := 'GER_FPG';

  cdsVerificarAutorizacao := cmKingGeral.cdsConsulta;
  SiglaModulo             := 'GER';
  CodigoPrograma          := '013';
end;

procedure TfrmGER013Consulta.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmGER013Consulta.PreencherCdsPadrao(Id: Integer);
begin
  cdsPadrao.Close;
  cdsPadrao.CommandText := ' SELECT * FROM GER_FPG WHERE GER_ID_FPG = ' + IntToStr(Id);
  cdsPadrao.Open;

  if (cdsPadrao.IsEmpty) then
    cdsPadrao.Insert
  else
    cdsPadrao.Edit;
end;

end.
