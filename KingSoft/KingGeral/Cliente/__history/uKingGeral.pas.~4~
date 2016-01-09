unit uKingGeral;

interface

uses
  SysUtils, Forms;

type
  TKingGeral = class
  public
    class procedure AbrirPrograma;
end;

implementation

{ TKingAutorizacao }

uses uUtil, uCMKingGeral;



{ TKingAutorizacao }

class procedure TKingGeral.AbrirPrograma;
begin
  try
    TUtil.CarregarClasses(cmKingGeral.cdsConsulta);

    if (TUtil.Programa.Modulo.Sigla = 'GER') then
      begin
        if (TUtil.Programa.Codigo = '001') then
          begin
//            Application.CreateForm(TfrmAUT002Consulta, frmAUT002Consulta);
//            frmAUT002Consulta.ShowModal;
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

