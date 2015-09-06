unit frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP,System.IniFiles,declaracoes, Vcl.StdCtrls,System.JSON,
  Vcl.ExtCtrls, Vcl.AppEvnts;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ApplicationEvents1: TApplicationEvents;
    Timer: TTimer;
    function CarregarPedidos:integer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    CodEmpresa: String;
    Dominio: String;

    PortaCozinha: String;
    FabCozinha: String;
    ModeloCozinha: String;
    SomanteProdutosCozinha: String;

    PortaBalcao: String;
    FabBalcao: String;
    ModeloBalcao: String;
    SomanteProdutosBalcao: String;
    Minimizar: Boolean;

    function  LerConfiguracoes:Boolean;
    procedure ConfigurarImpressoraBalcao;
    procedure ConfigurarImpressoraCozinha;
    procedure ArmazenarDados(Dados: TStringStream);
    procedure Imprimir(Fabricante, Porta, Texto: String);
    procedure ImprimirBematech(Texto: String);
    procedure ImprimirDireto(Porta, Texto: String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.ApplicationEvents1Activate(Sender: TObject);
begin
  if (Minimizar) then
    begin
      Hide();
      WindowState       := wsMinimized;
      TrayIcon1.Visible := True;
      Minimizar         := False;
    end;
end;

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide();
  WindowState       := wsMinimized;
  TrayIcon1.Visible := True;
end;

procedure TForm1.ArmazenarDados(Dados:TStringStream);
var
  jsonObj, jSubObj: TJSONObject;
  ja: TJSONArray;
  jp, jSubPar: TJSONPair;
  i, j: integer;
  ImprimeBalcao, ImprimeCozinha: Boolean;
  CabecalhoED, Cabecalho, Produtos, Rodape: String;
begin
  jsonObj := TJsonObject.Create;
  jsonObj.Parse (Dados.Bytes, 0);

  jp := TJSONPair.Create;
  jp := jsonObj.Get(0);
  ja := TJSONArray.Create;
  ja := (jp.JsonValue as TJSONArray);
  jSubObj:= TJSONObject.Create;
  jSubPar := TJSONPair.Create;
  ImprimeBalcao  := False;
  ImprimeCozinha := True;

  for i := 0 to ja.Size - 1 do
    begin
      jSubObj := (ja.Get(i) as TJSONObject);
        for j := 0 to jSubObj.Size - 1 do
          begin
             jSubPar := jSubObj.Get(j);

             case (j) of
               0: ImprimeBalcao  := (jSubPar.JsonValue.Value = '1');
               1: ImprimeCozinha := (jSubPar.JsonValue.Value = '1');
               2: CabecalhoED    := (jSubPar.JsonValue.Value);
               3: Cabecalho      := (jSubPar.JsonValue.Value);
               4: Produtos       := (jSubPar.JsonValue.Value);
               5: Rodape         := (jSubPar.JsonValue.Value);
             end;
          end;

        if (ImprimeBalcao) then
          begin
            if (Trim(PortaBalcao) <> '') then
              begin
                ConfigurarImpressoraBalcao;
                if (SomanteProdutosBalcao = 'S') then
                  Imprimir(FabBalcao, PortaBalcao, CabecalhoED + Produtos + '||||||||||||')
                else
                  Imprimir(FabBalcao, PortaBalcao, CabecalhoED + Cabecalho + Produtos + Rodape);
              end;
          end;

        if (ImprimeCozinha) then
          begin
            if (Trim(PortaCozinha) <> '') then
              begin
                ConfigurarImpressoraCozinha;
                if (SomanteProdutosCozinha = 'S') then
                  Imprimir(FabCozinha, PortaCozinha, CabecalhoED + Produtos + '||||||||')
                else
                  Imprimir(FabCozinha, PortaCozinha, CabecalhoED + Cabecalho + Produtos + Rodape);
              end;
          end;
    end;
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
  Imprimir(FabBalcao, PortaBalcao, 'IMPRESSAO PARA BALCAO');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Imprimir(FabCozinha, PortaCozinha, 'IMPRESSAO PARA COZINHA');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Close;
end;

function TForm1.CarregarPedidos: integer;
var
  JsonStream: TStringStream;
  begin
    Timer1.Enabled := false;
    JsonStream:= TStringStream.Create('');
  try
    try
      idHttp1.Get('http://' + Dominio + '/administrador/json/pedido_json/retonar_pedidos_impressora/08787a804e2a4f7ba145a553e4eab7cb/' + CodEmpresa, JsonStream);
      Timer1.Enabled := False;
      ArmazenarDados(JsonStream);
      Timer1.Enabled := True;
    except
      on E: Exception do
        begin
          Timer1.Enabled := True;
        end;
    end;
  finally
    JsonStream.Free();
    Timer1.Enabled := True;
  end;
end;

procedure TForm1.ConfigurarImpressoraBalcao;
var
  Retorno, ModeloBematech: Integer;
begin
  if FabBalcao = '1' then
    begin
      if ModeloBalcao = 'MP2500' then
       ModeloBematech := 8;

      ConfiguraModeloImpressora(ModeloBematech);
      Retorno := IniciaPorta(PortaBalcao);

      if (Retorno <> 1) then
        Application.MessageBox('Erro de conex�o','Erro!',0);
    end;
end;

procedure TForm1.ConfigurarImpressoraCozinha;
var
  Retorno, ModeloBematech: Integer;
begin
  if FabCozinha = '1' then
    begin
      if ModeloCozinha = 'MP2500' then
        ModeloBematech := 8;

      ConfiguraModeloImpressora(ModeloBematech);
      Retorno := IniciaPorta(PChar(PortaCozinha));

      if (Retorno <> 1) then
        Application.MessageBox('Erro de conex�o','Erro!',0);
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Minimizar := True;
  LerConfiguracoes;
end;

procedure TForm1.Imprimir(Fabricante, Porta, Texto: String);
begin
  if Fabricante = '0' then
    ImprimirDireto(Porta, Texto);

  if Fabricante = '1' then
    ImprimirBematech(Texto);
end;

procedure TForm1.ImprimirBematech(Texto: String);
var
  StringList: TStringList;
  IX: Integer;
begin
  try
    Texto := StringReplace(Texto, '%20', ' ', [rfReplaceAll]);
    StringList := TStringList.Create;
    StringList.Delimiter       := '|';
    StringList.StrictDelimiter := True;
    StringList.DelimitedText   := Texto;

    for IX := 0 to (StringList.Count - 1) do
      BematechTX(PChar(StringList[IX]) + #10);

    AcionaGuilhotina(1);

  finally
    StringList.Free;
  End;
end;

procedure TForm1.ImprimirDireto(Porta, Texto: String);
var
  Impressora: TextFile;
  StringList: TStringList;
  IX: Integer;
begin
  try
    Texto := StringReplace(Texto, '%20', ' ', [rfReplaceAll]);
    StringList := TStringList.Create;
    StringList.Delimiter       := '|';
    StringList.StrictDelimiter := True;
    StringList.DelimitedText   := Texto;

    AssignFile(Impressora, Porta);
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

function TForm1.LerConfiguracoes: boolean;
var
ArquivoINI : TINifile;
begin
   ArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'CONFIG.INI') ;
   CodEmpresa := ArquivoINI.ReadString('GERAL', 'Empresa', '');
   Dominio    := ArquivoINI.ReadString('GERAL', 'Dominio', '');

   PortaCozinha           := ArquivoINI.ReadString('COZINHA', 'Porta', '');
   FabCozinha             := ArquivoINI.ReadString('COZINHA', 'Fabricante', '');
   ModeloCozinha          := ArquivoINI.ReadString('COZINHA', 'Modelo', '');
   SomanteProdutosCozinha := ArquivoINI.ReadString('COZINHA', 'SomenteProdutos', '');

   PortaBalcao           := ArquivoINI.ReadString('BALCAO', 'Porta', '');
   FabBalcao             := ArquivoINI.ReadString('BALCAO', 'Fabricante', '');
   ModeloBalcao          := ArquivoINI.ReadString('BALCAO', 'Modelo', '');
   SomanteProdutosBalcao := ArquivoINI.ReadString('BALCAO', 'SomenteProdutos', '');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  CarregarPedidos;
end;

procedure TForm1.TimerTimer(Sender: TObject);
begin
  Timer1.Enabled := not(Timer1.Enabled);
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.unit frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP,System.IniFiles,declaracoes, Vcl.StdCtrls,System.JSON,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    function CarregarPedidos:integer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    CodEmpresa: String;
    Dominio: String;

    PortaCozinha: String;
    FabCozinha: String;
    ModeloCozinha: String;

    PortaBalcao: String;
    FabBalcao: String;
    ModeloBalcao: String;

    function  LerConfiguracoes:Boolean;
    procedure ConfigurarImpressoraBalcao;
    procedure ConfigurarImpressoraCozinha;
    procedure ArmazenarDados(Dados: TStringStream);
    procedure Imprimir(Texto: String);
    procedure ImprimirBematech(Texto: String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.ArmazenarDados(Dados:TStringStream);
var
  jsonObj, jSubObj: TJSONObject;
  ja: TJSONArray;
  jp, jSubPar: TJSONPair;
  i, j: integer;
  ImprimeCozinha, ImprimeBalcao: Boolean;
  Texto: String;
begin
  jsonObj := TJsonObject.Create;
  jsonObj.Parse (Dados.Bytes, 0);

  jp := TJSONPair.Create;
  jp := jsonObj.Get(0);
  ja := TJSONArray.Create;
  ja := (jp.JsonValue as TJSONArray);
  jSubObj:= TJSONObject.Create;
  jSubPar := TJSONPair.Create;

  for i := 0 to ja.Size - 1 do
    begin
      ImprimeCozinha := False;
      ImprimeBalcao  := False;

      jSubObj := (ja.Get(i) as TJSONObject);
      for j := 0 to jSubObj.Size - 1 do
        begin
          jSubPar := jSubObj.Get(j);

          case (j) of
            0: ImprimeBalcao  := (jSubPar.JsonValue.Value = '1');
            1: ImprimeCozinha := (jSubPar.JsonValue.Value = '1');
            2: Texto          := (jSubPar.JsonValue.Value);
          end;

        end;

        if (ImprimeBalcao) then
          begin
            if (Trim(PortaBalcao) <> '') then
              begin
                ConfigurarImpressoraBalcao;
                Imprimir(Texto);
              end;
          end;

        if (ImprimeCozinha) then
          begin
            if (Trim(PortaCozinha) <> '') then
              begin
                Imprimir(Texto);
              end;
          end;
    end;
end;



function TForm1.CarregarPedidos: integer;
var
  JsonStream: TStringStream;
  begin
    Timer1.Enabled := false;
    JsonStream:= TStringStream.Create('');
  try
    idHttp1.Get('http://localhost/encontredelivery/administrador/json/pedido_json/retonar_pedidos_impressora/08787a804e2a4f7ba145a553e4eab7cb/2', JsonStream);
    ArmazenarDados(JsonStream);
  finally
    JsonStream.Free();
    Timer1.Enabled := True;
  end;
end;

procedure TForm1.ConfigurarImpressoraBalcao;
var
  Retorno, ModeloBematech: Integer;
begin
  if FabBalcao = '1' then
    begin
      if ModeloBalcao = 'MP2500' then
       ModeloBematech := 8;

      ConfiguraModeloImpressora(ModeloBematech);
      Retorno := IniciaPorta(PortaBalcao);

      if (Retorno <> 1) then
        Application.MessageBox('Erro de conex�o','Erro!',0);
    end;
end;

procedure TForm1.ConfigurarImpressoraCozinha;
var
  Retorno, ModeloBematech: Integer;
begin
  if FabCozinha = '1' then
    begin
      if ModeloCozinha = 'MP2500' then
        ModeloBematech := 8;

      ConfiguraModeloImpressora(ModeloBematech);
      Retorno := IniciaPorta(PChar(PortaCozinha));

      if (Retorno <> 1) then
        Application.MessageBox('Erro de conex�o','Erro!',0);
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  LerConfiguracoes;
  ConfigurarImpressoraCozinha;
end;

procedure TForm1.Imprimir(Texto: String);
begin
  if FabCozinha = '0' then
    ImprimirBematech(Texto);
end;

procedure TForm1.ImprimirBematech(Texto: String);
var
  StringList: TStringList;
  IX: Integer;
begin
  try
    Texto := StringReplace(Texto, '%20', ' ', [rfReplaceAll]);
    StringList := TStringList.Create;
    StringList.Delimiter       := '|';
    StringList.StrictDelimiter := True;
    StringList.DelimitedText   := Texto;

    for IX := 0 to (StringList.Count - 1) do
      BematechTX(PChar(StringList[IX]) + #10);

    AcionaGuilhotina(1);

  finally
    StringList.Free;
  End;
end;

function TForm1.LerConfiguracoes: boolean;
var
ArquivoINI : TINifile;
begin
   ArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'CONFIG.INI') ;
   CodEmpresa := ArquivoINI.ReadString('GERAL', 'Empresa', '');

   PortaCozinha   := ArquivoINI.ReadString('COZINHA', 'Porta', '');
   FabCozinha     := ArquivoINI.ReadString('COZINHA', 'Fabricante', '');
   ModeloCozinha  := ArquivoINI.ReadString('COZINHA', 'Modelo', '');

   PortaBalcao   := ArquivoINI.ReadString('BALCAO', 'Porta', '');
   FabBalcao     := ArquivoINI.ReadString('BALCAO', 'Fabricante', '');
   ModeloBalcao  := ArquivoINI.ReadString('BALCAO', 'Modelo', '');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  CarregarPedidos;
end;

end.unit frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP,System.IniFiles,declaracoes, Vcl.StdCtrls,System.JSON,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    function CarregarPedidos:integer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    CodEmpresa: String;

    PortaCozinha: String;
    FabCozinha: String;
    ModeloCozinha: String;

    PortaBalcao: String;
    FabBalcao: String;
    ModeloBalcao: String;

    function  LerConfiguracoes:Boolean;
    procedure ConfigurarImpressoraBalcao;
    procedure ConfigurarImpressoraCozinha;
    procedure ArmazenarDados(Dados: TStringStream);
    procedure Imprimir(Texto: String);
    procedure ImprimirBematech(Texto: String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.ArmazenarDados(Dados:TStringStream);
var
  jsonObj, jSubObj: TJSONObject;
  ja: TJSONArray;
  jp, jSubPar: TJSONPair;
  i, j: integer;
  ImprimeCozinha, ImprimeBalcao: Boolean;
  Texto: String;
begin
  jsonObj := TJsonObject.Create;
  jsonObj.Parse (Dados.Bytes, 0);

  jp := TJSONPair.Create;
  jp := jsonObj.Get(0);
  ja := TJSONArray.Create;
  ja := (jp.JsonValue as TJSONArray);
  jSubObj:= TJSONObject.Create;
  jSubPar := TJSONPair.Create;

  for i := 0 to ja.Size - 1 do
    begin
      ImprimeCozinha := False;
      ImprimeBalcao  := False;

      jSubObj := (ja.Get(i) as TJSONObject);
      for j := 0 to jSubObj.Size - 1 do
        begin
          jSubPar := jSubObj.Get(j);

          case (j) of
            0: ImprimeBalcao  := (jSubPar.JsonValue.Value = '1');
            1: ImprimeCozinha := (jSubPar.JsonValue.Value = '1');
            2: Texto          := (jSubPar.JsonValue.Value);
          end;

        end;

        if (ImprimeBalcao) then
          begin
            if (Trim(PortaBalcao) <> '') then
              begin
                ConfigurarImpressoraBalcao;
                Imprimir(Texto);
              end;
          end;

        if (ImprimeCozinha) then
          begin
            if (Trim(PortaCozinha) <> '') then
              begin
                Imprimir(Texto);
              end;
          end;
    end;
end;



function TForm1.CarregarPedidos: integer;
var
  JsonStream: TStringStream;
  begin
    Timer1.Enabled := false;
    JsonStream:= TStringStream.Create('');
  try
    idHttp1.Get('http://localhost/encontredelivery/administrador/json/pedido_json/retonar_pedidos_impressora/08787a804e2a4f7ba145a553e4eab7cb/2', JsonStream);
    ArmazenarDados(JsonStream);
  finally
    JsonStream.Free();
    Timer1.Enabled := True;
  end;
end;

procedure TForm1.ConfigurarImpressoraBalcao;
var
  Retorno, ModeloBematech: Integer;
begin
  if FabBalcao = '1' then
    begin
      if ModeloBalcao = 'MP2500' then
       ModeloBematech := 8;

      ConfiguraModeloImpressora(ModeloBematech);
      Retorno := IniciaPorta(PortaBalcao);

      if (Retorno <> 1) then
        Application.MessageBox('Erro de conex�o','Erro!',0);
    end;
end;

procedure TForm1.ConfigurarImpressoraCozinha;
var
  Retorno, ModeloBematech: Integer;
begin
  if FabCozinha = '1' then
    begin
      if ModeloCozinha = 'MP2500' then
        ModeloBematech := 8;

      ConfiguraModeloImpressora(ModeloBematech);
      Retorno := IniciaPorta(PChar(PortaCozinha));

      if (Retorno <> 1) then
        Application.MessageBox('Erro de conex�o','Erro!',0);
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  LerConfiguracoes;
  ConfigurarImpressoraCozinha;
end;

procedure TForm1.Imprimir(Texto: String);
begin
  if FabCozinha = '0' then
    ImprimirBematech(Texto);
end;

procedure TForm1.ImprimirBematech(Texto: String);
var
  StringList: TStringList;
  IX: Integer;
begin
  try
    Texto := StringReplace(Texto, '%20', ' ', [rfReplaceAll]);
    StringList := TStringList.Create;
    StringList.Delimiter       := '|';
    StringList.StrictDelimiter := True;
    StringList.DelimitedText   := Texto;

    for IX := 0 to (StringList.Count - 1) do
      BematechTX(PChar(StringList[IX]) + #10);

    AcionaGuilhotina(1);

  finally
    StringList.Free;
  End;
end;

function TForm1.LerConfiguracoes: boolean;
var
ArquivoINI : TINifile;
begin
   ArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'CONFIG.INI') ;
   CodEmpresa := ArquivoINI.ReadString('GERAL', 'Empresa', '');

   PortaCozinha   := ArquivoINI.ReadString('COZINHA', 'Porta', '');
   FabCozinha     := ArquivoINI.ReadString('COZINHA', 'Fabricante', '');
   ModeloCozinha  := ArquivoINI.ReadString('COZINHA', 'Modelo', '');

   PortaBalcao   := ArquivoINI.ReadString('BALCAO', 'Porta', '');
   FabBalcao     := ArquivoINI.ReadString('BALCAO', 'Fabricante', '');
   ModeloBalcao  := ArquivoINI.ReadString('BALCAO', 'Modelo', '');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  CarregarPedidos;
end;

end.