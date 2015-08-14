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
    cdsCLIENTECODIGO_CLI: TIntegerField;
    cdsCLIENTENOME_CLI: TWideStringField;
    cdsCLIENTECPF_CLI: TWideStringField;
    cdsCLIENTEIDENTIDADE_CLI: TWideStringField;
    cdsCLIENTEENDERECO_CLI: TWideStringField;
    cdsCLIENTENUMEND_CLI: TWideStringField;
    cdsCLIENTEBAIRRO_CLI: TWideStringField;
    cdsCLIENTEUF_CLI: TWideStringField;
    cdsCLIENTETELEFONE_CLI: TWideStringField;
    cdsCLIENTECELULAR_CLI: TWideStringField;
    cdsCLIENTECIDADE_CLI: TIntegerField;
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
