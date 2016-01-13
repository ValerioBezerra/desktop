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

uses uUtil, uCMKingGeral, uFrmGER001Consulta, uFrmGER002Consulta,
  uFrmGER003Consulta;



{ TKingAutorizacao }

class procedure TKingGeral.AbrirPrograma;
var
  SiglaModulo: String;
  CodigoPrograma: String;
begin
  try
    TUtil.CarregarClasses(cmKingGeral.cdsConsulta);

    SiglaModulo    := Copy(ParamStr(1), 1, 3);
    CodigoPrograma := Copy(ParamStr(1), 4, 3);

    if (SiglaModulo = 'GER') then
      begin
        if (CodigoPrograma = '001') then
          begin
            Application.CreateForm(TfrmGER001Consulta, frmGER001Consulta);
            frmGER001Consulta.ShowModal;
          end;

        if (CodigoPrograma = '002') then
          begin
            Application.CreateForm(TfrmGER002Consulta, frmGER002Consulta);
            frmGER002Consulta.ShowModal;
          end;

        if (CodigoPrograma = '003') then
          begin
            Application.CreateForm(TfrmGER003Consulta, frmGER003Consulta);
            frmGER003Consulta.ShowModal;
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

