unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls,DateUtils;

type
  TForm2 = class(TForm)
    edSenha: TEdit;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
bloco1,bloco2,bloco3,bloco4: String;
begin
     bloco1 := VartoStr(ord('e') + Dayof(now));
      bloco2 := VartoStr(ord('e') + Monthof(now));
      bloco3 := VartoStr(ord('n') + Yearof(now));
      bloco4 := VartoStr(ord('v') + Dayof(now) + DaysBetween(DateTimePicker1.Date,now));

     edSenha.Text := bloco1 + bloco2+ bloco3 + bloco4;
end;

end.
