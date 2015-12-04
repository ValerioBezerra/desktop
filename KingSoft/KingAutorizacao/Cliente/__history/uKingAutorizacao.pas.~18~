unit uKingAutorizacao;

interface

uses
  SysUtils;

type
  TKingAutorizacao = class
  public
    class procedure AbrirPrograma;
end;

implementation

{ TKingAutorizacao }

uses uUtil, uCMKingAutorizacao;



{ TKingAutorizacao }

class procedure TKingAutorizacao.AbrirPrograma;
begin
  try
    TUtil.CarregarClasses(cmKingAutorizacao.cdsConsulta);

    if (TUtil.Programa.Modulo.Sigla = 'AUT') then
      begin
        if (TUtil.Programa.Codigo = '002') then
          begin
            TUtil.ExibirMensagem(TUtil.Programa.Descricao);
          end;
      end;
  except
    on E: Exception do
      begin
        TUtil.ExibirMensagem(E.Message, 'E');
      end;
  end;
end;

end.

