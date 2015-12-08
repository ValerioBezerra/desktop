unit uParametro;

interface

uses
  Classes;

type
  TParametro = class
  private
    FIdEmpresa: Integer;
    FTabela: String;
    FOperacao: String;
    FExtras: TStringList;
  public
    constructor Create(AIdEmpresa: Integer; ATabela, AOperacao: String; AExtras: TStringList);
    property IdEmpresa: Integer read FIdEmpresa write FIdEmpresa;
    property Tabela: String read FTabela write FTabela;
    property Operacao: String read FOperacao write FOperacao;
    property Extras: TStringList read FExtras write FExtras;
end;

implementation

{ TParametro }

constructor TParametro.Create(AIdEmpresa: Integer; ATabela, AOperacao: String; AExtras: TStringList);
begin
  IdEmpresa := AIdEmpresa;
  Tabela    := ATabela;
  Operacao  := AOperacao;
  Extras    := AExtras;
end;

end.

