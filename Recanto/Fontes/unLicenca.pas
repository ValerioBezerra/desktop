unit unLicenca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,DateUtils;

type
  TfrmLicenca = class(TForm)
    Label1: TLabel;
    btValidar: TButton;
    btSalvar: TButton;
    btSair: TButton;
    Label2: TLabel;
    edVencimento: TEdit;
    edCodigo: TEdit;
    procedure btValidarClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
        function validarLicenca(Codigo:String):Boolean;
  end;

var
  frmLicenca: TfrmLicenca;

implementation

{$R *.dfm}

uses DM_GERENCIADOR;

{ TfrmLicenca }

procedure TfrmLicenca.btValidarClick(Sender: TObject);
begin
   if validarLicenca(edCodigo.Text) then
     showmessage('OK');
end;

function TfrmLicenca.validarLicenca(Codigo: String): Boolean;
var
bloco1,bloco2,bloco3,bloco4 :String;
resultado : Boolean;
aux : Integer;
begin
  resultado := True;
  if Codigo.Length = 13 then
  begin

      bloco1 := Copy(Codigo,0,3);
      bloco2 := Copy(Codigo,4,3);
      bloco3 := copy(Codigo,7,4);
      bloco4 := Copy(Codigo,11,4);

         if bloco1 <> VartoStr(ord('e') + Dayof(now)) then
              resultado := false;
         if bloco2 <> VartoStr(ord('e') + Monthof(now)) then
                 resultado := false;
         if bloco3 <> VartoStr(ord('n') + Yearof(now)) then
                 resultado := false;

         if resultado = True then
           begin
               aux := StrtoInt(bloco4);
               aux := aux - ord('v');
               aux := aux - Dayof(now);
               aux := aux +1 ;
              edVencimento.Text := DatetoStr(IncDay(now,aux));

           end;


  end
  else
  begin
     showmessage('Licen�a inv�lida!');
      resultado := false;
  end;
end;

end.
