unit uFrmAUT004;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPadrao, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask, uKsNumberEdit,
  uKsDBNumberEdit, DB;

type
  TfrmAUT004 = class(TfrmPadrao)
    Label1: TLabel;
    Label2: TLabel;
    dbeAUT_DESCRICAO_MOD: TDBEdit;
    dbneAUT_ID_MOD: TKsDBNumberEdit;
    dbeAUT_SIGLA_MOD: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    dbeAUT_EXECUTAVEL_MOD: TDBEdit;
    sbAUT_EXECUTAVEL_MOD: TSpeedButton;
    Label5: TLabel;
    dbneAUT_ORDEM_MOD: TKsDBNumberEdit;
    FileOpenDialog: TFileOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbAUT_EXECUTAVEL_MODClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeAUT_EXECUTAVEL_MODKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAUT004: TfrmAUT004;

implementation

{$R *.dfm}

uses uCMKingAutorizacao, uUtil;

procedure TfrmAUT004.btnSalvarClick(Sender: TObject);
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
      if (dbeAUT_SIGLA_MOD.Enabled) then
        dbeAUT_SIGLA_MOD.SetFocus
      else
        dbeAUT_DESCRICAO_MOD.SetFocus;
    end;
end;

procedure TfrmAUT004.dbeAUT_EXECUTAVEL_MODKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F1) then
    sbAUT_EXECUTAVEL_MODClick(Self);
end;

procedure TfrmAUT004.FormCreate(Sender: TObject);
begin
  inherited;
  cdsPadrao    := cmKingAutorizacao.cdsAUT_MOD;
  TabelaPadrao := 'AUT_MOD';
end;


procedure TfrmAUT004.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Ord(Key) = VK_F2) then
    btnSalvarClick(Sender);
end;

procedure TfrmAUT004.FormShow(Sender: TObject);
begin
  inherited;
  dbeAUT_SIGLA_MOD.Enabled := (cdsPadrao.State = dsInsert);
end;

procedure TfrmAUT004.sbAUT_EXECUTAVEL_MODClick(Sender: TObject);
begin
  inherited;
  if (FileOpenDialog.Execute) then
    cdsPadrao.FieldByName('AUT_EXECUTAVEL_MOD').AsString := ExtractFileName(FileOpenDialog.FileName);
end;

end.
