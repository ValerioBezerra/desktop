unit unMOVESTMOV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frmPadraoManutencao, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls,DB,
  Vcl.Imaging.pngimage;

type
  TfrmMOVESTMOV = class(TfrmPadraoManutencao_)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Image1: TImage;
    edNomeFornecedor: TEdit;
    DBEdit3: TDBEdit;
    Image2: TImage;
    Edit1: TEdit;
    Label3: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure DBEdit4Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMOVESTMOV: TfrmMOVESTMOV;

implementation

{$R *.dfm}

uses unDM, unConsFORNECEDOR;

procedure TfrmMOVESTMOV.btnSalvarClick(Sender: TObject);
begin
  inherited;
   DataModule1.Transacao.Commit;
   cdsPadrao.Close;
   btnSalvar.Enabled := false;
end;

procedure TfrmMOVESTMOV.DBEdit4Exit(Sender: TObject);
begin
   with DataModule1.cdsTELASCONSULTA do
     begin
       close;
       CommandText := 'select * from fornecedor where codigo_for = ' + dbedit4.Text;
       Open;
       if not IsEmpty then
          ednomefornecedor.Text := FieldByName('NOME_FOR').AsString
       else
           ednomefornecedor.Text  := 'Fornecedor n�o cadastrado';
     end;

end;

procedure TfrmMOVESTMOV.FormCreate(Sender: TObject);
begin
  inherited;

  cdsPadrao := DataModule1.cdsPAGTIT;
end;

procedure TfrmMOVESTMOV.FormShow(Sender: TObject);
begin
  inherited;
   if (cdsPadrao.State = dsInsert) then
       DataModule1.iniciarClientDataSet(cdsPadrao);
end;

procedure TfrmMOVESTMOV.Image1Click(Sender: TObject);
begin
  Application.CreateForm(TfmrConsFORNECEDOR,FmrConsFORNECEDOR);
     fmrCONSFORNECEDOR.ShowModal;
     if not DataModule1.cdsFORNECEDOR.IsEmpty then
     begin
          dbedit4.Text := DataModule1.cdsFORNECEDOR.FieldByName('CODIGO_FOR').AsString;
          dbedit4Exit(Self);
        //  edSenhaUsuario.SetFocus;
     end;

end;

end.
