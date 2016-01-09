unit uFrmGER001Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadraoConsulta, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, uKsDBGrid, Vcl.ExtCtrls,
  Data.DB, Datasnap.DBClient;

type
  TfrmGER001Consulta = class(TfrmPadraoConsulta)
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
  frmGER001Consulta: TfrmGER001Consulta;

implementation

{$R *.dfm}

uses uCMKingGeral, uCCKingGeral, uUtil, uFrmGER001;

procedure TfrmGER001Consulta.btnApagarClick(Sender: TObject);
begin
  OperacaoPadrao := 'D';
  if (TUtil.ExibirPergunta('Tem certeza que deseja excluir?')) then
    begin
      PreencherCdsPadrao(cdsConsulta.FieldByName('GER_ID_PAI').AsInteger);
      erroPadrao := not(cmKingGeral.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

      if not(erroPadrao) then
        begin
          inherited;
          cdsConsulta.Close;
          cdsConsulta.Open;
        end;
    end;
end;

procedure TfrmGER001Consulta.btnEditarClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(cdsConsulta.FieldByName('GER_ID_PAI').AsInteger);
    Application.CreateForm(TfrmGER001, frmGER001);
    frmGER001.OperacaoPadrao := 'U';
    frmGER001.ShowModal;
    frmGER001.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmGER001Consulta.btnNovoClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(0);
    Application.CreateForm(TfrmGER001, frmGER001);
    frmGER001.OperacaoPadrao := 'I';
    frmGER001.ShowModal;
    frmGER001.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmGER001Consulta.FormCreate(Sender: TObject);
begin
  inherited;
  Campos        := '*';
  Tabela        := 'GER_PAI';
  CampoConsulta := 'GER_NOME_PAI';
  OrderBy       := 'GER_NOME_PAI';

  cdsPadrao    := cmKingGeral.cdsGER_PAI;
  TabelaPadrao := 'GER_PAI';

  cdsVerificarAutorizacao := cmKingGeral.cdsConsulta;
  SiglaModulo             := 'GER';
  CodigoPrograma          := '001';
end;

procedure TfrmGER001Consulta.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmGER001Consulta.PreencherCdsPadrao(Id: Integer);
begin
  cdsPadrao.Close;
  cdsPadrao.CommandText := ' SELECT * FROM GER_PAI WHERE GER_ID_PAI = ' + IntToStr(Id);
  cdsPadrao.Open;

  if (cdsPadrao.IsEmpty) then
    cdsPadrao.Insert
  else
    cdsPadrao.Edit;
end;

end.
