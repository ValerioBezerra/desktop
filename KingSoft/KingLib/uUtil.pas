unit uUtil;

interface

uses
  Forms, Windows, SysUtils, IdGlobal, IdHash, IdHashMessageDigest, Vcl.Controls, DBCtrls, Graphics, Mask, StdCtrls,
  uEmpresa, uUsuario, uPrograma, Data.DB, Datasnap.DBClient, uKsNumberEdit, uKsDBNumberEdit, uKsDateEdit, uKsDBDateEdit;

type
  TUtil = class
  public
    class var Empresa: TEmpresa;
    class var Usuario: TUsuario;
    class var Programa: TPrograma;
    class procedure CarregarClasses(cds: TClientDataSet);
    class procedure CarregarEmpresa(cds: TClientDataSet);
    class procedure CarregarUsuario(cds: TClientDataSet);
    class procedure CorElementoEmFoco(Formulario: TForm);
    class procedure HabilitarDesabilitarElementos(Formulario: TForm; HabilitarDesabilitar: Char);
    class procedure IniciarClientDataSet(cds: TClientDataSet);
    class procedure ExibirMensagem(const Mensagem: String; Tipo: Char = ' ');
    class function  ExibirPergunta(const Mensagem: String): Boolean;
    class function  CarregarModuloPrograma(cds: TClientDataSet; SiglaModulo: String = ''; CodigoPrograma: String = ''): Boolean;
    class function  TestarRetorno(const Operacao, Retorno: String): Boolean;
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

class function TUtil.CarregarModuloPrograma(cds: TClientDataSet; SiglaModulo: String; CodigoPrograma: String): Boolean;
var
  Retorno: Boolean;
begin
  Retorno := True;

  cds.Close;
  cds.CommandText := ' SELECT AUT_ID_MOD, ' +
                     '        AUT_SIGLA_MOD, ' +
                     '        AUT_DESCRICAO_MOD, ' +
                     '        AUT_EXECUTAVEL_MOD, ' +
                     '        AUT_ORDEM_MOD, ' +
                     '        AUT_ID_PRO, ' +
                     '        AUT_CODIGO_PRO, ' +
                     '        AUT_DESCRICAO_PRO, ' +
                     '        AUT_MENUPRINCIPAL_PRO ' +
                     ' FROM AUT_PRO ' +
                     ' INNER JOIN AUT_MOD ON AUT_ID_MOD = AUT_AUTMOD_PRO ';

  if (Trim(SiglaModulo) = '') and (Trim(CodigoPrograma) = '')  then
    begin
      cds.CommandText := cds.CommandText + '   AND AUT_SIGLA_MOD = ' + QuotedStr(Copy(ParamStr(1), 1, 3)) +
                                           '   AND AUT_CODIGO_PRO = ' + QuotedStr(Copy(ParamStr(1), 4, 3));
    end
  else
    begin
      cds.CommandText := cds.CommandText + '   AND AUT_SIGLA_MOD = ' + QuotedStr(SiglaModulo) +
                                           '   AND AUT_CODIGO_PRO = ' + QuotedStr(CodigoPrograma);
    end;

  cds.Open;

  if (cds.IsEmpty) then
    begin
      Retorno := False;
      raise Exception.Create('Programa n�o cadastrado. Entre em contato com a King Soft.');
    end
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
      Programa.Incluir           := False;
      Programa.Editar            := False;
      Programa.Apagar            := False;
      Programa.Visualizar        := False;

      cds.Close;
      cds.CommandText := ' SELECT AUT_INCLUIR_APE AS INCLUIR, ' +
                         '        AUT_EDITAR_APE AS EDITAR, ' +
                         '        AUT_APAGAR_APE AS APAGAR ' +
                         ' FROM AUT_APE ' +
                         ' WHERE AUT_GEREMP_APE = ' + IntToStr(Empresa.Id) +
                         '   AND AUT_AUTPER_APE = ' + IntToStr(Usuario.Perfil.Id) +
                         '   AND AUT_AUTPRO_APE = ' + IntToStr(Programa.Id) +
                         ' UNION ' +
                         ' SELECT AUT_INCLUIR_AUS AS INCLUIR, ' +
                         '        AUT_EDITAR_AUS AS EDITAR, ' +
                         '        AUT_APAGAR_AUS AS APAGAR ' +
                         ' FROM AUT_AUS ' +
                         ' INNER JOIN AUT_PRO ON AUT_ID_PRO = AUT_AUTPRO_AUS ' +
                         ' INNER JOIN AUT_MOD ON AUT_ID_MOD = AUT_AUTMOD_PRO ' +
                         ' WHERE AUT_GEREMP_AUS = ' + IntToStr(Empresa.Id) +
                         '   AND AUT_AUTUSU_AUS = ' + IntToStr(Usuario.Id) +
                         '   AND AUT_AUTPRO_AUS = ' + IntToStr(Programa.Id);
      cds.Open;

      if not(cds.IsEmpty) then
        begin
          Programa.Incluir    := (cds.FieldByName('INCLUIR').AsInteger = 1);
          Programa.Editar     := (cds.FieldByName('EDITAR').AsInteger = 1);
          Programa.Apagar     := (cds.FieldByName('APAGAR').AsInteger = 1);
          Programa.Visualizar := True;
        end;
    end;

  Result := Retorno;
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

class procedure TUtil.CorElementoEmFoco(Formulario: TForm);
var
 I: Integer;
begin
  for I := 0 to Formulario.ComponentCount - 1 do
    begin
      if (Formulario.Components[I] is TDBEdit) and
         ((Formulario.Components[I] as TDBEdit).Tag in [0,5]) and
         ((Formulario.Components[I] as TDBEdit).Enabled and not((Formulario.Components[I] as TDBEdit).ReadOnly)) then
        begin
          if (Formulario.ActiveControl = Formulario.Components[I]) then
            (Formulario.Components[I] as TDBEdit).Color := clMaroon
          else
            (Formulario.Components[I] as TDBEdit).Color := clWindow;
        end;

      if (Formulario.Components[I] is TKsNumberEdit) and
         ((Formulario.Components[I] as TKsNumberEdit).Tag in [0,5]) and
         ((Formulario.Components[I] as TKsNumberEdit).Enabled and not((Formulario.Components[I] as TKsNumberEdit).ReadOnly)) then
        begin
          if (Formulario.ActiveControl = Formulario.Components[I]) then
            (Formulario.Components[I] as TKsNumberEdit).Color := clSkyBlue
          else
            (Formulario.Components[I] as TKsNumberEdit).Color := clWindow;
        end;

      if (Formulario.Components[I] is TKsDBNumberEdit) and
         ((Formulario.Components[I] as TKsDBNumberEdit).Tag in [0,5]) and
         ((Formulario.Components[I] as TKsDBNumberEdit).Enabled and not((Formulario.Components[I] as TKsDBNumberEdit).ReadOnly)) then
        begin
          if (Formulario.ActiveControl = Formulario.Components[I]) then
            (Formulario.Components[I] as TKsDBNumberEdit).Color := clSkyBlue
          else
            (Formulario.Components[I] as TKsDBNumberEdit).Color := clWindow;
        end;

      if (Formulario.Components[I] is TEdit) and
         ((Formulario.Components[I] as TEdit).Tag in [0,5]) and
         ((Formulario.Components[I] as TEdit).Enabled and not((Formulario.Components[I] as TEdit).ReadOnly)) then
        begin
          if (Formulario.ActiveControl = Formulario.Components[I]) then
            (Formulario.Components[I] as TEdit).Color := clSkyBlue
          else
            (Formulario.Components[I] as TEdit).Color := clWindow;
        end;

      if (Formulario.Components[I] is TDBMemo) and
         ((Formulario.Components[I] as TDBMemo).Tag in [0,5]) and
         ((Formulario.Components[I] as TDBMemo).Enabled and not((Formulario.Components[I] as TDBMemo).ReadOnly)) then
        begin
          if (Formulario.ActiveControl = Formulario.Components[I]) then
            (Formulario.Components[I] as TDBMemo).Color := clSkyBlue
          else
            (Formulario.Components[I] as TDBMemo).Color := clWindow;
        end;

      if (Formulario.Components[I] is TMemo) and
         ((Formulario.Components[I] as TMemo).Tag in [0,5]) and
         ((Formulario.Components[I] as TMemo).Enabled and not((Formulario.Components[I] as TMemo).ReadOnly)) then
        begin
          if (Formulario.ActiveControl = Formulario.Components[I]) then
            (Formulario.Components[I] as TMemo).Color := clSkyBlue
          else
            (Formulario.Components[I] as TMemo).Color := clWindow;
        end;

      if (Formulario.Components[I] is TMaskEdit) and
         ((Formulario.Components[I] as TMaskEdit).Tag in [0,5]) and
         ((Formulario.Components[I] as TMaskEdit).Enabled and not((Formulario.Components[I] as TMaskEdit).ReadOnly)) then
        begin
          if (Formulario.ActiveControl = Formulario.Components[I]) then
            (Formulario.Components[I] as TMaskEdit).Color := clSkyBlue
          else
            (Formulario.Components[I] as TMaskEdit).Color := clWindow;
        end;

      if (Formulario.Components[I] is TKsDateEdit) and
         ((Formulario.Components[I] as TKsDateEdit).Tag in [0,5]) and
         ((Formulario.Components[I] as TKsDateEdit).Enabled and not((Formulario.Components[I] as TKsDateEdit).ReadOnly)) then
        begin
          if (Formulario.ActiveControl = Formulario.Components[I]) then
            (Formulario.Components[I] as TKsDateEdit).Color := clSkyBlue
          else
            (Formulario.Components[I] as TKsDateEdit).Color := clWindow;
        end;

      if (Formulario.Components[I] is TKsDBDateEdit) and
         ((Formulario.Components[I] as TKsDBDateEdit).Tag in [0,5]) and
         ((Formulario.Components[I] as TKsDBDateEdit).Enabled and not((Formulario.Components[I] as TKsDBDateEdit).ReadOnly)) then
        begin
          if (Formulario.ActiveControl = Formulario.Components[I]) then
            (Formulario.Components[I] as TKsDBDateEdit).Color := clSkyBlue
          else
            (Formulario.Components[I] as TKsDBDateEdit).Color := clWindow;
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

class procedure TUtil.HabilitarDesabilitarElementos(Formulario: TForm; HabilitarDesabilitar: Char);
var
 I: Integer;
begin
  for I := 0 to Formulario.ComponentCount - 1 do
    begin
      if (Formulario.Components[I] is TDBEdit) and
         ((Formulario.Components[I] as TDBEdit).Tag in [0,5]) then
        begin
          (Formulario.Components[I] as TDBEdit).Enabled := (HabilitarDesabilitar = 'H');
        end;

      if (Formulario.Components[I] is TKsNumberEdit) and
         ((Formulario.Components[I] as TKsNumberEdit).Tag in [0,5]) then
        begin
          (Formulario.Components[I] as TKsNumberEdit).Enabled := (HabilitarDesabilitar = 'H');
        end;

      if (Formulario.Components[I] is TKsDBNumberEdit) and
         ((Formulario.Components[I] as TKsDBNumberEdit).Tag in [0,5]) then
        begin
          (Formulario.Components[I] as TKsDBNumberEdit).Enabled := (HabilitarDesabilitar = 'H');
        end;

      if (Formulario.Components[I] is TEdit) and
         ((Formulario.Components[I] as TEdit).Tag in [0,5]) then
        begin
          (Formulario.Components[I] as TEdit).Enabled := (HabilitarDesabilitar = 'H');
        end;

      if (Formulario.Components[I] is TDBMemo) and
         ((Formulario.Components[I] as TDBMemo).Tag in [0,5]) then
        begin
          (Formulario.Components[I] as TDBMemo).Enabled := (HabilitarDesabilitar = 'H');
        end;

      if (Formulario.Components[I] is TMemo) and
         ((Formulario.Components[I] as TMemo).Tag in [0,5]) then
        begin
          (Formulario.Components[I] as TMemo).Enabled := (HabilitarDesabilitar = 'H');
        end;

      if (Formulario.Components[I] is TMaskEdit) and
         ((Formulario.Components[I] as TMaskEdit).Tag in [0,5]) then
        begin
          (Formulario.Components[I] as TMaskEdit).Enabled := (HabilitarDesabilitar = 'H');
        end;

      if (Formulario.Components[I] is TKsDateEdit) and
         ((Formulario.Components[I] as TKsDateEdit).Tag in [0,5]) then
        begin
          (Formulario.Components[I] as TKsDateEdit).Enabled := (HabilitarDesabilitar = 'H');
        end;

      if (Formulario.Components[I] is TKsDBDateEdit) and
         ((Formulario.Components[I] as TKsDBDateEdit).Tag in [0,5]) then
        begin
          (Formulario.Components[I] as TKsDBDateEdit).Enabled := (HabilitarDesabilitar = 'H');
        end;
    end;
end;

class procedure TUtil.IniciarClientDataSet(cds: TClientDataSet);
var
  I: integer;
begin
  for I := 0 to cds.FieldCount - 1 do
    begin
      if ((cds.Fields[I].DataType = ftFixedChar) or (cds.Fields[I].DataType = ftWideString) or (cds.Fields[I].DataType = ftString) or (cds.Fields[I].DataType = ftBlob) or (cds.Fields[I].DataType = ftMemo)) then
        cds.Fields[I].Value := '';

      if (cds.Fields[I].DataType = ftInteger) or (cds.Fields[I].DataType = ftFloat) or (cds.Fields[I].DataType = ftSmallint) or (cds.Fields[I].DataType = ftLargeInt) or (cds.Fields[I].DataType = ftCurrency) or (cds.Fields[I].DataType = ftbcd) then
        cds.Fields[I].Asfloat := 0;
    end;
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

class function TUtil.TestarRetorno(const Operacao, Retorno: String): Boolean;
begin
  if (Trim(Retorno) <> '') then
    begin
      if (Operacao <> 'D') then
        TUtil.ExibirMensagem('Corrija o(s) seguintes erros: ' + #13 + Retorno, 'E')
      else
        TUtil.ExibirMensagem('N�o foi poss�vel excluir: ' + #13 + Retorno, 'E')
    end;

  Result := (Trim(Retorno) = '');
end;

end.

