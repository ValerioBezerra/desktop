unit uUtil;

interface

uses
  Forms, Windows, SysUtils, IdGlobal, IdHash, IdHashMessageDigest, Vcl.Controls,
  uEmpresa, uUsuario, uPrograma, Data.DB, Datasnap.DBClient;

type
  TUtil = class
  public
    class var Empresa: TEmpresa;
    class var Usuario: TUsuario;
    class var Programa: TPrograma;
    class procedure CarregarClasses(cds: TClientDataSet);
    class procedure CarregarEmpresa(cds: TClientDataSet);
    class procedure CarregarUsuario(cds: TClientDataSet);
    class procedure CarregarModuloPrograma(cds: TClientDataSet);
    class procedure ExibirMensagem(const Mensagem: String; Tipo: Char = ' ');
    class function  ExibirPergunta(const Mensagem: String): Boolean;
    class function  RetornarMD5(const Valor: String): String;
    class function  MoverHint(Form: TForm): String;
end;

implementation

{ TUtil }

uses uPerfil, uModulo;

class procedure TUtil.CarregarClasses(cds: TClientDataSet);
begin
  CarregarEmpresa(cds);
  CarregarUsuario(cds);
  CarregarModuloPrograma(cds);
end;

class procedure TUtil.CarregarEmpresa(cds: TClientDataSet);
begin
  cds.Close;
  cds.CommandText := 'SELECT * FROM GER_EMP WHERE GER_ID_EMP = ' + ParamStr(2);
  cds.Open;

  if (cds.IsEmpty) then
    raise Exception.Create('Empresa n�o cadastrada no KingErp.')
  else
    begin
      Empresa             := TEmpresa.Create;
      Empresa.Id          := cds.FieldByName('GER_ID_EMP').AsInteger;
      Empresa.RazaoSocial := cds.FieldByName('GER_RAZAOSOCIAL_EMP').AsString;
      Empresa.Fantasial   := cds.FieldByName('GER_FANTASIA_EMP').AsString;
    end;
end;

class procedure TUtil.CarregarModuloPrograma(cds: TClientDataSet);
begin
  cds.Close;
  cds.CommandText := ' SELECT AUT_ID_MOD, ' +
                     '        AUT_SIGLA_MOD, ' +
                     '        AUT_DESCRICAO_MOD, ' +
                     '        AUT_EXECUTAVEL_MOD, ' +
                     '        AUT_ORDEM_MOD, ' +
                     '        AUT_ID_PRO, ' +
                     '        AUT_CODIGO_PRO, ' +
                     '        AUT_DESCRICAO_PRO, ' +
                     '        AUT_MENUPRINCIPAL_PRO, ' +
                     '        AUT_INCLUIR_APE AS INCLUIR, ' +
                     '        AUT_EDITAR_APE AS EDITAR, ' +
                     '        AUT_APAGAR_APE AS APAGAR ' +
                     ' FROM AUT_APE ' +
                     ' INNER JOIN AUT_PRO ON AUT_ID_PRO = AUT_AUTPRO_APE ' +
                     ' INNER JOIN AUT_MOD ON AUT_ID_MOD = AUT_AUTMOD_PRO ' +
                     ' WHERE AUT_GEREMP_APE = ' + IntToStr(Empresa.Id) +
                     '   AND AUT_AUTPER_APE = ' + IntToStr(Usuario.Perfil.Id) +
                     '   AND AUT_SIGLA_MOD = ' + QuotedStr(Copy(ParamStr(1), 1, 3)) +
                     '   AND AUT_CODIGO_PRO = ' + QuotedStr(Copy(ParamStr(1), 4, 3)) +
                     ' UNION ' +
                     ' SELECT AUT_ID_MOD, ' +
                     '        AUT_SIGLA_MOD, ' +
                     '        AUT_DESCRICAO_MOD, ' +
                     '        AUT_EXECUTAVEL_MOD, ' +
                     '        AUT_ORDEM_MOD, ' +
                     '        AUT_ID_PRO, ' +
                     '        AUT_CODIGO_PRO, ' +
                     '        AUT_DESCRICAO_PRO, ' +
                     '        AUT_MENUPRINCIPAL_PRO, ' +
                     '        AUT_INCLUIR_AUS AS INCLUIR, ' +
                     '        AUT_EDITAR_AUS AS EDITAR, ' +
                     '        AUT_APAGAR_AUS AS APAGAR ' +
                     ' FROM AUT_AUS ' +
                     ' INNER JOIN AUT_PRO ON AUT_ID_PRO = AUT_AUTPRO_AUS ' +
                     ' INNER JOIN AUT_MOD ON AUT_ID_MOD = AUT_AUTMOD_PRO ' +
                     ' WHERE AUT_GEREMP_AUS = ' + IntToStr(Empresa.Id) +
                     '   AND AUT_AUTUSU_AUS = ' + IntToStr(Usuario.Id) +
                     '   AND AUT_SIGLA_MOD = ' + QuotedStr(Copy(ParamStr(1), 1, 3)) +
                     '   AND AUT_CODIGO_PRO = ' + QuotedStr(Copy(ParamStr(1), 4, 3));
  cds.Open;

  if (cds.IsEmpty) then
    raise Exception.Create('Usu�rio n�o tem autoriza��o para este programa.')
  else
    begin
      Programa                   := TPrograma.Create;
      Programa.Modulo            := TModulo.Create;
      Programa.Modulo.Id         := cds.FieldByName('AUT_ID_MOD').AsInteger;
      Programa.Modulo.Sigla      := cds.FieldByName('AUT_SIGLA_MOD').AsString;
      Programa.Modulo.Descricao  := cds.FieldByName('AUT_DESCRICAO_MOD').AsString;
      Programa.Modulo.Executavel := cds.FieldByName('AUT_EXECUTAVEL_MOD').AsString;
      Programa.Modulo.Ordem      := cds.FieldByName('AUT_ORDEM_MOD').AsInteger;
      Programa.Id                := cds.FieldByName('AUT_ID_PRO').AsInteger;
      Programa.Codigo            := cds.FieldByName('AUT_CODIGO_PRO').AsString;
      Programa.Descricao         := cds.FieldByName('AUT_DESCRICAO_PRO').AsString;
      Programa.MenuPrincipal     := (cds.FieldByName('AUT_MENUPRINCIPAL_PRO').AsInteger = 1);
      Programa.Incluir           := (cds.FieldByName('INCLUIR').AsInteger = 1);
      Programa.Editar            := (cds.FieldByName('EDITAR').AsInteger = 1);
      Programa.Apagar            := (cds.FieldByName('APAGAR').AsInteger = 1);
    end;
end;

class procedure TUtil.CarregarUsuario(cds: TClientDataSet);
begin
  cds.Close;
  cds.CommandText := ' SELECT * FROM AUT_USU ' +
                     ' LEFT OUTER JOIN AUT_PER ON AUT_ID_PER = AUT_AUTPER_USU ' +
                     ' WHERE AUT_ID_USU = ' + ParamStr(3);
  cds.Open;

  if (cds.IsEmpty) then
    raise Exception.Create('Usu�rio n�o cadastrado no KingErp.')
  else
    begin
      if (cds.FieldByName('AUT_SENHA_USU').AsString <> ParamStr(4)) then
        raise Exception.Create('Senha do usu�rio incorreta.')
      else
        begin
          Usuario                  := TUsuario.Create;
          Usuario.Id               := cds.FieldByName('AUT_ID_USU').AsInteger;
          Usuario.Perfil           := TPerfil.Create;
          Usuario.Perfil.Id        := cds.FieldByName('AUT_ID_PER').AsInteger;
          Usuario.Perfil.Descricao := cds.FieldByName('AUT_DESCRICAO_PER').AsString;
          Usuario.Nome             := cds.FieldByName('AUT_NOME_USU').AsString;
          Usuario.Login            := cds.FieldByName('AUT_LOGIN_USU').AsString;
          Usuario.KingSoft         := (cds.FieldByName('AUT_KING_USU').AsInteger = 1);
          Usuario.Ativo            := (cds.FieldByName('AUT_ATIVO_USU').AsInteger = 1);
        end;
    end;
end;

class procedure TUtil.ExibirMensagem(const Mensagem: String; Tipo: Char);
begin
  if (Tipo = 'A') then
    Application.MessageBox(PChar(Mensagem), 'King Soft', MB_OK + MB_ICONWARNING)
  else if (Tipo = 'E') then
    Application.MessageBox(PChar(Mensagem), 'King Soft', MB_OK + MB_ICONERROR)
  else
    Application.MessageBox(PChar(Mensagem), 'King Soft', MB_OK + MB_ICONINFORMATION);
end;


class function TUtil.ExibirPergunta(const Mensagem: String): Boolean;
begin
  Result := (Application.MessageBox(PChar(Mensagem), 'King Soft', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES);
end;

class function TUtil.MoverHint(Form: TForm): String;
var
  I: Integer;
begin
  for I := 0 to Form.ComponentCount - 1 do
    begin
      if (Form.ActiveControl = Form.components[I]) then
        begin
          if (form.components[I] is TControl) then
            begin
              if (Trim((form.components[I] as TControl).Hint) <> '') then
                Result := (form.components[I] as TControl).Hint;
            end;
        end;
    end;
end;

class function TUtil.RetornarMD5(const Valor: String): String;
var
  IdHashMessageDigest5: TIdHashMessageDigest5;
begin
  try
    IdHashMessageDigest5 := TIdHashMessageDigest5.Create;
    Result := IdGlobal.IndyLowerCase(IdHashMessageDigest5.HashStringAsHex(Valor));
  finally
    IdHashMessageDigest5.Free;
  end;
end;

end.

