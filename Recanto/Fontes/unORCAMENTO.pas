unit unORCAMENTO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmORCAMENTO = class(TForm)
    edSEQ_ORC: TEdit;
    Label1: TLabel;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label3: TLabel;
    edTotalProdutos: TEdit;
    edTotalTerapias: TEdit;
    edTotalGeral: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Image2: TImage;
    edNomeCli: TEdit;
    btIncluir: TButton;
    btSalvar: TButton;
    btExcluir: TButton;
    btSair: TButton;
    procedure DBEdit1Exit(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure edSEQ_ORCExit(Sender: TObject);
  private
    { Private declarations }
    TotalItens,TotalTerapias: Currency;
    procedure CalcularTotalItens;
    procedure CalcularTotalTerapias;
  public
    { Public declarations }
  end;

var
  frmORCAMENTO: TfrmORCAMENTO;

implementation

{$R *.dfm}

uses unDM, unConsCLIENTE;

procedure TfrmORCAMENTO.CalcularTotalItens;
begin
      TotalItens := 0;
      DataModule1.cdsITEORC.Close;
      DataModule1.cdsITEORC.CommandText := 'select * from iteorc where SEQORC_ITEORC = ' + edSeq_orc.Text;
      DataModule1.cdsITEORC.Open;
      if not DataModule1.cdsITEORC.IsEmpty then
      begin
        DataModule1.cdsITEORC.First;
        while not DataModule1.cdsITEORC.Eof do
        begin
            TotalItens := TotalItens + (DataModule1.cdsITEORC.FieldByName('QTD_ITEORC').AsCurrency *
                                        DataModule1.cdsITEORC.FieldByName('VLRUNI_ITEORC').AsCurrency);
            DataModule1.cdsITEORC.Next;
        end;

      end;
     edTotalProdutos.Text := CurrToStr(TotalItens);

end;

procedure TfrmORCAMENTO.CalcularTotalTerapias;
begin
      TotalTerapias := 0;
      DataModule1.cdsTERORC.Close;
      DataModule1.cdsTERORC.CommandText := 'select * from teRorc where SEQORC_TERORC = ' + edSeq_orc.Text;
      DataModule1.cdsTERORC.Open;
      if not DataModule1.cdsTERORC.IsEmpty then
      begin
        DataModule1.cdsTERORC.First;
        while not DataModule1.cdsTERORC.Eof do
        begin
            TotalTerapias := TotalTerapias + (DataModule1.cdsTERORC.FieldByName('QTD_TERORC').AsCurrency *
                                        DataModule1.cdsTERORC.FieldByName('VLRUNI_TERORC').AsCurrency);
            DataModule1.cdsTERORC.Next;
        end;

      end;
     edTotalTerapias.Text :=  CurrToStr(TotalTerapias);

end;

procedure TfrmORCAMENTO.DBEdit1Exit(Sender: TObject);
begin
      DataModule1.cdsCONSULTA.Close;
      DataModule1.cdsCONSULTA.CommandText := 'select * from cliente where codigo_cli = ' + DBEdit1.Text;
      DataModule1.cdsCONSULTA.Open;
      if not DataModule1.cdsCONSULTA.IsEmpty then
         edNomeCli.Text := DataModule1.cdsCONSULTA.FieldByName('nome_cli').AsString
      else
         edNomeCli.Text := 'Cliente n�o cadastrado';
end;

procedure TfrmORCAMENTO.edSEQ_ORCExit(Sender: TObject);
begin
     if edSeq_ORC.Text <> '0' then
     begin
       DataModule1.cdsORCAMENTO.Close;
       DataModule1.cdsORCAMENTO.CommandText := 'select * from ORCAMENTO where seq_orc = ' + edSEQ_ORC.Text;
       Datamodule1.cdsORCAMENTO.Open;
       if not DataModule1.cdsORCAMENTO.IsEmpty then
       begin
         DateTimePicker1.Date := DataModule1.cdsORCAMENTO.FieldByName('DATA_ORC').AsDateTime;
         DBEdit1Exit(Self);
         CalcularTotalItens;
         CalcularTotalTerapias;
         edTotalGeral.Text :=  CurrToStr(TotalTerapias + TotalItens);
       end;
     end;
end;

procedure TfrmORCAMENTO.Image2Click(Sender: TObject);
begin
     Application.CreateForm(TfmrConsCLIENTE,fmrConsCLIENTE);
     fmrConsCLIENTE.ShowModal;
     if not DataModule1.cdsCLIENTE.IsEmpty then
     begin
          dbedit1.Text := DataModule1.cdsCLIENTE.FieldByName('CODIGO_CLI').AsString;
          dbedit1Exit(Self);
        //  edSenhaUsuario.SetFocus;
     end;

end;

end.
