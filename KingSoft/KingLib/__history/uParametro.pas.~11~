unit uParametro;

interface

type
  TParametro = class
  private
    FIdEmpresa: Integer;
    FTabela: String;
    FOperacao: String;
  public
    constructor Create(AIdEmpresa: Integer; ATabela, AOperacao: String);
    property IdEmpresa: Integer read FIdEmpresa write FIdEmpresa;
    property Tabela: String read FTabela write FTabela;
    property Operacao: String read FOperacao write FOperacao;
end;

implementation

{ TParametro }

constructor TParametro.Create(AIdEmpresa: Integer; ATabela, AOperacao: String);
begin
  IdEmpresa := AIdEmpresa;
  Tabela    := ATabela;
  Operacao  := AOperacao;
end;

end.

