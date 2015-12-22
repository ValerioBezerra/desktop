unit unPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, ppComm, ppRelatv,
  ppProd, ppClass, ppReport, ppDB, ppDBPipe, ppDBBDE, ppDesignLayer, ppParameter,
  ppBands, ppCache, ppCtrls, ppVar, ppPrnabl, Vcl.DBCtrls;

type
  TfrmPedido = class(TForm)
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    edCodUsuario: TEdit;
    Image1: TImage;
    edNomeCli: TEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Memo1: TMemo;
    Image2: TImage;
    Image3: TImage;
    ppReport1: TppReport;
    ppBDEPipeline1: TppBDEPipeline;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppLabel2: TppLabel;
    ppDBText1: TppDBText;
    ppLabel3: TppLabel;
    ppDBText2: TppDBText;
    ppLabel4: TppLabel;
    ppDBText3: TppDBText;
    ppLabel5: TppLabel;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppLine1: TppLine;
    RadioGroup1: TRadioGroup;
    DBLookupComboBox1: TDBLookupComboBox;
    Label2: TLabel;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edCodUsuarioExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    nroPedido :String;
    Impressos : TStringList;
    procedure PrepararPrincipais;
    procedure PrepararAcompanhamentos;
    procedure GerarPedido;
    procedure GravarPedido;
    procedure GravarItemPedido(seqped,codpro:String);
    function RetornarSeqPedido:String;
    procedure ImprimirDireto(Porta, Texto: String);
    procedure GerarItensPedido;
    procedure ImprimirPedido;

    function ItemGravado(codpro:String):Boolean;
    function GravarPagamentoPedido(seq_ped:string): Boolean;
  end;

var
  frmPedido: TfrmPedido;

implementation

{$R *.dfm}

uses unConsCLIENTE, unDM;

procedure TfrmPedido.DBGrid1DblClick(Sender: TObject);
begin
    if nroPedido <> '0' then
    begin
      if ItemGravado(DataModule1.cdsPRODIAP.FieldByName('CODPRO_PRODIA').AsString) then
       begin
          GravarItemPedido(nroPedido,DataModule1.cdsPRODIAP.FieldByName('CODPRO_PRODIA').AsString);

          GerarPedido;
       end
       else
          showmessage('Item j� gravado!');
    end
    else
       Showmessage('Nenhum pedido gerado');
end;

procedure TfrmPedido.DBGrid2DblClick(Sender: TObject);
begin
  if nroPedido <> '0' then
    begin
      if ItemGravado(DataModule1.cdsPRODIAA.FieldByName('CODPRO_PRODIA').AsString) then
       begin
          GravarItemPedido(nroPedido,DataModule1.cdsPRODIAA.FieldByName('CODPRO_PRODIA').AsString);

          GerarPedido;
       end
       else
          showmessage('Item j� gravado!');
    end
    else
       Showmessage('Nenhum pedido gerado');
end;

procedure TfrmPedido.edCodUsuarioExit(Sender: TObject);
begin
             with DataModule1.cdsCONSULTA do
     begin
       close;
       CommandText := 'select * from cliente where cod_cli = ' + edCodUsuario.Text;
       Open;
       if not IsEmpty then
          edNomeCli.Text := FieldByName('NOME_cli').AsString
       else
           edNomeCli.Text  := 'Cliente n�o cadastrado';
     end;
end;

procedure TfrmPedido.FormShow(Sender: TObject);
begin
  DateTimePicker1.DateTime := now;
   PrepararPrincipais;
   PrepararAcompanhamentos;
   nroPedido := '0';
   DataModule1.cdsENT.Open;
   ;
end;

procedure TfrmPedido.GerarItensPedido;
begin
   DataModule1.cdsCONSULTA.Close;
   DataModule1.cdsCONSULTA.CommandText:= 'select * from produto_pedido left outer join produtos on codpro_pxp = cod_pro where seqped_pxp = ' + nroPedido;
   DataModule1.cdsCONSULTA.Open;
   if not DataModule1.cdsCONSULTA.IsEmpty then
   begin
      DataModule1.cdsCONSULTA.First;
      while not DataModule1.cdsCONSULTA.Eof do
      begin

             Memo1.Lines.Add(DataModule1.cdsCONSULTA.FieldByName('NOME_PRO').AsString);


        DataModule1.cdsCONSULTA.Next;
      end;


   end;
end;

procedure TfrmPedido.GerarPedido;
begin
 Memo1.Clear;
 Memo1.Lines.Add('TiaMaluca Marmitaria');
 Memo1.Lines.Add('Nr Pedido:'  + nroPedido);
 Memo1.Lines.Add('Data:' + DatetoStr(DateTimePicker1.Date));
 Memo1.Lines.Add('Cliente: ' + edNomeCli.Text);
 Memo1.Lines.Add('');
 Memo1.Lines.Add('Produtos');
 GerarItensPedido;



end;

procedure TfrmPedido.GravarItemPedido(seqped,codpro:string);
begin
      DataModule1.cdsGRAVAR.Close;
   DataModule1.cdsGRAVAR.CommandText := 'select * from produto_pedido where seqped_pxp = ' + seqped;
   DataModule1.cdsGRAVAR.Open;
   DataModule1.cdsGRAVAR.Insert;
   DataModule1.cdsGRAVAR.FieldByName('seqped_pxp').AsString := seqped;
   DataModule1.cdsGRAVAR.FieldByName('codpro_pxp').AsString := codpro;
   DataModule1.cdsGRAVAR.Post;
   DataModule1.cdsGRAVAR.ApplyUpdates(0);
    DataModule1.Transacao.Commit;

end;

procedure TFrmPedido.ImprimirDireto(Porta, Texto: String);
var
  Impressora: TextFile;
  StringList: TStringList;
  IX: Integer;
begin
  try
    Texto := StringReplace(Texto, '%20', ' ', [rfReplaceAll]);
    StringList := TStringList.Create;
    StringList.Delimiter       := '|';
    StringList.StrictDelimiter := True;
    StringList.DelimitedText   := Texto;

    AssignFile(Impressora, Porta);
    Rewrite(Impressora);
    for IX := 0 to (StringList.Count - 1) do
      Writeln(Impressora, StringList[IX]);
    Writeln(Impressora, '');
    Writeln(Impressora, '');
    Writeln(Impressora, '');
    CloseFile(Impressora);
  finally
    StringList.Free;
  End;

end;

procedure TfrmPedido.ImprimirPedido;
begin
   Datamodule1.cdsRELATORIO.Close;
   DataModule1.cdsRELATORIO.CommandText := ' select * from pedido left outer join produto_pedido on seqped_pxp = seq_ped ' +
                                           ' left outer join produtos on cod_pro = codpro_pxp ' +
                                           '  left outer join cliente on cod_cli = codcli_ped  where seq_ped =' + nroPedido;
   DataModule1.cdsRELATORIO.Open;
   ppReport1.Print;
end;

function TfrmPedido.ItemGravado(codpro: String): Boolean;
begin
    DataModule1.cdsCONSULTA.Close;
    DataModule1.cdsCONSULTA.CommandText := ' select * from produto_pedido where codpro_pxp = ' + codpro + ' and seqped_pxp = ' + nroPedido;
    DataModule1.cdsCONSULTA.Open;
    Result := DataModule1.cdsCONSULTA.IsEmpty;
end;



function TfrmPedido.GravarPagamentoPedido(seq_ped:string): Boolean;
begin
   DataModule1.cdsGRAVAR.Close;
   DataModule1.cdsGRAVAR.CommandText := 'select * from pedido where seq_ped =' + seq_ped;
   DataModule1.cdsGRAVAR.Open;
   DataModule1.cdsGRAVAR.Edit;
   if RadioGroup1.ItemIndex = 0 then
   begin
        DataModule1.cdsGravar.FieldByName('FPAG_PED').AsString := 'V';
        DataModule1.cdsGravar.FieldByName('PAGO_PED').AsInteger := 1;
   end
   else
   begin
          DataModule1.cdsGravar.FieldByName('FPAG_PED').AsString := 'P';
        DataModule1.cdsGravar.FieldByName('PAGO_PED').AsInteger := 0;
   end;


   DataModule1.cdsGRAVAR.Post;
   DataModule1.cdsGRAVAR.ApplyUpdates(0);
   DataModule1.Transacao.Commit;
end;

procedure TfrmPedido.GravarPedido;
begin
   DataModule1.cdsGRAVAR.Close;
   DataModule1.cdsGRAVAR.CommandText := 'select * from pedido';
   DataModule1.cdsGRAVAR.Open;
   DataModule1.cdsGRAVAR.Insert;
   DataModule1.cdsGravar.FieldByName('SEQ_PED').AsString := RetornarSeqPedido;
   nroPedido := DataModule1.cdsGravar.FieldByName('SEQ_PED').AsString;
   DataModule1.cdsGRAVAR.FieldByName('DATA_PED').AsString := (FormatDateTime('dd/MM/yyyy',DateTimePicker1.Date));
   DataModule1.cdsGRAVAR.FieldByName('CODCLI_PED').AsString := edCodUsuario.Text;
   DataModule1.cdsGRAVAR.FieldByName('VALOR_PED').AsCurrency := 8.00;
   DataModule1.cdsGRAVAR.FieldByName('CODENT_PED').AsInteger := DataModule1.cdsENT.FieldByName('COD_ENT').AsInteger;
   DataModule1.cdsGRAVAR.Post;
   DataModule1.cdsGRAVAR.ApplyUpdates(0);
   DataModule1.Transacao.Commit;
end;

procedure TfrmPedido.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
                   Application.CreateForm(TFmrconscliente,Fmrconscliente);
     Fmrconscliente.ShowModal;
     if not DataModule1.cdsCLIENTE.IsEmpty then
     begin
          edCodUsuario.Text := DataModule1.cdsCLIENTE.FieldByName('COD_CLI').AsString;
          edCodUsuarioExit(Self);

     end;
end;




procedure TfrmPedido.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
buttonSelected : Integer;
begin
  if nroPedido <> '0' then
   begin

        buttonSelected := MessageDlg('Finalizar e Imprimir o pedido ?',mtCustom,
                                     [mbYes,mbNo], 0);


         if buttonSelected = mrYes    then
         begin
             GravarPagamentoPedido(nroPedido);
             ImprimirPedido;
           //ImprimirDireto('LPT1',Memo1.Lines.GetText);
           Memo1.Clear;
         end;

   end;
end;

procedure TfrmPedido.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if (edNomeCli.Text = '') or (edNomeCli.Text = 'Cliente n�o cadastrado') then
       showmessage('Informe cliente para gerar pedido!')
   else
   begin
    GravarPedido;
    GerarPedido;
   end;
end;

procedure TfrmPedido.PrepararPrincipais;
begin
  Datamodule1.cdsPRODIAP.Close;
  datamodule1.cdsPRODIAP.CommandText := 'select * from produto_dia left outer join produtos on cod_pro = codpro_prodia ' +
                                        ' where tipo_pro = 1 and data_prodia =' + quotedstr(FormatDateTime('mm/dd/yyyy',DateTimePicker1.Date));

  datamodule1.cdsPRODIAP.Open;

end;

function TfrmPedido.RetornarSeqPedido: String;
begin
    DataModule1.cdsCONSULTA.Close;
    DataModule1.cdsCONSULTA.CommandText := ' select  gen_id(ge_seqped,1) as seq from rdb$database';
    DataModule1.cdsCONSULTA.Open;
    Result := DataModule1.cdsCONSULTA.FieldByName('seq').AsString;
end;

procedure TfrmPedido.PrepararAcompanhamentos;
begin
  Datamodule1.cdsPRODIAA.Close;
  datamodule1.cdsPRODIAA.CommandText := 'select * from produto_dia left outer join produtos on cod_pro = codpro_prodia' +
                                        ' where tipo_pro = 0  and data_prodia =' + quotedstr(FormatDateTime('mm/dd/yyyy',DateTimePicker1.Date));
  datamodule1.cdsPRODIAA.Open;

end;

end.
