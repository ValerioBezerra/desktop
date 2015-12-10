unit unConsCLIENTE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Data.DB;

type
  TfmrConsCLIENTE = class(TForm)
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
  fmrConsCLIENTE: TfmrConsCLIENTE;

implementation

{$R *.dfm}

uses unDM;

procedure TfmrConsCLIENTE.btConsultarClick(Sender: TObject);
begin
     with DataModule1.cdsCLIENTE do
     begin
       close;
       CommandText := 'select * from cliente where nome_cli like ''%' + edConsultar.Text + '%''';
       Open;
     end;
end;

procedure TfmrConsCLIENTE.DBGrid1DblClick(Sender: TObject);
begin
           Close;
end;

procedure TfmrConsCLIENTE.FormCreate(Sender: TObject);
begin
         with DataModule1.cdsCLIENTE do
         begin
           Close;
           CommandText := 'select * from cliente';
           Open;
         end;
end;

end.
