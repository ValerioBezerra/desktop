unit uSMKingGeral;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, Data.DB,
  FireDAC.Comp.Client, Dialogs, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Datasnap.Provider, FireDAC.Comp.DataSet,
  FireDAC.Phys.IBBase, uParametro, Datasnap.DBClient;

type
  TSMKingGeral = class(TDSServerModule)
    FDConnection: TFDConnection;
    fdqConsulta: TFDQuery;
    dspConsulta: TDataSetProvider;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    fdqGER_PAI: TFDQuery;
    dspGER_PAI: TDataSetProvider;
    fdqGER_EST: TFDQuery;
    dspGER_EST: TDataSetProvider;
    fdqGER_CID: TFDQuery;
    dspGER_CID: TDataSetProvider;
    fdqGER_BAI: TFDQuery;
    dspGER_BAI: TDataSetProvider;
    fdqGER_TLG: TFDQuery;
    dspGER_TLG: TDataSetProvider;
    fdqGER_LOG: TFDQuery;
    dspGER_LOG: TDataSetProvider;
    fdqGER_EMP: TFDQuery;
    dspGER_EMP: TDataSetProvider;
    fdqGER_TPP: TFDQuery;
    dspGER_TPP: TDataSetProvider;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
    cdsTestarDados: TClientDataSet;
    function Consultar(Tabela, Where: String): Boolean;
    function TestarGER_PAI(Parametro: TParametro): String;
    function TestarGER_EST(Parametro: TParametro): String;
    function TestarGER_CID(Parametro: TParametro): String;
    function TestarGER_BAI(Parametro: TParametro): String;
    function TestarGER_TLG(Parametro: TParametro): String;
    function TestarGER_LOG(Parametro: TParametro): String;
    function TestarGER_TPP(Parametro: TParametro): String;
  public
    { Public declarations }
    function TestarDados(Parametro: TParametro; Dados: OleVariant): String;
    procedure StartTransaction;
    procedure Commit;
    procedure RollBack;
  end;

implementation


{$R *.dfm}


uses System.StrUtils, uConfiguracao;

procedure TSMKingGeral.Commit;
begin
  if (FDConnection.InTransaction) then
    FDConnection.Commit;
end;

function TSMKingGeral.Consultar(Tabela, Where: String): Boolean;
begin
  fdqConsulta.Close;
  fdqConsulta.Open('SELECT * FROM ' + Tabela + ' ' + Where);

  Result := not(fdqConsulta.IsEmpty);
end;

procedure TSMKingGeral.DSServerModuleCreate(Sender: TObject);
var
  Configuracao: TConfiguracao;
begin
  Configuracao := TConfiguracao.Create;

  FDConnection.Close;
  FDConnection.Params.Values['DriverID']  := 'FB';
  FDConnection.Params.Values['Database']  := Configuracao.DataBase;
  FDConnection.Params.Values['User_Name'] := 'SYSDBA';
  FDConnection.Params.Values['Password']  := 'masterkey';
  FDConnection.Params.Values['Protocol']  := 'TCPIP';
  FDConnection.Params.Values['Server']    := Configuracao.Server;
  FDPhysFBDriverLink.VendorLib            := Configuracao.VendorLib;
end;

procedure TSMKingGeral.RollBack;
begin
  if (FDConnection.InTransaction) then
    FDConnection.Rollback;
end;

procedure TSMKingGeral.StartTransaction;
begin
  FDConnection.StartTransaction;
end;

function TSMKingGeral.TestarDados(Parametro: TParametro; Dados: OleVariant): String;
begin
  cdsTestarDados := TClientDataSet.Create(Self);
  cdsTestarDados.Data := Dados;

  if (Parametro.Tabela = 'GER_PAI') then
    Result := TestarGER_PAI(Parametro);
  if (Parametro.Tabela = 'GER_EST') then
    Result := TestarGER_EST(Parametro);
  if (Parametro.Tabela = 'GER_CID') then
    Result := TestarGER_CID(Parametro);
  if (Parametro.Tabela = 'GER_BAI') then
    Result := TestarGER_BAI(Parametro);
  if (Parametro.Tabela = 'GER_TLG') then
    Result := TestarGER_TLG(Parametro);
end;

function TSMKingGeral.TestarGER_BAI(Parametro: TParametro): String;
var
  Retorno: String;
  Separador: String;
begin
  Retorno   := '';
  Separador := '';

  if (Parametro.Operacao <> 'D') then
    begin
      if (Trim(cdsTestarDados.FieldByName('GER_NOME_BAI').AsString) = '') then
        begin
          Retorno   := Retorno + Separador + ' - Nome não preenchido.';
          Separador := #13;
        end;

      if not(Consultar('GER_CID', 'WHERE GER_ID_CID = ' + IntToStr(cdsTestarDados.FieldByName('GER_GERCID_BAI').AsInteger))) then
        begin
          Retorno   := Retorno + Separador + ' - Cidade não cadastrada.';
          Separador := #13;
        end;
    end
  else
    begin
      if (Consultar('GER_LOG', 'WHERE GER_GERBAI_LOG = ' + IntToStr(cdsTestarDados.FieldByName('GER_ID_BAI').AsInteger))) then
        begin
          Retorno   := Retorno + Separador + ' - Há logradouro(s) cadastrado(s) com este bairro.';
          Separador := #13;
        end;
    end;

  Result := Retorno;
end;

function TSMKingGeral.TestarGER_CID(Parametro: TParametro): String;
var
  Retorno: String;
  Separador: String;
begin
  Retorno   := '';
  Separador := '';

  if (Parametro.Operacao <> 'D') then
    begin
      if (Trim(cdsTestarDados.FieldByName('GER_NOME_CID').AsString) = '') then
        begin
          Retorno   := Retorno + Separador + ' - Nome não preenchido.';
          Separador := #13;
        end;

      if not(Consultar('GER_EST', 'WHERE GER_ID_EST = ' + IntToStr(cdsTestarDados.FieldByName('GER_GEREST_CID').AsInteger))) then
        begin
          Retorno   := Retorno + Separador + ' - Estado não cadastrado.';
          Separador := #13;
        end;
    end
  else
    begin
      if (Consultar('GER_BAI', 'WHERE GER_GERCID_BAI = ' + IntToStr(cdsTestarDados.FieldByName('GER_ID_CID').AsInteger))) then
        begin
          Retorno   := Retorno + Separador + ' - Há bairro(s) cadastrado(s) com esta cidade.';
          Separador := #13;
        end;
    end;

  Result := Retorno;
end;

function TSMKingGeral.TestarGER_EST(Parametro: TParametro): String;
var
  Retorno: String;
  Separador: String;
begin
  Retorno   := '';
  Separador := '';

  if (Parametro.Operacao <> 'D') then
    begin
      if (Trim(cdsTestarDados.FieldByName('GER_NOME_EST').AsString) = '') then
        begin
          Retorno   := Retorno + Separador + ' - Nome não preenchido.';
          Separador := #13;
        end;

      if (Trim(cdsTestarDados.FieldByName('GER_UF_EST').AsString) <> '') then
        begin
          if (Consultar('GER_EST', 'WHERE GER_ID_EST <> ' + IntToStr(cdsTestarDados.FieldByName('GER_ID_EST').AsInteger) +
                                   '  AND GER_GERPAI_EST = ' + IntToStr(cdsTestarDados.FieldByName('GER_GERPAI_EST').AsInteger) +
                                   '  AND GER_UF_EST = ' + QuotedStr(cdsTestarDados.FieldByName('GER_UF_EST').AsString))) then
            begin
              Retorno   := Retorno + Separador + ' - UF já cadastrada para outro estado.';
              Separador := #13;
            end;
        end;

      if not(Consultar('GER_PAI', 'WHERE GER_ID_PAI = ' + IntToStr(cdsTestarDados.FieldByName('GER_GERPAI_EST').AsInteger))) then
        begin
          Retorno   := Retorno + Separador + ' - País não cadastrado.';
          Separador := #13;
        end;
    end
  else
    begin
      if (Consultar('GER_CID', 'WHERE GER_GEREST_CID = ' + IntToStr(cdsTestarDados.FieldByName('GER_ID_EST').AsInteger))) then
        begin
          Retorno   := Retorno + Separador + ' - Há cidade(s) cadastrada(s) com este estado.';
          Separador := #13;
        end;
    end;

  Result := Retorno;
end;

function TSMKingGeral.TestarGER_LOG(Parametro: TParametro): String;
var
  Retorno: String;
  Separador: String;
begin
  Retorno   := '';
  Separador := '';

  if (Parametro.Operacao <> 'D') then
    begin
      if (Trim(cdsTestarDados.FieldByName('GER_CEP_LOG').AsString) = '') then
        begin
          Retorno   := Retorno + Separador + ' - CEP não preenchido.';
          Separador := #13;
        end;
      if (Trim(cdsTestarDados.FieldByName('GER_LOGRADOURO_LOG').AsString) = '') then
        begin
          Retorno   := Retorno + Separador + ' - Logradouro não preenchido.';
          Separador := #13;
        end;
      if not(Consultar('GER_TLG', 'WHERE GER_ID_TLG = ' + IntToStr(cdsTestarDados.FieldByName('GER_GERTLG_LOG').AsInteger))) then
        begin
          Retorno   := Retorno + Separador + ' - Tipo de Logradouro não cadastrada.';
          Separador := #13;
        end;
      if not(Consultar('GER_BAI', 'WHERE GER_ID_BAI = ' + IntToStr(cdsTestarDados.FieldByName('GER_GERBAI_LOG').AsInteger))) then
        begin
          Retorno   := Retorno + Separador + ' - Bairro não cadastrada.';
          Separador := #13;
        end;
    end
  else
    begin

    end;

  Result := Retorno;


end;

function TSMKingGeral.TestarGER_PAI(Parametro: TParametro): String;
var
  Retorno: String;
  Separador: String;
begin
  Retorno   := '';
  Separador := '';

  if (Parametro.Operacao <> 'D') then
    begin
      if (Trim(cdsTestarDados.FieldByName('GER_NOME_PAI').AsString) = '') then
        begin
          Retorno   := Retorno + Separador + ' - Nome não preenchido.';
          Separador := #13;
        end;
    end
  else
    begin
      if (Consultar('GER_EST', 'WHERE GER_GERPAI_EST = ' + IntToStr(cdsTestarDados.FieldByName('GER_ID_PAI').AsInteger))) then
        begin
          Retorno   := Retorno + Separador + ' - Há estado(s) cadastrado(s) com este país.';
          Separador := #13;
        end;
    end;

  Result := Retorno;
end;

function TSMKingGeral.TestarGER_TLG(Parametro: TParametro): String;
var
  Retorno: String;
  Separador: String;
begin
  Retorno   := '';
  Separador := '';

  if (Parametro.Operacao <> 'D') then
    begin
      if (Trim(cdsTestarDados.FieldByName('GER_DESCRICAO_TLG').AsString) = '') then
        begin
          Retorno   := Retorno + Separador + ' - Descrição não preenchida.';
          Separador := #13;
        end;


    end
  else
    begin
      if (Consultar('GER_LOG', 'WHERE GER_GERTLG_LOG = ' + IntToStr(cdsTestarDados.FieldByName('GER_ID_TLG').AsInteger))) then
        begin
          Retorno   := Retorno + Separador + ' - Há logradouro(s) cadastrado(s) com este tipo.';
          Separador := #13;
        end;
    end;

  Result := Retorno;


end;

function TSMKingGeral.TestarGER_TPP(Parametro: TParametro): String;
var
  Retorno: String;
  Separador: String;
begin
  Retorno   := '';
  Separador := '';

  if (Parametro.Operacao <> 'D') then
    begin
      if (Trim(cdsTestarDados.FieldByName('GER_DESCRICAO_TPP').AsString) = '') then
        begin
          Retorno   := Retorno + Separador + ' - Descrição não preenchida.';
          Separador := #13;
        end;


    end
  else
    begin
        if (Consultar('GER_PXT', 'WHERE GER_GERTPP_PXT = ' + IntToStr(cdsTestarDados.FieldByName('GER_ID_TPP').AsInteger))) then
        begin
          Retorno   := Retorno + Separador + ' - Existem Pessoas cadastradas com essse tipo.';
          Separador := #13;
        end;
    end;

  Result := Retorno;

end;

end.

