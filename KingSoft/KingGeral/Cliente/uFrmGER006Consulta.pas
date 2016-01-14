unit uFrmGER006Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadraoConsulta, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, uKsDBGrid, Vcl.ExtCtrls,
  Data.DB, Datasnap.DBClient;

type
  TfrmGER006Consulta = class(TfrmPadraoConsulta)
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
  frmGER006Consulta: TfrmGER006Consulta;

implementation

{$R *.dfm}

uses uCMKingGeral, uCCKingGeral, uUtil, uFrmGER006;

procedure TfrmGER006Consulta.btnApagarClick(Sender: TObject);
begin
  OperacaoPadrao := 'D';
  if (TUtil.ExibirPergunta('Tem certeza que deseja excluir?')) then
    begin
      PreencherCdsPadrao(cdsConsulta.FieldByName('GER_ID_LOG').AsInteger);
      erroPadrao := not(cmKingGeral.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

      if not(erroPadrao) then
        begin
          inherited;
          cdsConsulta.Close;
          cdsConsulta.Open;
        end;
    end;
end;

procedure TfrmGER006Consulta.btnEditarClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(cdsConsulta.FieldByName('GER_ID_LOG').AsInteger);
    Application.CreateForm(TfrmGER006, frmGER006);
    frmGER006.OperacaoPadrao := 'U';
    frmGER006.ShowModal;
    frmGER006.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmGER006Consulta.btnNovoClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(0);
    Application.CreateForm(TfrmGER006, frmGER006);
    frmGER006.OperacaoPadrao := 'I';
    frmGER006.ShowModal;
    frmGER006.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmGER006Consulta.FormCreate(Sender: TObject);
begin
  inherited;
  Campos        := '*';
  Tabela        := 'GER_LOG';
  Join          := 'left outer join ger_tlg on ger_log.ger_gertlg_log = ger_tlg.ger_id_tlg ' +
                   ' left outer join ger_bai on ger_log.ger_gerbai_log = ger_bai.ger_id_bai';
  CampoConsulta := 'GER_LOGRADOURO_LOG';
  OrderBy       := 'GER_LOGRADOURO_LOG';

  cdsPadrao    := cmKingGeral.cdsGER_CID;
  TabelaPadrao := 'GER_LOG';

  cdsVerificarAutorizacao := cmKingGeral.cdsConsulta;
  SiglaModulo             := 'GER';
  CodigoPrograma          := '006';
end;

procedure TfrmGER006Consulta.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmGER006Consulta.PreencherCdsPadrao(Id: Integer);
begin
  cdsPadrao.Close;
  cdsPadrao.CommandText := ' SELECT * FROM GER_LOG WHERE GER_ID_LOG = ' + IntToStr(Id);
  cdsPadrao.Open;

  if (cdsPadrao.IsEmpty) then
    cdsPadrao.Insert
  else
    cdsPadrao.Edit;
end;

end.