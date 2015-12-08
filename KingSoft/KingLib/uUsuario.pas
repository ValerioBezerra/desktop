unit uUsuario;

interface

uses
  uPerfil;

type
  TUsuario = class
  private
    FId: Integer;
    FNome: String;
    FPerfil: TPerfil;
    FLogin: String;
    FSenha: String;
    FKingSoft: Boolean;
    FAtivo: Boolean;
  public
    property Id: Integer read FId write FId;
    property Nome: String read FNome write FNome;
    property Perfil: TPerfil read FPerfil write FPerfil;
    property Login: String read FLogin write FLogin;
    property Senha: String read FSenha write FSenha;
    property KingSoft: Boolean read FKingSoft write FKingSoft;
    property Ativo: Boolean read FAtivo write FAtivo;
end;

implementation

{ TUsuario }

end.

