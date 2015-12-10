unit unRELPREVREC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ppBands, ppCache, ppClass,
  ppDesignLayer, ppParameter, ppComm, ppRelatv, ppProd, ppReport, ppCtrls,
  ppPrnabl, ppDB, ppDBPipe, ppDBBDE, Vcl.StdCtrls, Vcl.ExtCtrls, ppVar,DBClient,
  Vcl.ComCtrls;

type
  TfrmRELPREVREC = class(TForm)
    ppReport1: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppBDEPipeline1: TppBDEPipeline;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppLabel4: TppLabel;
    ppDBText4: TppDBText;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppDBText6: TppDBText;
    ppLabel7: TppLabel;
    ppDBText7: TppDBText;
    ppLabel8: TppLabel;
    ppDBText8: TppDBText;
    ppLabel12: TppLabel;
    rdgOpcao: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    ppLabel13: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLine1: TppLine;
    ppLine2: TppLine;
    rdgFormato: TRadioGroup;
    ppReport2: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppLine3: TppLine;
    ppDetailBand2: TppDetailBand;
    ppLabel16: TppLabel;
    ppDBText12: TppDBText;
    ppLabel17: TppLabel;
    ppDBText13: TppDBText;
    ppFooterBand2: TppFooterBand;
    ppDesignLayers2: TppDesignLayers;
    ppDesignLayer2: TppDesignLayer;
    ppParameterList2: TppParameterList;
    ppLine5: TppLine;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    varTotal: TppVariable;
    ppLabel20: TppLabel;
    ppLabel9: TppLabel;
    varTotalAnalitico: TppVariable;
    lblOrigem: TppLabel;
    ppLine4: TppLine;
    ppLine6: TppLine;
    ppLabel10: TppLabel;
    varDataInicial: TppVariable;
    ppLabel11: TppLabel;
    varDataFinal: TppVariable;
    ppLabel21: TppLabel;
    varDataInicialAnalitico: TppVariable;
    ppLabel22: TppLabel;
    varDataFinalAnalitico: TppVariable;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ppDetailBand2AfterPrint(Sender: TObject);
    procedure ppDetailBand1AfterPrint(Sender: TObject);
    procedure ppDetailBand1BeforePrint(Sender: TObject);
    procedure ppFooterBand2BeforePrint(Sender: TObject);
    procedure ppFooterBand1BeforePrint(Sender: TObject);
  private
    { Private declarations }

    procedure prepararSQL;
  public
    { Public declarations }
    cdspadrao : TClientDataSet;
  end;

var
  frmRELPREVREC: TfrmRELPREVREC;

implementation

{$R *.dfm}

uses unDM;

procedure TfrmRELPREVREC.Button1Click(Sender: TObject);
begin
   prepararSQL;
    if rdgFormato.ItemIndex = 0 then
       ppReport1.Print
    else
       ppReport2.Print;
end;

procedure TfrmRELPREVREC.Button2Click(Sender: TObject);
begin
   Close;
end;

procedure TfrmRELPREVREC.FormCreate(Sender: TObject);
begin
    cdspadrao := DataModule1.cdsRECTIT;
end;

procedure TfrmRELPREVREC.ppDetailBand1AfterPrint(Sender: TObject);
begin
    varTotalAnalitico.Value := varTotalAnalitico.Value + cdspadrao.FieldByName('VALORABERTO').AsCurrency;
end;

procedure TfrmRELPREVREC.ppDetailBand1BeforePrint(Sender: TObject);
begin
   if cdspadrao.FieldByName('ORIGEM_RECTIT').AsInteger = 0 then
       lblOrigem.Caption := 'Digitado'
   else
       lblOrigem.Caption := 'Gerado';

end;

procedure TfrmRELPREVREC.ppDetailBand2AfterPrint(Sender: TObject);
begin
      varTotal.Value := varTotal.Value + cdspadrao.FieldByName('VALORABERTO').AsCurrency;
end;

procedure TfrmRELPREVREC.ppFooterBand1BeforePrint(Sender: TObject);
begin
     varDataInicialAnalitico.Value := DateTimePicker1.Date;
   varDataFinalAnalitico.Value := DateTimePicker2.Date;
end;

procedure TfrmRELPREVREC.ppFooterBand2BeforePrint(Sender: TObject);
begin
   varDatainicial.Value := DateTimePicker1.Date;
   varDataFinal.Value := DateTimePicker2.Date;
end;

procedure TfrmRELPREVREC.prepararSQL;
var
where :String;
begin
    varTotal.Value := 0;
    cdspadrao.Close;
    cdspadrao.CommandText := ' select SEQ_RECTIT, ORIGEM_RECTIT,DATAEMISSAO_RECTIT,DATAVENC_RECTIT,VALORTOTAL_RECTIT,NOME_CLI,' +
                             ' VALORPAGO_RECTIT, CODCLI_RECTIT,(VALORTOTAL_RECTIT - VALORPAGO_RECTIT) AS VALORABERTO from RECTIT' +
                              ' LEFT OUTER JOIN CLIENTE ON CODIGO_CLI = CODCLI_RECTIT where 1=1';
      if DateTimePicker1.Date > DateTimePicker2.Date then
          begin
                 showmessage('Data Inicial não pode ser maior que Data Final!');
                 Exit;
          end
          else
          begin

          if rdgOpcao.ItemIndex = 0 then
              where := where + 'and DATAEMISSAO_RECTIT between ' +  QuotedStr(StringReplace((DatetoStr(DateTimePicker1.Date)),'/','.', [rfReplaceAll, rfIgnoreCase])) + 'and ' + QuotedStr(StringReplace((DatetoStr(DateTimePicker2.Date)),'/','.', [rfReplaceAll, rfIgnoreCase]))
          else
              where := where + 'and DATAVENC_RECTIT between ' + QuotedStr(StringReplace((DatetoStr(DateTimePicker1.Date)),'/','.', [rfReplaceAll, rfIgnoreCase])) + 'and ' + QuotedStr(StringReplace((DatetoStr(DateTimePicker2.Date)),'/','.', [rfReplaceAll, rfIgnoreCase]));
          end;

             where := where + 'and VALORPAGO_RECTIT <> VALORTOTAL_RECTIT ';

             cdspadrao.CommandText := cdspadrao.CommandText + where;

    cdspadrao.Open;

 

end;

end.
