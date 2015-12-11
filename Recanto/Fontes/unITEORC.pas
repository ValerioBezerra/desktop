unit unITEORC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls,Data.DB;

type
  TfrmITEORC = class(TForm)
    edSEQORC_ITEORC: TEdit;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    edSEQ_ITEORC: TEdit;
    Label2: TLabel;
    edCODITE_ITEORC: TEdit;
    Label3: TLabel;
    Image1: TImage;
    edDESCRICAO_ITE: TEdit;
    edQTD_ITEORC: TEdit;
    Label4: TLabel;
    edVLRUNI_ITEORC: TEdit;
    Label5: TLabel;
    edVLR_TOTAL: TEdit;
    Label6: TLabel;
    btnInserir: TButton;
    btnExcluir: TButton;
    btnSair: TButton;
    btnSalvar: TButton;
    procedure Image1Click(Sender: TObject);
    procedure edCODITE_ITEORCExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edVLRUNI_ITEORCExit(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure edSEQ_ITEORCExit(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarItens;
    function GerarSequencia: Integer;
    procedure CarregarCampos;
  public
    { Public declarations }
  end;

var
  frmITEORC: TfrmITEORC;

implementation

{$R *.dfm}

uses unDM, unConsITE;

procedure TfrmITEORC.btnInserirClick(Sender: TObject);
begin
     
      edSEQ_ITEORC.Text := InttoStr(GerarSequencia);
      edSEQ_ITEORCExit(Self);

      btnInserir.Enabled := False;
      btnSalvar.Enabled := True;
      btnExcluir.Enabled := False;
      btnExcluir.Enabled := True;
end;

procedure TfrmITEORC.CarregarCampos;
begin
    edCODITE_ITEORC.Text := DataModule1.cdsITEORC.FieldByName('CODITE_ITEORC').AsString;
    edVLRUNI_ITEORC.Text := DataModule1.cdsITEORC.FieldByName('VLRUNI_ITEORC').AsString;
    edQTD_ITEORC.Text :=    DataModule1.cdsITEORC.FieldByName('QTD_ITEORC').AsString;
    edVLRUNI_ITEORCExit(Self);
end;

procedure TfrmITEORC.CarregarItens;
begin
     DataModule1.cdsTELASCONSULTA.Close;
     DataModule1.cdsTELASCONSULTA.CommandText := ' select * from iteorc '+
                                                 ' left outer join estite on  codigo_ite = CODITE_ITEORC' +
                                                 ' where seqorc_iteorc = ' + edSEQORC_ITEORC.Text;
     DataModule1.cdsTELASCONSULTA.Open;
end;

procedure TfrmITEORC.edCODITE_ITEORCExit(Sender: TObject);
begin


  with DataModule1.cdsCONSULTA do
     begin
       close;
       CommandText := 'select * from estite where codigo_ite = ' + edCODITE_ITEORC.Text;
       Open;
       if not IsEmpty then
       begin
          edDESCRICAO_ITE.Text := FieldByName('DESCRICAO_ITE').AsString;
          if not ( DataModule1.cdsITEORC.State in [dsInsert,dsEdit]) then
           edVLRUNI_ITEORC.Text := FieldByName('PRECO_ITE').AsString;
       end
       else
           edDESCRICAO_ITE.Text  := 'Item n�o cadastrado';
     end;
end;

procedure TfrmITEORC.edSEQ_ITEORCExit(Sender: TObject);
begin
      DataModule1.cdsITEORC.Close;
      DataModule1.cdsITEORC.CommandText :=  ' select * from iteorc '+
                                                 ' left outer join estite on  codigo_ite = CODITE_ITEORC' +
                                                 ' where seqorc_iteorc = ' + edSEQORC_ITEORC.Text +
                                                 ' and SEQ_ITEORC = ' + edSEQ_ITEORC.Text;
      DataModule1.cdsITEORC.Open;
      if not DataModule1.cdsITEORC.IsEmpty then
      begin

         CarregarCampos;
         DataModule1.cdsITEORC.Edit;
      end
      else
      DataModule1.cdsITEORC.Insert;
end;

procedure TfrmITEORC.edVLRUNI_ITEORCExit(Sender: TObject);
begin
     edVLR_TOTAL.Text :=   CurrtoStr(strtocurr(edQTD_ITEORC.Text) * strtocurr(edVLRUNI_ITEORC.Text));
end;

procedure TfrmITEORC.FormShow(Sender: TObject);
begin
      CarregarItens;
end;

function TfrmITEORC.GerarSequencia: Integer;
begin
      DataModule1.cdsCONSULTA.Close;
      DataModule1.cdsCONSULTA.CommandText := 'select max(SEQ_ITEORC) as seq from iteorc  where seqorc_iteorc = ' + edSEQORC_ITEORC.Text;
      DataModule1.cdsCONSULTA.Open;
      Result := DataModule1.cdsCONSULTA.FieldByName('seq').AsInteger + 1;
end;

procedure TfrmITEORC.Image1Click(Sender: TObject);
begin
   Application.CreateForm(TFrmConsITE,FrmConsITE);
     FrmConsITE.ShowModal;
     if not DataModule1.cdsESTITE.IsEmpty then
     begin
          edCODITE_ITEORC.Text := DataModule1.cdsESTITE.FieldByName('CODIGO_ITE').AsString;
          edCODITE_ITEORCExit(Self);
  //        edSenhaUsuario.SetFocus;
     end;
end;

end.
