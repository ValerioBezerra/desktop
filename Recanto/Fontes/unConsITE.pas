unit unConsITE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls;

type
  TfrmConsITE = class(TForm)
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
  frmConsITE: TfrmConsITE;

implementation

{$R *.dfm}

uses unDM;

procedure TfrmConsITE.btConsultarClick(Sender: TObject);
begin
     with DataModule1.cdsESTITE do
     begin
       close;
       CommandText := 'select * from estite where descricao_ite like ''%' + edConsultar.Text + '%''';
       Open;
     end;
end;

procedure TfrmConsITE.DBGrid1DblClick(Sender: TObject);
begin
           Close;
end;

procedure TfrmConsITE.FormCreate(Sender: TObject);
begin
         with DataModule1.cdsESTITE do
         begin
           Close;
           CommandText := 'select * from estite';
           Open;
         end;
end;

end.
