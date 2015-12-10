unit unConsUSUARIO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    edConsultar: TEdit;
    btConsultar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btConsultarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses unDM;

procedure TForm1.btConsultarClick(Sender: TObject);
begin
     with DataModule1.cdsUSUARIO do
     begin
       close;
       CommandText := 'select * from usuario where nome_usu like ''%' + edConsultar.Text + '%''';
       Open;
     end;
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
           Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
         with DataModule1.cdsUSUARIO do
         begin
           Close;
           CommandText := 'select * from usuario';
           Open;
         end;
end;

end.
