unit uUtil;

interface

uses
  Forms, Windows, SysUtils, IdGlobal, IdHash, IdHashMessageDigest;

type
  TUtil = class
  public
    class procedure ExibirMensagem(const Mensagem: String; Tipo: Char);
    class function RetornarMD5(const Valor: String): String;
end;

implementation

{ TSicronizacao }


{ TUtil }

class procedure TUtil.ExibirMensagem(const Mensagem: String; Tipo: Char);
begin
  if (Tipo = 'A') then
    Application.MessageBox(PChar(Mensagem), 'King Soft', MB_OK + MB_ICONWARNING)
  else if (Tipo = 'E') then
    Application.MessageBox(PChar(Mensagem), 'King Soft', MB_OK + MB_ICONERROR)
  else
    Application.MessageBox(PChar(Mensagem), 'King Soft', MB_OK + MB_ICONINFORMATION);
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

