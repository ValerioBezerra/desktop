unit uFrmPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, Vcl.DBGrids;

type
  TfrmPadrao = class(TForm)
    Panel1: TPanel;
    pnlBotoes: TPanel;
    btnFechar: TBitBtn;
    Panel2: TPanel;
    pnlPrincipal: TPanel;
    stbInformacao: TStatusBar;
    Timer: TTimer;
    btnSalvar: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  protected
    ErroPadrao: Boolean;
    cdsPadrao: TClientDataSet;
    TabelaPadrao: String;
  private
    { Private declarations }
  public
    { Public declarations }
    OperacaoPadrao: String;
  end;

var
  frmPadrao: TfrmPadrao;

implementation

{$R *.dfm}

uses uUtil;

procedure TfrmPadrao.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPadrao.btnSalvarClick(Sender: TObject);
begin
  ErroPadrao := (cdsPadrao.ApplyUpdates(0) > 0);
end;

procedure TfrmPadrao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = VK_ESCAPE) then
    btnFecharClick(Self);

  if (Ord(Key) = VK_RETURN) then
    begin
      if not(ActiveControl is TCustomDBGrid) then
        begin
          Key := #0;
          Perform(WM_NEXTDLGCTL, 0, 0);
        end;
    end;
end;

procedure TfrmPadrao.FormShow(Sender: TObject);
begin
  Caption                      := 'KingErp - ' + TUtil.Programa.Modulo.Descricao + ' - ' + TUtil.Programa.Descricao;
  stbInformacao.Panels[0].Text := TUtil.Programa.Modulo.Sigla + TUtil.Programa.Codigo;

  if (cdsPadrao.State = dsInsert) then
    TUtil.IniciarClientDataSet(cdsPadrao);

  if (OperacaoPadrao = 'V') then
    begin
      TUtil.HabilitarDesabilitarElementos(Self, 'D');
      btnSalvar.Enabled := False;
    end;
end;

procedure TfrmPadrao.TimerTimer(Sender: TObject);
begin
  stbInformacao.Panels[1].Text := TUtil.MoverHint(Self);
end;

end.
