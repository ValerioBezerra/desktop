unit unRELCLI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ppBands, ppCache, ppClass,
  ppDesignLayer, ppParameter, ppComm, ppRelatv, ppProd, ppReport, ppCtrls,
  ppPrnabl, ppDB, ppDBPipe, ppDBBDE, Vcl.StdCtrls, Vcl.ExtCtrls, ppVar;

type
  TfrmRELCLI = class(TForm)
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
    ppDBText5: TppDBText;
    ppLabel6: TppLabel;
    ppDBText6: TppDBText;
    ppLabel7: TppLabel;
    ppDBText7: TppDBText;
    ppLabel8: TppLabel;
    ppDBText8: TppDBText;
    ppLabel9: TppLabel;
    ppDBText9: TppDBText;
    ppLabel10: TppLabel;
    ppDBText10: TppDBText;
    ppLabel11: TppLabel;
    ppDBText11: TppDBText;
    ppLabel12: TppLabel;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    ppLabel13: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLine1: TppLine;
    ppLine2: TppLine;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRELCLI: TfrmRELCLI;

implementation

{$R *.dfm}

uses unDM;

procedure TfrmRELCLI.Button1Click(Sender: TObject);
begin
   ppReport1.Print;
end;

end.
