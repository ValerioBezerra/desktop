unit unCadFUN;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPadraoManutencao, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls,DB;

type
  TfrmCadFUN = class(TfrmPadraoManutencao_)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadFUN: TfrmCadFUN;

implementation

{$R *.dfm}

uses unDM;

procedure TfrmCadFUN.btnSalvarClick(Sender: TObject);
begin
  inherited;
   DataModule1.Transacao.Commit;
   cdsPadrao.Close;
   btnSalvar.Enabled := false;
end;

procedure TfrmCadFUN.FormCreate(Sender: TObject);
begin
  inherited;

  cdsPadrao := DataModule1.cdsFUNCIONARIO;
end;

procedure TfrmCadFUN.FormShow(Sender: TObject);
begin
  inherited;
   if (cdsPadrao.State = dsInsert) then
       DataModule1.iniciarClientDataSet(cdsPadrao);
end;

end.
