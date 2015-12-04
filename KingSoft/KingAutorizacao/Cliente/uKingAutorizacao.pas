unit uKingAutorizacao;

interface

uses
  SysUtils, Forms;

type
  TKingAutorizacao = class
  public
    class procedure AbrirPrograma;
end;

implementation

{ TKingAutorizacao }

uses uUtil, uCMKingAutorizacao, uFrmPadraoConsulta, uFrmAUT002Consulta;



{ TKingAutorizacao }

class procedure TKingAutorizacao.AbrirPrograma;
begin
  try
    TUtil.CarregarClasses(cmKingAutorizacao.cdsConsulta);

    if (TUtil.Programa.Modulo.Sigla = 'AUT') then
      begin
        if (TUtil.Programa.Codigo = '002') then
          begin
            Application.CreateForm(TfrmAUT002Consulta, frmAUT002Consulta);
            frmAUT002Consulta.ShowModal;
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

