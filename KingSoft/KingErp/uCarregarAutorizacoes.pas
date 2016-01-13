unit uCarregarAutorizacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls;

type
  TfrmCarregarAutorizacoes = class(TForm)
    ProgressBar1: TProgressBar;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    RazaoSocialEmpresa: String;
  end;

var
  frmCarregarAutorizacoes: TfrmCarregarAutorizacoes;

implementation

{$R *.dfm}

uses uCMKingAutorizacao, uKingErp;

procedure TfrmCarregarAutorizacoes.FormShow(Sender: TObject);
begin
  Application.CreateForm(TfrmKingErp, frmKingErp);
  frmKingErp.RazaoSocialEmpresa := frmCarregarAutorizacoes.RazaoSocialEmpresa;

  cmKingAutorizacao.cdsAUT_MOD.Filtered := False;
  cmKingAutorizacao.cdsAUT_MOD.Filter   := 'AUT_SIGLA_MOD <> ' + QuotedStr('AUT');
  cmKingAutorizacao.cdsAUT_MOD.Filtered := True;
   ProgressBar1.Max := cmKingAutorizacao.cdsAUT_MOD.RecordCount;

  cmKingAutorizacao.cdsAUT_MOD.First;
  while not(cmKingAutorizacao.cdsAUT_MOD.Eof) do
    begin
      ProgressBar1.StepBy(1);
      Application.ProcessMessages;

      frmKingErp.AdicionarModuloCadastro;
      frmKingErp.AdicionarModuloMovimentacao;
      frmKingErp.AdicionarModuloProcesso;
      frmKingErp.AdicionarModuloRelatorioGrafico;
      cmKingAutorizacao.cdsAUT_MOD.Next;
    end;

  cmKingAutorizacao.cdsAUT_MOD.Filtered := False;
  cmKingAutorizacao.cdsAUT_MOD.Filter   := 'AUT_SIGLA_MOD = ' + QuotedStr('AUT');
  cmKingAutorizacao.cdsAUT_MOD.Filtered := True;

  cmKingAutorizacao.cdsAUT_MOD.First;
  while not(cmKingAutorizacao.cdsAUT_MOD.Eof) do
    begin
      frmKingErp.AdicionarModuloAutorizacao;
      cmKingAutorizacao.cdsAUT_MOD.Next;
    end;
    Application.ProcessMessages;

  frmKingErp.Show;
   Close;
end;

end.
