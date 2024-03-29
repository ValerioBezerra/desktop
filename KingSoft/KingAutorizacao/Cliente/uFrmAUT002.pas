unit uFrmAUT002;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask, uKsNumberEdit,
  uKsDBNumberEdit;

type
  TfrmAUT002 = class(TfrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    dbeAUT_DESCRICAO_PER: TDBEdit;
    dbneAUT_ID_PER: TKsDBNumberEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAUT002: TfrmAUT002;

implementation

{$R *.dfm}

uses uCMKingAutorizacao, uUtil;

procedure TfrmAUT002.btnSalvarClick(Sender: TObject);
begin
  cdsPadrao.Post;
  erroPadrao := not(cmKingAutorizacao.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

  if not(erroPadrao) then
    begin
      inherited;
      Close;
    end;

  if (erroPadrao) then
    begin
      cdsPadrao.Edit;
      dbeAUT_DESCRICAO_PER.SetFocus;
    end;
end;

procedure TfrmAUT002.FormCreate(Sender: TObject);
begin
  inherited;
  cdsPadrao    := cmKingAutorizacao.cdsAUT_PER;
  TabelaPadrao := 'AUT_PER';
end;


procedure TfrmAUT002.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F2) then
    btnSalvarClick(Sender);
end;

end.
