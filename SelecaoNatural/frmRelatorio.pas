unit frmRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    RadioGroup2: TRadioGroup;
    Button2: TButton;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    DateTimePicker3: TDateTimePicker;
    Label4: TLabel;
    DateTimePicker4: TDateTimePicker;
    RadioGroup3: TRadioGroup;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function VendasdoDia:String;
     Procedure VendasdoDiaResumo;
    function RetornarProduto(cod:string):string;
    procedure ImprimirPedido;
     function formatarString(texto:string;tamanho:integer):String;
  public
    { Public declarations }
    PedidoFormatado :String;
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses DM;

{ TForm3 }


procedure TForm3.ImprimirPedido;
var
  Impressora: TextFile;
  StringList: TStringList;
  IX: Integer;
begin
  try
    //Texto := StringReplace(Texto, '%20', ' ', [rfReplaceAll]);
    StringList := TStringList.Create;
    StringList.Delimiter       := '|';
    StringList.StrictDelimiter := True;
    StringList.DelimitedText   := PedidoFormatado;

    AssignFile(Impressora, 'LPT1');
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


function TForm3.RetornarProduto(cod: string): string;
begin
   dm.DataModule2.cdsGRAVAR.Close;
   dm.DataModule2.cdsGRAVAR.CommandText := 'select * from produto where cod_produto = ' + cod;
   dm.DataModule2.cdsGRAVAR.Open;
   if dm.DataModule2.cdsGRAVAR.RecordCount > 0 then
      Result := dm.DataModule2.cdsGRAVAR.FieldByName('desc_produto').AsString
   else
      Result := 'Produto n�o encontrado';
end;

function TForm3.VendasdoDia: String;
var
codigo,seqproxped : integer;
total,totalgeral : currency;
begin

      TotalGeral := 0;

     //gravando o pedido
      PedidoFormatado := 'Selec' + chr(198) + 'o Natural|';
      PedidoFormatado := PedidoFormatado + 'Vendas do dia: ' +      vartostr(DateTimePicker1.DateTime) + '|';

      dm.DataModule2.cdsCONSULTA.Close;
      dm.DataModule2.cdsCONSULTA.CommandText := ' select * from PEDIDO where data_pedido =  ' + QuotedStr( FormatDateTime('dd.MM.yyyy',DateTimePicker1.Date));
      dm.DataModule2.cdsCONSULTA.Open;
      dm.DataModule2.cdsCONSULTA.First;
      while not dm.DataModule2.cdsCONSULTA.Eof do
      begin

              PedidoFormatado := PedidoFormatado + '|Pedido: ' + dm.DataModule2.cdsCONSULTA.FieldByName('cod_pedido').AsString +  '||';

              PedidoFormatado := PedidoFormatado + 'Produto             Qtde    VlrUni   VlrTotal|';
             //gravando os itens do pedido
                dm.DataModule2.cdsPROXPED.Close;
                dm.DataModule2.cdsPROXPED.CommandText := ' select * from proxped where cod_pedido = ' + dm.DataModule2.cdsCONSULTA.FieldByName('cod_pedido').AsString;
                dm.DataModule2.cdsPROXPED.Open;
                 dm.DataModule2.cdsPROXPED.First;
                while not dm.DataModule2.cdsPROXPED.Eof do
                begin
                 Total := 0;
                  PedidoFormatado := PedidoFormatado + formatarString(RetornarProduto(dm.DataModule2.cdsPROXPED.FieldByName('codproduto_proxped').AsString),20);
                  PedidoFormatado := PedidoFormatado + formatarString(dm.DataModule2.cdsPROXPED.FieldByName('qtd_proxped').AsString,8);
                  PedidoFormatado := PedidoFormatado + formatarString(dm.DataModule2.cdsPROXPED.FieldByName('VLRUNI_PROXPED').AsString,10);
                  PedidoFormatado := PedidoFormatado + formatarString(vartostr(dm.DataModule2.cdsPROXPED.FieldByName('VLRUNI_PROXPED').AsFloat *
                                                                      dm.DataModule2.cdsPROXPED.FieldByName('qtd_proxped').AsFloat),10);
                  Total := Total + (dm.DataModule2.cdsPROXPED.FieldByName('VLRUNI_PROXPED').AsFloat *
                                                                      dm.DataModule2.cdsPROXPED.FieldByName('qtd_proxped').AsFloat);
                   PedidoFormatado := PedidoFormatado + '|';
                   TotalGeral := TotalGeral + Total;
                  dm.DataModule2.cdsPROXPED.Next;

                end;
                PedidoFormatado := PedidoFormatado + '|Total:  R$'  + formatarString(VartoStr(Total),37);
                PedidoFormatado := PedidoFormatado + '||';
                dm.DataModule2.cdsCONSULTA.Next;
      end;
        PedidoFormatado := PedidoFormatado + '|';
        PedidoFormatado := PedidoFormatado + formatarString('Total do Dia : R$ ' + VartoStr(TotalGeral),37);
        PedidoFormatado := PedidoFormatado + '||||||';
        ImprimirPedido;




end;

procedure TForm3.VendasdoDiaResumo;
var
codigo,seqproxped : integer;
total,totalgeral : currency;
begin

      TotalGeral := 0;

     //gravando o pedido
      PedidoFormatado := 'Selec' + chr(198) + 'o Natural|';
      PedidoFormatado := PedidoFormatado + 'Vendas do dia: ' +      vartostr(DateTimePicker1.DateTime) + '|';

      dm.DataModule2.cdsCONSULTA.Close;
      dm.DataModule2.cdsCONSULTA.CommandText := ' select * from PEDIDO where data_pedido =  ' + QuotedStr( FormatDateTime('dd.MM.yyyy',DateTimePicker1.Date));
      dm.DataModule2.cdsCONSULTA.Open;
      dm.DataModule2.cdsCONSULTA.First;
      while not dm.DataModule2.cdsCONSULTA.Eof do
      begin

              PedidoFormatado := PedidoFormatado + '|' + FormatarString('Pedido: ' + dm.DataModule2.cdsCONSULTA.FieldByName('cod_pedido').AsString,20);


             //gravando os itens do pedido
                dm.DataModule2.cdsPROXPED.Close;
                dm.DataModule2.cdsPROXPED.CommandText := ' select * from proxped where cod_pedido = ' + dm.DataModule2.cdsCONSULTA.FieldByName('cod_pedido').AsString;
                dm.DataModule2.cdsPROXPED.Open;
                 dm.DataModule2.cdsPROXPED.First;
                 Total := 0;
                while not dm.DataModule2.cdsPROXPED.Eof do
                begin

                  Total := Total + (dm.DataModule2.cdsPROXPED.FieldByName('VLRUNI_PROXPED').AsFloat *
                                                                      dm.DataModule2.cdsPROXPED.FieldByName('qtd_proxped').AsFloat);


                  dm.DataModule2.cdsPROXPED.Next;

                end;
                TotalGeral := TotalGeral + Total;
                PedidoFormatado := PedidoFormatado  + FormatarString('R$'  + VartoStr(Total),17);

                dm.DataModule2.cdsCONSULTA.Next;
      end;
        PedidoFormatado := PedidoFormatado + '||';
        PedidoFormatado := PedidoFormatado + formatarString('Total do Dia: R$ ' + VartoStr(TotalGeral),37);
        PedidoFormatado := PedidoFormatado + '||||||';
        ImprimirPedido;



end;

procedure TForm3.Button1Click(Sender: TObject);
begin
        if RadioGroup1.ItemIndex = 0 then
            VendasdoDia
        else
             VendasdoDiaResumo;
end;

function TForm3.formatarString(texto: string; tamanho: integer): String;
begin

      if length(texto) < tamanho then
          begin
              while length(texto) <> tamanho do
                    texto := texto + ' ';
          end
          else if length(texto) > tamanho then
          begin
            Texto := Copy(Texto,0,tamanho);
          end;

     Result := texto;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
    DateTimePicker1.DateTime := now;
end;

end.
