unit uModulo;

interface

type
  TModulo = class
  private
    FId: Integer;
    FSigla: String;
    FDescricao: String;
    FExecutavel: String;
    FOrdem: Integer;
  public
    property Id: Integer read FId write FId;
    property Sigla: String read FSigla write FSigla;
    property Descricao: String read FDescricao write FDescricao;
    property Executavel: String read FExecutavel write FExecutavel;
    property Ordem: Integer read FOrdem write FOrdem;
end;

implementation

{ TModulo }

end.

