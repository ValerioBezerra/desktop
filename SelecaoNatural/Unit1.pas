unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg,System.IniFiles;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private
    { Private declarations }
    Banco: String;
    Porta: String;
    function LerConfiguracoes: boolean;


  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses fmrCadastro, frmVenda, frmRelatorio;

procedure TForm1.FormCreate(Sender: TObject);
begin
           LerConfiguracoes;
end;

function TForm1.LerConfiguracoes: boolean;
var
ArquivoINI : TINifile;
begin
   ArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'CONFIG.INI') ;
   Banco := ArquivoINI.ReadString('GERAL', 'Banco', '');
   Porta    := ArquivoINI.ReadString('GERAL', 'Porta', '');


end;

procedure TForm1.Image1Click(Sender: TObject);
begin
     Application.CreateForm(TfrmCadastro,frmCadastro);
     frmCadastro.ShowModal;
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
    Application.CreateForm(Tform2,form2);
     form2.ShowModal;

end;

procedure TForm1.Image4Click(Sender: TObject);
begin
   Application.CreateForm(TForm3,form3);
   form3.ShowModal;
end;

end.
