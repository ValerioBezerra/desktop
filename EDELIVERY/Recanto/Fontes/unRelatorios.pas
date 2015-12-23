unit unRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ppDesignLayer, ppParameter, ppProd,
  ppClass, ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, ppDBBDE, Vcl.StdCtrls,
  Vcl.ComCtrls, ppPrnabl, ppCtrls, ppBands, ppCache, ppVar;

type
  TfrmRelatorios = class(TForm)
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Button1: TButton;
    Button2: TButton;
    ppBDEPipeline1: TppBDEPipeline;
    ppReport1: TppReport;
    ppReport2: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppParameterList2: TppParameterList;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLine1: TppLine;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    vTotal: TppLabel;
    ppHeaderBand2: TppHeaderBand;
    ppDetailBand2: TppDetailBand;
    ppFooterBand2: TppFooterBand;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorios: TfrmRelatorios;

implementation

{$R *.dfm}

uses unDM;

procedure TfrmRelatorios.Button1Click(Sender: TObject);
var
total : Currency;
begin
   Total := 0;
   DataModule1.cdsTELASCONSULTA.Close;
   DataModule1.cdsTELASCONSULTA.CommandText := 'select * from pedido left outer join cliente on cod_cli = codcli_ped ' +
                                               ' where  data_ped between :data_ini and :data_fim ';
   DataModule1.cdsTELASCONSULTA.Params.ParamByName('Data_INI').AsDate := DateTimePicker1.Date;
   DataModule1.cdsTELASCONSULTA.Params.ParamByName('Data_FIM').AsDate := DateTimePicker2.Date;

   DataModule1.cdsTELASCONSULTA.Open;
   DataModule1.cdsTELASCONSULTA.First;
   while not DataModule1.cdsTELASCONSULTA.Eof do
   begin
     Total := Total + DataModule1.cdsTELASCONSULTA.FieldByName('VALOR_PED').AsCurrency;
     DataModule1.cdsTELASCONSULTA.Next;
   end;
     VTotal.Caption := 'R$' + CurrtoStr(Total);
     ppLabel2.Caption := DatetoStr(DateTimePicker1.Date);
     ppLabel3.Caption := DatetoStr(DateTimePicker2.Date);
     ppReport1.Print;

end;

procedure TfrmRelatorios.FormCreate(Sender: TObject);
begin
   DateTimePicker1.DateTime := now;
   DateTimePicker2.DateTime := now;
end;

end.
