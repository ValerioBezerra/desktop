unit DM;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DB, Datasnap.DBClient,
  Datasnap.Provider, Data.SqlExpr, Data.DBXFirebird, IBX.IBCustomDataSet,
  IBX.IBQuery, IBX.IBDatabase,MidasLib;

type
  TDataModule2 = class(TDataModule)
    dspPRO: TDataSetProvider;
    cdsPRO: TClientDataSet;
    dsPRO: TDataSource;
    dspCONSULTA: TDataSetProvider;
    cdsCONSULTA: TClientDataSet;
    dsCONSULTA: TDataSource;
    Banco: TIBDatabase;
    Transacao: TIBTransaction;
    qryPRO: TIBQuery;
    qryCONSULTA: TIBQuery;
    dspGRAVAR: TDataSetProvider;
    cdsGRAVAR: TClientDataSet;
    dsGRAVAR: TDataSource;
    qryGRAVAR: TIBQuery;
    dspPEDIDO: TDataSetProvider;
    cdsPEDIDO: TClientDataSet;
    dsPEDIDO: TDataSource;
    qryPEDIDO: TIBQuery;
    dspPROXPED: TDataSetProvider;
    cdsPROXPED: TClientDataSet;
    dsPROXPED: TDataSource;
    qryPPROXPED: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule2: TDataModule2;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
