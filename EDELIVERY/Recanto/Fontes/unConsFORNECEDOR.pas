unit unConsFORNECEDOR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls;

type
  TfmrConsFORNECEDOR = class(TForm)
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
  fmrConsFORNECEDOR: TfmrConsFORNECEDOR;

implementation

{$R *.dfm}

uses unDM;

procedure TfmrConsFORNECEDOR.btConsultarClick(Sender: TObject);
begin
     with DataModule1.cdsFORNECEDOR do
     begin
       close;
       CommandText := 'select * from fornecedor where nome_for like ''%' + edConsultar.Text + '%''';
       Open;
     end;
end;

procedure TfmrConsFORNECEDOR.DBGrid1DblClick(Sender: TObject);
begin
           Close;
end;

procedure TfmrConsFORNECEDOR.FormCreate(Sender: TObject);
begin
         with DataModule1.cdsFORNECEDOR do
         begin
           Close;
           CommandText := 'select * from fornecedor';
           Open;
         end;
end;

end.