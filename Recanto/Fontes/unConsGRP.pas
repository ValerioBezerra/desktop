unit unConsGRP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls;

type
  TfmrConsGRP = class(TForm)
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
  fmrConsGRP: TfmrConsGRP;

implementation

{$R *.dfm}

uses unDM;

procedure TfmrConsGRP.btConsultarClick(Sender: TObject);
begin
     with DataModule1.cdsESTGRP do
     begin
       close;
       CommandText := 'select * from estgrp where descricao_grp like ''%' + edConsultar.Text + '%''';
       Open;
     end;
end;

procedure TfmrConsGRP.DBGrid1DblClick(Sender: TObject);
begin
           Close;
end;

procedure TfmrConsGRP.FormCreate(Sender: TObject);
begin
         with DataModule1.cdsESTGRP do
         begin
           Close;
           CommandText := 'select * from estgrp';
           Open;
         end;
end;

end.
