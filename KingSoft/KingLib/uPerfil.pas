unit uPerfil;

interface

type
  TPerfil = class
  private
    FId: Integer;
    FDescricao: String;
  public
    property Id: Integer read FId write FId;
    property Descricao: String read FDescricao write FDescricao;
end;

implementation

{ TPerfil }

end.

