unit DM_GERENCIADOR;

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBX.IBDatabase, Datasnap.DBClient,
  Datasnap.Provider, IBX.IBCustomDataSet, IBX.IBQuery;

type
  TDM = class(TDataModule)
    Banco: TIBDatabase;
    qryCONSULTA: TIBQuery;
    dspCONSULTA: TDataSetProvider;
    cdsCONSULTA: TClientDataSet;
    dsCONSULTA: TDataSource;
    qryUSUARIO: TIBQuery;
    dspUSUARIO: TDataSetProvider;
    cdsUSUARIO: TClientDataSet;
    dsUSUARIO: TDataSource;
    Transacao: TIBTransaction;
    qryLICENCA: TIBQuery;
    dspLICENCA: TDataSetProvider;
    cdsLICENCA: TClientDataSet;
    dsLICENCA: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
