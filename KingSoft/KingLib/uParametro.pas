unit uParametro;

interface

type
  TParametro = class
  private
    FIdEmpresa: Integer;
    FTabela: String;
    FOperacao: String;
    FDados: OleVariant;
  public
    constructor Create(AIdEmpresa: Integer; ATabela, AOperacao: String; ADados: OleVariant);
    property IdEmpresa: Integer read FIdEmpresa write FIdEmpresa;
    property Tabela: String read FTabela write FTabela;
    property Operacao: String read FOperacao write FOperacao;
    property Dados: OleVariant read FDados write FDados;
end;

implementation

{ TParametro }

constructor TParametro.Create(AIdEmpresa: Integer; ATabela, AOperacao: String; ADados: OleVariant);
begin
  IdEmpresa := AIdEmpresa;
  Tabela    := ATabela;
  Operacao  := AOperacao;
  Dados     := ADados;
end;

end.

