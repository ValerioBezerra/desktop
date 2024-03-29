unit uFrmGER007Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadraoConsulta, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, uKsDBGrid, Vcl.ExtCtrls,
  Data.DB, Datasnap.DBClient;

type
  TfrmGER007Consulta = class(TfrmPadraoConsulta)
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
  frmGER007Consulta: TfrmGER007Consulta;

implementation

{$R *.dfm}

uses uCMKingGeral, uCCKingGeral, uUtil, uFrmGER007;

procedure TfrmGER007Consulta.btnApagarClick(Sender: TObject);
begin
  OperacaoPadrao := 'D';
  if (TUtil.ExibirPergunta('Tem certeza que deseja excluir?')) then
    begin
      PreencherCdsPadrao(cdsConsulta.FieldByName('GER_ID_EMP').AsInteger);
      erroPadrao := not(cmKingGeral.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

      if not(erroPadrao) then
        begin
          inherited;
          cdsConsulta.Close;
          cdsConsulta.Open;
        end;
    end;
end;

procedure TfrmGER007Consulta.btnEditarClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(cdsConsulta.FieldByName('GER_ID_EMP').AsInteger);
    Application.CreateForm(TfrmGER007, frmGER007);
    frmGER007.OperacaoPadrao := 'U';
    frmGER007.ShowModal;
    frmGER007.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmGER007Consulta.btnNovoClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(0);
    Application.CreateForm(TfrmGER007, frmGER007);
    frmGER007.OperacaoPadrao := 'I';
    frmGER007.ShowModal;
    frmGER007.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmGER007Consulta.FormCreate(Sender: TObject);
begin
  inherited;
  Campos        := '*';
  Tabela        := 'GER_EMP';
  Join          := '';
  CampoConsulta := 'GER_RAZAOSOCIAL_EMP';
  OrderBy       := 'GER_RAZAOSOCIAL_EMP';

  cdsPadrao    := cmKingGeral.cdsGER_EMP;
  TabelaPadrao := 'GER_EMP';

  cdsVerificarAutorizacao := cmKingGeral.cdsConsulta;
  SiglaModulo             := 'GER';
  CodigoPrograma          := '007';
end;

procedure TfrmGER007Consulta.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmGER007Consulta.PreencherCdsPadrao(Id: Integer);
begin
  cdsPadrao.Close;
  cdsPadrao.CommandText := ' SELECT * FROM GER_EMP WHERE GER_ID_EMP = ' + IntToStr(Id);
  cdsPadrao.Open;

  if (cdsPadrao.IsEmpty) then
    cdsPadrao.Insert
  else
    cdsPadrao.Edit;
end;

end.
