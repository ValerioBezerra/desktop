unit fmrCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.StdCtrls,DB;

type
  TfrmCadastro = class(TForm)
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edC�digo: TEdit;
    dbedDESCRICAO: TDBEdit;
    dbedPRECO: TDBEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    function TestarCampos:String;
    procedure AtualizarGrid;
  public
    { Public declarations }
  end;

var
  frmCadastro: TfrmCadastro;

implementation

{$R *.dfm}

uses DM;

procedure TfrmCadastro.AtualizarGrid;
begin
    with DM.DataModule2.cdsCONSULTA do
     begin
          Close;
          CommandText := ' select * from produto';
          Open;

     end;
end;

procedure TfrmCadastro.DBGrid1DblClick(Sender: TObject);
begin
        Dm.DataModule2.cdsPRO.Close;
        dm.DataModule2.cdsPRO.CommandText := 'select * from produto where cod_produto = ' +
                   dm.DataModule2.cdsCONSULTA.FieldByName('COD_PRODUTO').AsString;
        dm.DataModule2.cdsPRO.Open;
        edC�digo.Text := dm.DataModule2.cdsPRO.FieldByName('COD_PRODUTO').AsString;
        dm.DataModule2.cdsPRO.Edit;
        image2.Enabled := True;
        image3.Enabled := True;
end;

procedure TfrmCadastro.FormCreate(Sender: TObject);
begin
    AtualizarGrid;
end;

procedure TfrmCadastro.Image1Click(Sender: TObject);
begin
        edC�digo.Text := '0';
        with dm.DataModule2.cdsPRO do
        begin
          close;
          CommandText:= 'select * from produto';
          Open;
          Insert;
        end;
        Image2.Enabled := True;
        Image3.Enabled := True;
end;

procedure TfrmCadastro.Image2Click(Sender: TObject);
begin
    if TestarCampos = '' then
    begin
        if dm.DataModule2.cdsPRO.State = dsInsert   then
           dm.DataModule2.cdsPRO.FieldByName('COD_PRODUTO').AsString := '0';
        dm.DataModule2.cdsPRO.Post;
        dm.DataModule2.cdsPRO.ApplyUpdates(0);
        dm.DataModule2.Transacao.Commit;
        dm.DataModule2.cdsPRO.Close;
        edC�digo.Clear;
        Image2.Enabled := False;
        AtualizarGrid;
    end
    else
      showmessage('Campos n�o preenchidos' + #13 + TestarCampos);
end;

procedure TfrmCadastro.Image3Click(Sender: TObject);
begin
       If  MessageDlg('Voc� tem certeza que deseja descartar os dados?',mtConfirmation,[mbyes,mbno],0)=mryes
   then
      begin
        dm.DataModule2.cdsPRO.Close;
        edC�digo.Clear;
        Image3.Enabled := False;
      end;

end;

function TfrmCadastro.TestarCampos: String;
var
retorno : String;
begin
    retorno := '';
    if dbedDESCRICAO.Text = '' then
        retorno := 'Descri��o do item ';
    if dbedPRECO.Text = '' then
         retorno := retorno + #13 + 'Pre�o do Item';

    Result := retorno;

end;

end.
