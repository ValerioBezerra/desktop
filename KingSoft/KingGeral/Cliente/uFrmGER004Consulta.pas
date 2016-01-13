unit uFrmGER004Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadraoConsulta, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, uKsDBGrid, Vcl.ExtCtrls,
  Data.DB, Datasnap.DBClient;

type
  TfrmGER004Consulta = class(TfrmPadraoConsulta)
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
  frmGER004Consulta: TfrmGER004Consulta;

implementation

{$R *.dfm}

uses uCMKingGeral, uCCKingGeral, uUtil, uFrmGER004;

procedure TfrmGER004Consulta.btnApagarClick(Sender: TObject);
begin
  OperacaoPadrao := 'D';
  if (TUtil.ExibirPergunta('Tem certeza que deseja excluir?')) then
    begin
      PreencherCdsPadrao(cdsConsulta.FieldByName('GER_ID_BAI').AsInteger);
      erroPadrao := not(cmKingGeral.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

      if not(erroPadrao) then
        begin
          inherited;
          cdsConsulta.Close;
          cdsConsulta.Open;
        end;
    end;
end;

procedure TfrmGER004Consulta.btnEditarClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(cdsConsulta.FieldByName('GER_ID_BAI').AsInteger);
    Application.CreateForm(TfrmGER004, frmGER004);
    frmGER004.OperacaoPadrao := 'U';
    frmGER004.ShowModal;
    frmGER004.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmGER004Consulta.btnNovoClick(Sender: TObject);
begin
  inherited;
  try
    PreencherCdsPadrao(0);
    Application.CreateForm(TfrmGER004, frmGER004);
    frmGER004.OperacaoPadrao := 'I';
    frmGER004.ShowModal;
    frmGER004.Free;
  finally
    btnPesquisarClick(self);
  end;
end;

procedure TfrmGER004Consulta.FormCreate(Sender: TObject);
begin
  inherited;
  Campos        := '*';
  Tabela        := 'GER_BAI';
  Join          := ' LEFT OUTER JOIN GER_CID ON GER_ID_CID = GER_GERCID_BAI ' +
                   ' LEFT OUTER JOIN GER_EST ON GER_ID_EST = GER_GEREST_CID ';
  CampoConsulta := 'GER_NOME_BAI';
  OrderBy       := 'GER_NOME_BAI';

  cdsPadrao    := cmKingGeral.cdsGER_BAI;
  TabelaPadrao := 'GER_BAI';

  cdsVerificarAutorizacao := cmKingGeral.cdsConsulta;
  SiglaModulo             := 'GER';
  CodigoPrograma          := '004';
end;

procedure TfrmGER004Consulta.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmGER004Consulta.PreencherCdsPadrao(Id: Integer);
begin
  cdsPadrao.Close;
  cdsPadrao.CommandText := ' SELECT * FROM GER_BAI WHERE GER_ID_BAI = ' + IntToStr(Id);
  cdsPadrao.Open;

  if (cdsPadrao.IsEmpty) then
    cdsPadrao.Insert
  else
    cdsPadrao.Edit;
end;

end.
