unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmLogin = class(TForm)
    cbEmpresas: TComboBox;
    Label1: TLabel;
    Bevel1: TBevel;
    edLogin: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edSenha: TEdit;
    btnEntrar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
  private
    { Private declarations }
    CodigosEmpresas: Array of Integer;
    function TestarAutorizacao: Boolean;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses uCMKingAutorizacao, uUtil;

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
  if (TestarAutorizacao) then
    begin

    end;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
var
  DescricaoEmpresa: String;
begin
  cmKingAutorizacao.cdsConsulta.Close;
  cmKingAutorizacao.cdsConsulta.CommandText := ' SELECT * FROM GER_EMP ' +
                                               ' WHERE GER_ATIVA_EMP = 1 ' +
                                               ' ORDER BY GER_CODIGO_EMP, GER_CODFIL_EMP ';
  cmKingAutorizacao.cdsConsulta.Open;

  cbEmpresas.Items.Clear;
  SetLength(CodigosEmpresas, 0);
  if not(cmKingAutorizacao.cdsConsulta.IsEmpty) then
    begin
      cmKingAutorizacao.cdsConsulta.First;

      while not(cmKingAutorizacao.cdsConsulta.Eof) do
        begin
          SetLength(CodigosEmpresas, Length(CodigosEmpresas) + 1);
          CodigosEmpresas[High(CodigosEmpresas)] :=  cmKingAutorizacao.cdsConsulta.FieldByName('GER_ID_EMP').AsInteger;
          DescricaoEmpresa                       := cmKingAutorizacao.cdsConsulta.FieldByName('GER_CODIGO_EMP').AsString;

          if not(cmKingAutorizacao.cdsConsulta.FieldByName('GER_GEREMP_EMP').IsNull) then
            DescricaoEmpresa := DescricaoEmpresa + '.' + cmKingAutorizacao.cdsConsulta.FieldByName('GER_CODFIL_EMP').AsString;

          DescricaoEmpresa := DescricaoEmpresa + ' - ' + cmKingAutorizacao.cdsConsulta.FieldByName('GER_RAZAOSOCIAL_EMP').AsString;

          if not(cmKingAutorizacao.cdsConsulta.FieldByName('GER_GEREMP_EMP').IsNull) then
            DescricaoEmpresa := DescricaoEmpresa + ' (FILIAL)';

          cbEmpresas.Items.Add(DescricaoEmpresa);
          cmKingAutorizacao.cdsConsulta.Next;
        end;
    end;
end;

function TfrmLogin.TestarAutorizacao: Boolean;
var
  Mensagem: String;
  Separador: String;
begin
  Mensagem  := '';
  Separador := '';

  if (cbEmpresas.ItemIndex = -1) then
    begin
      Mensagem  := Mensagem + Separador + ' - Selecione a empresa';
      Separador := #13;
    end;

  if (Trim(edLogin.Text) = '') then
    begin
      Mensagem  := Mensagem + Separador + ' - Informe o login';
      Separador := #13;
    end;

  if (Trim(edSenha.Text) = '') then
    begin
      Mensagem  := Mensagem + Separador + ' - Informe a senha';
      Separador := #13;
    end;

  if ((Trim(edLogin.Text) <> '') and (Trim(edSenha.Text) <> '')) then
    begin
      cmKingAutorizacao.cdsAUT_USU.Close;
      cmKingAutorizacao.cdsAUT_USU.CommandText := ' SELECT * FROM AUT_USU ' +
                                                  ' WHERE AUT_LOGIN_USU = ' + QuotedStr(edLogin.Text);
      cmKingAutorizacao.cdsAUT_USU.Open;

      if (cmKingAutorizacao.cdsAUT_USU.IsEmpty) then
        begin
          Mensagem  := Mensagem + Separador + ' - N�o h� usu�rio cadastrado com estre login';
          Separador := #13;
        end
      else
        begin
          cmKingAutorizacao.cdsAUT_USU.First;
          if (cmKingAutorizacao.cdsAUT_USU.FieldByName('AUT_SENHA_USU').AsString <> TUtil.RetornarMD5(edSenha.Text)) then
            begin
              Mensagem  := Mensagem + Separador + ' - Senha incorreta';
              Separador := #13;
            end;
        end;
    end;

  if (Trim(Mensagem) <> '') then
     TUtil.ExibirMensagem('Corrija o(s) seguintes erros: ' + #13 + Mensagem, 'E');

  Result := (Trim(Mensagem) <> '');
end;

end.
