unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmLogin = class(TForm)
    cbEmpresa: TComboBox;
    Label1: TLabel;
    Bevel1: TBevel;
    edtLogin: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses uCMKingAutorizacao;

procedure TfrmLogin.FormShow(Sender: TObject);
var
  DescricaoEmpresa: String;
begin
  cmKingAutorizacao.cdsConsulta.Close;
  cmKingAutorizacao.cdsConsulta.CommandText := ' SELECT * FROM GER_EMP ' +
                                               ' WHERE GER_ATIVA_EMP = 1 ' +
                                               ' ORDER BY GER_CODIGO_EMP, GER_CODFIL_EMP ';
  cmKingAutorizacao.cdsConsulta.Open;

  cbEmpresa.Items.Clear;
  if not(cmKingAutorizacao.cdsConsulta.IsEmpty) then
    begin
      cmKingAutorizacao.cdsConsulta.First;

      while not(cmKingAutorizacao.cdsConsulta.Eof) do
        begin
          DescricaoEmpresa := cmKingAutorizacao.cdsConsulta.FieldByName('GER_CODIGO_EMP').AsString;

          if not(cmKingAutorizacao.cdsConsulta.FieldByName('GER_GEREMP_EMP').IsNull) then
            DescricaoEmpresa := DescricaoEmpresa + '.' + cmKingAutorizacao.cdsConsulta.FieldByName('GER_CODFIL_EMP').AsString;

          DescricaoEmpresa := DescricaoEmpresa + ' - ' + cmKingAutorizacao.cdsConsulta.FieldByName('GER_RAZAOSOCIAL_EMP').AsString;

          if not(cmKingAutorizacao.cdsConsulta.FieldByName('GER_GEREMP_EMP').IsNull) then
            DescricaoEmpresa := DescricaoEmpresa + ' (FILIAL)';

          cbEmpresa.Items.Add(DescricaoEmpresa);
          cmKingAutorizacao.cdsConsulta.Next;
        end;
    end;




end;

end.
