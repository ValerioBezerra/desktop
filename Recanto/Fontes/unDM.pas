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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
