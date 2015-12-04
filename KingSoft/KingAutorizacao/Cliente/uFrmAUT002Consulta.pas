unit uFrmAUT002Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadraoConsulta, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, unKsDBGrid, Vcl.ExtCtrls,
  Data.DB, Datasnap.DBClient;

type
  TfrmAUT002Consulta = class(TfrmPadraoConsulta)
    procedure FormCreate(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
  private
    { Private declarations }
    procedure PreencherCdsPadrao;
  public
    { Public declarations }
  end;

var
  frmAUT002Consulta: TfrmAUT002Consulta;

implementation

{$R *.dfm}

uses uCMKingAutorizacao, uCCKingAutorizacao, uUtil;

procedure TfrmAUT002Consulta.btnApagarClick(Sender: TObject);
begin
  OperacaoPadrao := 'D';
  if (TUtil.ExibirPergunta('Tem certeza que deseja excluir?')) then
    begin
      PreencherCdsPadrao;
      erroPadrao := not(cmKingAutorizacao.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

      if not(erroPadrao) then
        begin
          inherited;
          cdsConsulta.Close;
          cdsConsulta.Open;
        end;
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
end;

procedure TfrmAUT002Consulta.PreencherCdsPadrao;
begin
  cdsPadrao.Close;
  cdsPadrao.CommandText := ' SELECT * FROM AUT_PER WHERE AUT_ID_PER = ' + IntToStr(cdsConsulta.FieldByName('AUT_ID_PER').AsInteger);
  cdsPadrao.Open;

  if not(cdsPadrao.IsEmpty) then
    cdsPadrao.Edit;
end;

end.
