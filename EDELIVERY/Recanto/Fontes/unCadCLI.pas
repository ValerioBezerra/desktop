unit unCadCli;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPadraoManutencao, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls,DB;

type
  TfrmCadCLI = class(TfrmPadraoManutencao_)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBEdit3Enter(Sender: TObject);
    procedure DBEdit4Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCLI: TfrmCadCLI;

implementation

{$R *.dfm}

uses unDM;

procedure TfrmCadCLI.btnSalvarClick(Sender: TObject);
begin
  inherited;
   DataModule1.Transacao.Commit;
   cdsPadrao.Close;
   btnSalvar.Enabled := false;
end;

procedure TfrmCadCLI.DBEdit3Enter(Sender: TObject);
begin
  inherited;
  dbedit3.Field.EditMask := '(00)0000.0000;1;_';
end;

procedure TfrmCadCLI.DBEdit4Enter(Sender: TObject);
begin
  inherited;
   dbedit4.Field.EditMask := '(00)00000.0000;1;_';
end;

procedure TfrmCadCLI.FormCreate(Sender: TObject);
begin
  inherited;

  cdsPadrao := DataModule1.cdsCLIENTE;
end;

procedure TfrmCadCLI.FormShow(Sender: TObject);
begin
  inherited;
   if (cdsPadrao.State = dsInsert) then
       DataModule1.iniciarClientDataSet(cdsPadrao);
end;

end.
