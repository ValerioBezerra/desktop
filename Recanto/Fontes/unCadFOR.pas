unit unCadFOR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPadraoManutencao, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls,DB;

type
  TfrmCadFOR = class(TfrmPadraoManutencao_)
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
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    DBEdit8: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBEdit3Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadFOR: TfrmCadFOR;

implementation

{$R *.dfm}

uses unDM;

procedure TfrmCadFOR.btnSalvarClick(Sender: TObject);
begin
  inherited;
   DataModule1.Transacao.Commit;
   cdsPadrao.Close;
   btnSalvar.Enabled := false;
end;

procedure TfrmCadFOR.DBEdit3Enter(Sender: TObject);
begin
  inherited;
    if DBRadioGroup1.ItemIndex = 0 then
         dbedit3.Field.EditMask := '000.000.000-00;1;_'
    else if DBRadioGroup1.ItemIndex = 1 then
          dbedit3.Field.EditMask := '00.000.000/0000-00;1;_'
    else
      begin
        showmessage('Selecione Pessoa Jur�dica ou F�sica!');
        DBRadioGroup1.SetFocus;
      end;

end;

procedure TfrmCadFOR.FormCreate(Sender: TObject);
begin
  inherited;
  cdsPadrao := DataModule1.cdsFORNECEDOR;
end;

procedure TfrmCadFOR.FormShow(Sender: TObject);
begin
  inherited;
   if (cdsPadrao.State = dsInsert) then
       DataModule1.iniciarClientDataSet(cdsPadrao);
end;

end.
