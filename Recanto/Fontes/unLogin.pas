unit unLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.jpeg;

type
  TfrmLogin = class(TForm)
    edNomeUsuario: TEdit;
    Label1: TLabel;
    edCodUsuario: TEdit;
    Image1: TImage;
    edSenhaUsuario: TEdit;
    Label2: TLabel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    procedure Image1Click(Sender: TObject);
    procedure edCodUsuarioExit(Sender: TObject);
    function TestarCampos:String;
    procedure Image3Click(Sender: TObject);
    function testarSenha:String;
    procedure Image4Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSenhaUsuarioKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses unDM, unConsUSUARIO, unPrincipal;

procedure TfrmLogin.edCodUsuarioExit(Sender: TObject);
begin
     with DataModule1.cdsCONSULTA do
     begin
       close;
       CommandText := 'select * from usuario where codigo_usu = ' + edCodUsuario.Text;
       Open;
       if not IsEmpty then
          edNomeUsuario.Text := FieldByName('NOME_USU').AsString
       else
           edNomeUsuario.Text  := 'Usu�rio n�o cadastrado';
     end;
end;

procedure TfrmLogin.edSenhaUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
     if ord(Key) = VK_RETURN then
        Image3Click(Self);
end;

procedure TfrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        if ord(Key) = VK_RETURN then
        Image3Click(Self);
end;

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if ord(Key) = VK_RETURN then
        Image3Click(Self);

end;

procedure TfrmLogin.Image1Click(Sender: TObject);
begin
     Application.CreateForm(TForm1,Form1);
     Form1.ShowModal;
     if not DataModule1.cdsUSUARIO.IsEmpty then
     begin
          edCodUsuario.Text := DataModule1.cdsUSUARIO.FieldByName('CODIGO_USU').AsString;
          edCodUsuarioExit(Self);
          edSenhaUsuario.SetFocus;
     end;
end;

procedure TfrmLogin.Image3Click(Sender: TObject);
begin
      if TestarCampos <> '' then
          showmessage(TestarCampos)
      else
       begin
            if testarSenha() = 'OK' then
               begin
                 Application.CreateForm(TFrmPrincipal,frmPrincipal);
                 frmPrincipal.ShowModal;
                 edSenhaUsuario.Clear;
               end
            else
                 showmessage('Senha incorreta!');

       end;


end;

procedure TfrmLogin.Image4Click(Sender: TObject);
var
buttonSelected : Integer;
begin
  buttonSelected := MessageDlg('Deseja fechar o sistema?',mtCustom,
                               [mbYes,mbNo], 0);


   if buttonSelected = mrYes    then
       Application.Terminate;

end;

function TfrmLogin.TestarCampos: String;
var
 retorno :string;
begin
     retorno := '';
     if edNomeUsuario.Text = 'Usu�rio n�o informado' then
            retorno := 'Usu�rio n�o informado';
     if edNomeUsuario.Text = '' then
        retorno := 'Usu�rio n�o informado';
     if edSenhaUsuario.Text = '' then
            retorno := retorno + #13 + 'Senha n�o informada';
     Result := retorno;
end;

function TfrmLogin.testarSenha: String;
begin
      with DataModule1.cdsCONSULTA do
      begin
        close;
        CommandText := 'select * from usuario where codigo_usu = ' + edCodUsuario.Text +
                       ' and senha_usu = ' + quotedStr(edSenhaUsuario.Text);
        Open;
        if not isempty then
            Result := 'OK'
        else
             Result := 'ERRO';
      end;
end;

end.
