unit unDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  Datasnap.Provider, IBX.IBCustomDataSet, IBX.IBQuery, IBX.IBDatabase;

type
  TDataModule1 = class(TDataModule)
    Banco: TIBDatabase;
    Transacao: TIBTransaction;
    qryUSUARIO: TIBQuery;
    dspUSUARIO: TDataSetProvider;
    cdsUSUARIO: TClientDataSet;
    dsUSUARIO: TDataSource;
    qryCONSULTA: TIBQuery;
    dspCONSULTA: TDataSetProvider;
    cdsCONSULTA: TClientDataSet;
    dsCONSULTA: TDataSource;
    qryCLIENTE: TIBQuery;
    dspCLIENTE: TDataSetProvider;
    cdsCLIENTE: TClientDataSet;
    dsCLIENTE: TDataSource;
    qryTELASCONSULTA: TIBQuery;
    dspTELASCONSULTA: TDataSetProvider;
    cdsTELASCONSULTA: TClientDataSet;
    dsTELASCONSULTA: TDataSource;
    cdsCLIENTECOD_CLI: TIntegerField;
    cdsCLIENTENOME_CLI: TWideStringField;
    cdsCLIENTETEL_CLI: TWideStringField;
    cdsCLIENTECEL_CLI: TWideStringField;
    cdsCLIENTEENDERECO: TWideStringField;
    cdsCLIENTEBAIRRO: TWideStringField;
    qryPRO: TIBQuery;
    dspPRO: TDataSetProvider;
    cdsPRO: TClientDataSet;
    dsPRO: TDataSource;
    cdsPROCOD_PRO: TIntegerField;
    cdsPRONOME_PRO: TWideStringField;
    cdsPROTIPO_PRO: TIntegerField;
    qryENT: TIBQuery;
    dspENT: TDataSetProvider;
    cdsENT: TClientDataSet;
    dsENT: TDataSource;
    qryPRODIAP: TIBQuery;
    dspPRODIAP: TDataSetProvider;
    cdsPRODIAP: TClientDataSet;
    dsPRODIAP: TDataSource;
    cdsPRODIAA: TClientDataSet;
    dsPRODIAA: TDataSource;
    dspPRODIAA: TDataSetProvider;
    qryPRODIAA: TIBQuery;
    qryGravar: TIBQuery;
    dspGRAVAR: TDataSetProvider;
    cdsGRAVAR: TClientDataSet;
    dsGRAVAR: TDataSource;
    qryRELATORIO: TIBQuery;
    dspRELATORIO: TDataSetProvider;
    cdsRELATORIO: TClientDataSet;
    dsRELATORIO: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure iniciarClientDataSet(cds: TClientDataSet);
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.iniciarClientDataSet(cds: TClientDataSet);
var i: integer;
begin
  for i := 0 to cds.FieldCount - 1 do
      begin
         if (cds.Fields[i].DataType = ftFixedChar)  or
            (cds.Fields[i].DataType = ftWideString) or
            (cds.Fields[i].DataType = ftString)     or
            (cds.Fields[i].DataType = ftBlob)       or
            (cds.Fields[i].DataType = ftMemo) then
             cds.Fields[i].Value := '';

         if (cds.Fields[i].DataType = ftInteger)  or
            (cds.Fields[i].DataType = ftFloat)    or
            (cds.Fields[i].DataType = ftSmallint) or
            (cds.Fields[i].DataType = ftLargeInt) or
            (cds.Fields[i].DataType = ftCurrency) or
            (cds.Fields[i].DataType = ftbcd) then
             cds.Fields[i].Asfloat := 0;
      end;
end;


{ TDataModule1 }


end.
