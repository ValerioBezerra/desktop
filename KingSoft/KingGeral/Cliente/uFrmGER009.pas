unit uFrmGER009;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask, uKsNumberEdit,
  uKsDBNumberEdit;

type
  TfrmGER009 = class(TfrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    dbeGER_DESCRICAO_TPP: TDBEdit;
    dbneGER_ID_TPP: TKsDBNumberEdit;
    dbrgGER_TIPO_TPP: TDBRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGER009: TfrmGER009;

implementation

{$R *.dfm}

uses uCMKingGeral, uUtil, uFrmGER003Consulta;

procedure TfrmGER009.btnSalvarClick(Sender: TObject);
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
      dbeGER_DESCRICAO_TPP.SetFocus;
    end;
end;



procedure TfrmGER009.FormCreate(Sender: TObject);
begin
  inherited;
  cdsPadrao    := cmKingGeral.cdsGER_EMP;
  TabelaPadrao := 'GER_EMP';
end;


procedure TfrmGER009.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F2) then
    btnSalvarClick(Sender);
end;


end.
