unit uFrmGER013;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask, uKsNumberEdit,
  uKsDBNumberEdit;

type
  TfrmGER013 = class(TfrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    dbeGER_DESCRICAO_FPG: TDBEdit;
    dbneGER_ID_FPG: TKsDBNumberEdit;
    dbcbGER_GERATITULO_FPG: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGER013: TfrmGER013;

implementation

{$R *.dfm}

uses uCMKingGeral, uUtil;

procedure TfrmGER013.btnSalvarClick(Sender: TObject);
begin
  cdsPadrao.Post;
  erroPadrao := not(cmKingGeral.TestarDados(TUtil.Empresa.Id, TabelaPadrao, OperacaoPadrao, cdsPadrao.Data));

  if not(erroPadrao) then
    begin
      inherited;
      Close;
    end;

  if (erroPadrao) then
    begin
      cdsPadrao.Edit;
      dbeGER_DESCRICAO_FPG.SetFocus;
    end;
end;



procedure TfrmGER013.FormCreate(Sender: TObject);
begin
  inherited;
  cdsPadrao    := cmKingGeral.cdsGER_FPG;
  TabelaPadrao := 'GER_FPG';
end;


procedure TfrmGER013.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F2) then
    btnSalvarClick(Sender);
end;


end.
