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

uses uUtil, uCMKingAutorizacao, uFrmPadraoConsulta, uFrmAUT002Consulta,
  uFrmAUT003Consulta, uFrmAUT004Consulta, uFrmAUT005Consulta;



{ TKingAutorizacao }

class procedure TKingAutorizacao.AbrirPrograma;
var
  SiglaModulo: String;
  CodigoPrograma: String;
begin
  try
    TUtil.CarregarClasses(cmKingAutorizacao.cdsConsulta);

    SiglaModulo    := Copy(ParamStr(1), 1, 3);
    CodigoPrograma := Copy(ParamStr(1), 4, 3);

    if (SiglaModulo = 'AUT') then
      begin
        if (CodigoPrograma = '002') then
          begin
            Application.CreateForm(TfrmAUT002Consulta, frmAUT002Consulta);
            frmAUT002Consulta.ShowModal;
          end;

        if (CodigoPrograma = '003') then
          begin
            Application.CreateForm(TfrmAUT003Consulta, frmAUT003Consulta);
            frmAUT003Consulta.ShowModal;
          end;

        if (CodigoPrograma = '004') then
          begin
            Application.CreateForm(TfrmAUT004Consulta, frmAUT004Consulta);
            frmAUT004Consulta.ShowModal;
          end;

        if (CodigoPrograma = '005') then
          begin
            Application.CreateForm(TfrmAUT005Consulta, frmAUT005Consulta);
            frmAUT005Consulta.ShowModal;
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

