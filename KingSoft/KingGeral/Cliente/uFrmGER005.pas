unit uFrmGER005;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask, uKsNumberEdit,
  uKsDBNumberEdit;

type
  TfrmGER005 = class(TfrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    dbeGER_DESCRICAO_TLG: TDBEdit;
    dbneGER_ID_TLG: TKsDBNumberEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);


  
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGER005: TfrmGER005;

implementation

{$R *.dfm}

uses uCMKingGeral, uUtil;

procedure TfrmGER005.btnSalvarClick(Sender: TObject);
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
      dbeGER_DESCRICAO_TLG.SetFocus;
    end;
end;





procedure TfrmGER005.FormCreate(Sender: TObject);
begin
  inherited;
  cdsPadrao    := cmKingGeral.cdsGER_TLG;
  TabelaPadrao := 'GER_TLG';
end;


procedure TfrmGER005.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F2) then
    btnSalvarClick(Sender);
end;



end.
