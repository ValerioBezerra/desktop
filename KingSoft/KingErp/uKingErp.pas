unit uKingErp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Shellapi, TlHelp32, Vcl.ComCtrls, Vcl.ImgList;

type
  TfrmKingErp = class(TForm)
    MainMenu: TMainMenu;
    Cadastro1: TMenuItem;
    Movimento1: TMenuItem;
    Image1: TImage;
    Autorizao1: TMenuItem;
    Mudarsenha1: TMenuItem;
    N1: TMenuItem;
    Relatrios1: TMenuItem;
    Processos1: TMenuItem;
    Logout2: TMenuItem;
    StatusBar: TStatusBar;
    Timer: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Logout2Click(Sender: TObject);
    procedure Mudarsenha1Click(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    ExisteAutorizacaoCadastro: Boolean;
    { Private declarations }
    procedure AdicionarModuloAutorizacaoCadastro;
    procedure AdicionarModuloAutorizacaoMovimentacao;
    procedure AdicionarModuloRelatorioGraficoGrafico(Const MenuModulo: TMenuItem);

  public
    { Public declarations }
    RazaoSocialEmpresa: String;
    procedure AdicionarModuloCadastro;
    procedure AdicionarModuloMovimentacao;
    procedure AdicionarModuloProcesso;
    procedure AdicionarModuloRelatorioGrafico;
    procedure AdicionarModuloAutorizacao;
    procedure AdicionarPrograma(Const MenuModulo: TMenuItem);
    procedure SelectAutorizacaoProgramas(CodigoInicial, CodigoFinal: String);
    procedure AbrirPrograma(Sender: TObject);
    function  VerificarProcesso(Executavel: String): Boolean;
  end;

var
  frmKingErp: TfrmKingErp;

implementation

{$R *.dfm}

uses uCMKingAutorizacao, uUtil;

{ TfrmKingErp }

procedure TfrmKingErp.AbrirPrograma(Sender: TObject);
var
  Parametros: String;
begin
  cmKingAutorizacao.cdsAUT_MOD.Filtered := False;
  cmKingAutorizacao.cdsAUT_MOD.Filter   := 'AUT_SIGLA_MOD = ' + QuotedStr(Copy(TMenuItem(Sender).Name, 1, 3));
  cmKingAutorizacao.cdsAUT_MOD.Filtered := True;

  if not(cmKingAutorizacao.cdsAUT_MOD.IsEmpty) then
    begin
      Parametros := TMenuItem(Sender).Name + ' ' + cmKingAutorizacao.cdsAUT_MOD.FieldByName('EMPRESA').AsString + ' ' +
                    cmKingAutorizacao.cdsAUT_USU.FieldByName('AUT_ID_USU').AsString + ' ' + cmKingAutorizacao.cdsAUT_USU.FieldByName('AUT_SENHA_USU').AsString;
      ShellExecute(Handle, 'Open', PChar(cmKingAutorizacao.cdsAUT_MOD.FieldByName('AUT_EXECUTAVEL_MOD').AsString), PChar(Parametros), '', SW_SHOWNORMAL);
    end;
end;

procedure TfrmKingErp.AdicionarModuloAutorizacao;
begin
  AdicionarModuloAutorizacaoCadastro;
  AdicionarModuloAutorizacaoMovimentacao;
end;

procedure TfrmKingErp.AdicionarModuloAutorizacaoCadastro;
var
  MenuPrograma: TMenuItem;
begin
  SelectAutorizacaoProgramas('001', '099');

  if not(cmKingAutorizacao.cdsAUT_PRO.IsEmpty) then
    begin
      cmKingAutorizacao.cdsAUT_PRO.First;
      while not(cmKingAutorizacao.cdsAUT_PRO.Eof) do
        begin
          MenuPrograma := TMenuItem.Create(MainMenu);
          MenuPrograma.Caption := cmKingAutorizacao.cdsAUT_PRO.FieldByName('AUT_DESCRICAO_PRO').AsString;
          MenuPrograma.Name    := cmKingAutorizacao.cdsAUT_MOD.FieldByName('AUT_SIGLA_MOD').AsString +
                                  cmKingAutorizacao.cdsAUT_PRO.FieldByName('AUT_CODIGO_PRO').AsString;
          MenuPrograma.OnClick := AbrirPrograma;
          MainMenu.Items[4].Insert(MainMenu.Items[4].Count, MenuPrograma);
        
          cmKingAutorizacao.cdsAUT_PRO.Next;
        end;
    end;

  ExisteAutorizacaoCadastro := not(cmKingAutorizacao.cdsAUT_PRO.IsEmpty);  
end;

procedure TfrmKingErp.AdicionarModuloAutorizacaoMovimentacao;
var
  MenuPrograma: TMenuItem;
begin
  SelectAutorizacaoProgramas('101', '199');

  if not(cmKingAutorizacao.cdsAUT_PRO.IsEmpty) then
    begin
      if (ExisteAutorizacaoCadastro) then
        begin
          MenuPrograma := TMenuItem.Create(MainMenu);
          MenuPrograma.Caption := '-';
          MainMenu.Items[4].Insert(MainMenu.Items[4].Count, MenuPrograma);
        end;
      cmKingAutorizacao.cdsAUT_PRO.First;
      while not(cmKingAutorizacao.cdsAUT_PRO.Eof) do
        begin
          MenuPrograma := TMenuItem.Create(MainMenu);
          MenuPrograma.Caption := cmKingAutorizacao.cdsAUT_PRO.FieldByName('AUT_DESCRICAO_PRO').AsString;
          MenuPrograma.Name    := cmKingAutorizacao.cdsAUT_MOD.FieldByName('AUT_SIGLA_MOD').AsString +
                                  cmKingAutorizacao.cdsAUT_PRO.FieldByName('AUT_CODIGO_PRO').AsString;
          MenuPrograma.OnClick := AbrirPrograma;
          MainMenu.Items[4].Insert(MainMenu.Items[4].Count, MenuPrograma);

          cmKingAutorizacao.cdsAUT_PRO.Next;
        end;
    end;
end;

procedure TfrmKingErp.AdicionarModuloCadastro;
var
  MenuModulo: TMenuItem;
begin
  SelectAutorizacaoProgramas('001', '099');

  if not(cmKingAutorizacao.cdsAUT_PRO.IsEmpty) then
    begin
      MenuModulo := TMenuItem.Create(MainMenu);
      MenuModulo.Caption := cmKingAutorizacao.cdsAUT_MOD.FieldByName('AUT_DESCRICAO_MOD').AsString;
      MainMenu.Items[0].Insert(MainMenu.Items[0].Count, MenuModulo);

      cmKingAutorizacao.cdsAUT_PRO.First;
      while not(cmKingAutorizacao.cdsAUT_PRO.Eof) do
        begin
          AdicionarPrograma(MenuModulo);
          cmKingAutorizacao.cdsAUT_PRO.Next;
        end;
    end;
end;

procedure TfrmKingErp.AdicionarModuloMovimentacao;
var
  MenuModulo: TMenuItem;
begin
  SelectAutorizacaoProgramas('101', '199');

  if not(cmKingAutorizacao.cdsAUT_PRO.IsEmpty) then
    begin
      MenuModulo := TMenuItem.Create(MainMenu);
      MenuModulo.Caption := cmKingAutorizacao.cdsAUT_MOD.FieldByName('AUT_DESCRICAO_MOD').AsString;
      MainMenu.Items[1].Insert(MainMenu.Items[1].Count, MenuModulo);

      cmKingAutorizacao.cdsAUT_PRO.First;
      while not(cmKingAutorizacao.cdsAUT_PRO.Eof) do
        begin
          AdicionarPrograma(MenuModulo);
          cmKingAutorizacao.cdsAUT_PRO.Next;
        end;
    end;
end;

procedure TfrmKingErp.AdicionarModuloProcesso;
var
  MenuModulo: TMenuItem;
begin
  SelectAutorizacaoProgramas('201', '299');

  if not(cmKingAutorizacao.cdsAUT_PRO.IsEmpty) then
    begin
      MenuModulo := TMenuItem.Create(MainMenu);
      MenuModulo.Caption := cmKingAutorizacao.cdsAUT_MOD.FieldByName('AUT_DESCRICAO_MOD').AsString;
      MainMenu.Items[2].Insert(MainMenu.Items[2].Count, MenuModulo);

      cmKingAutorizacao.cdsAUT_PRO.First;
      while not(cmKingAutorizacao.cdsAUT_PRO.Eof) do
        begin
          AdicionarPrograma(MenuModulo);
          cmKingAutorizacao.cdsAUT_PRO.Next;
        end;
    end;
end;

procedure TfrmKingErp.AdicionarModuloRelatorioGrafico;
var
  MenuModulo: TMenuItem;
begin
  SelectAutorizacaoProgramas('401', '499');

  if not(cmKingAutorizacao.cdsAUT_PRO.IsEmpty) then
    begin
      MenuModulo := TMenuItem.Create(MainMenu);
      MenuModulo.Caption := cmKingAutorizacao.cdsAUT_MOD.FieldByName('AUT_DESCRICAO_MOD').AsString;
      MainMenu.Items[3].Insert(MainMenu.Items[3].Count, MenuModulo);

      cmKingAutorizacao.cdsAUT_PRO.First;
      while not(cmKingAutorizacao.cdsAUT_PRO.Eof) do
        begin
          AdicionarPrograma(MenuModulo);
          cmKingAutorizacao.cdsAUT_PRO.Next;
        end;

      AdicionarModuloRelatorioGraficoGrafico(MenuModulo);
    end;

end;

procedure TfrmKingErp.AdicionarModuloRelatorioGraficoGrafico(Const MenuModulo: TMenuItem);
var
  MenuModuloGrafico: TMenuItem;
begin
  SelectAutorizacaoProgramas('501', '599');

  if not(cmKingAutorizacao.cdsAUT_PRO.IsEmpty) then
    begin
      MenuModuloGrafico         := TMenuItem.Create(MenuModulo);
      MenuModuloGrafico.Caption := 'Gr�ficos';
      MenuModulo.Insert(MenuModulo.Count, MenuModuloGrafico);

      cmKingAutorizacao.cdsAUT_PRO.First;
      while not(cmKingAutorizacao.cdsAUT_PRO.Eof) do
        begin
          AdicionarPrograma(MenuModuloGrafico);
          cmKingAutorizacao.cdsAUT_PRO.Next;
        end;
    end;
end;

procedure TfrmKingErp.AdicionarPrograma(Const MenuModulo: TMenuItem);
var
  MenuPrograma: TMenuItem;
begin
  MenuPrograma := TMenuItem.Create(MenuModulo);
  MenuPrograma.Caption := cmKingAutorizacao.cdsAUT_PRO.FieldByName('AUT_DESCRICAO_PRO').AsString;
  MenuPrograma.Name    := cmKingAutorizacao.cdsAUT_MOD.FieldByName('AUT_SIGLA_MOD').AsString +
                          cmKingAutorizacao.cdsAUT_PRO.FieldByName('AUT_CODIGO_PRO').AsString;
  MenuPrograma.OnClick := AbrirPrograma;
  MenuModulo.Insert(MenuModulo.Count, MenuPrograma);
end;

procedure TfrmKingErp.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ProgramaAberto: Boolean;
begin
  ProgramaAberto := False;
  if (VerificarProcesso('KingAutorizacao.exe')) then
    ProgramaAberto := True
  else
    begin
    cmKingAutorizacao.cdsAUT_MOD.Filtered := False;
    cmKingAutorizacao.cdsAUT_MOD.First;
    while not(cmKingAutorizacao.cdsAUT_MOD.Eof) do
      begin
        if (VerificarProcesso(cmKingAutorizacao.cdsAUT_MOD.FieldByName('AUT_EXECUTAVEL_MOD').AsString)) then
          begin
            ProgramaAberto := True;
            Break;
          end;
        cmKingAutorizacao.cdsAUT_MOD.Next;
      end;
    end;

  if (ProgramaAberto) then
    begin    
      TUtil.ExibirMensagem('Aten��o! Existe(m) programa(s) aberto(s), finalize-o(s).', 'A');
      Action := CaNone;
    end;

      
end;

procedure TfrmKingErp.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmKingErp.Logout2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmKingErp.Mudarsenha1Click(Sender: TObject);
var
  Parametros: String;
begin
  Parametros := 'AUT001 ' + cmKingAutorizacao.cdsAUT_MOD.FieldByName('EMPRESA').AsString + ' ' +
                cmKingAutorizacao.cdsAUT_USU.FieldByName('AUT_ID_USU').AsString + ' ' + cmKingAutorizacao.cdsAUT_USU.FieldByName('AUT_SENHA_USU').AsString;
  ShellExecute(Handle, 'Open', PChar('KingAutorizacao.exe'), PChar(Parametros), '', SW_SHOWNORMAL);
end;

procedure TfrmKingErp.SelectAutorizacaoProgramas(CodigoInicial,
  CodigoFinal: String);
begin
  cmKingAutorizacao.cdsAUT_PRO.Close;
  cmKingAutorizacao.cdsAUT_PRO.CommandText := ' SELECT AUT_CODIGO_PRO, ' +
                                              '        AUT_DESCRICAO_PRO ' +
                                              ' FROM AUT_APE ' +
                                              ' INNER JOIN AUT_PRO ON AUT_ID_PRO = AUT_AUTPRO_APE ' +
                                              ' WHERE AUT_GEREMP_APE = ' + IntToStr(cmKingAutorizacao.cdsAUT_MOD.FieldByName('EMPRESA').AsInteger) +
                                              '   AND AUT_AUTPER_APE = ' + IntToStr(cmKingAutorizacao.cdsAUT_USU.FieldByName('AUT_AUTPER_USU').AsInteger) +
                                              '   AND AUT_AUTMOD_PRO = ' + IntToStr(cmKingAutorizacao.cdsAUT_MOD.FieldByName('AUT_ID_MOD').AsInteger) +
                                              '   AND AUT_MENUPRINCIPAL_PRO = 1 ' +
                                              '   AND AUT_CODIGO_PRO BETWEEN ' + QuotedStr(CodigoInicial) + ' AND ' + QuotedStr(CodigoFinal) +
                                              ' UNION ' +
                                              ' SELECT AUT_CODIGO_PRO, ' +
                                              '        AUT_DESCRICAO_PRO ' +
                                              ' FROM AUT_AUS ' +
                                              ' INNER JOIN AUT_PRO ON AUT_ID_PRO = AUT_AUTPRO_AUS ' +
                                              ' WHERE AUT_GEREMP_AUS = ' + IntToStr(cmKingAutorizacao.cdsAUT_MOD.FieldByName('EMPRESA').AsInteger) +
                                              '   AND AUT_AUTUSU_AUS = ' + IntToStr(cmKingAutorizacao.cdsAUT_USU.FieldByName('AUT_ID_USU').AsInteger) +
                                              '   AND AUT_AUTMOD_PRO = ' + IntToStr(cmKingAutorizacao.cdsAUT_MOD.FieldByName('AUT_ID_MOD').AsInteger) +
                                              '   AND AUT_MENUPRINCIPAL_PRO = 1 ' +
                                              '   AND AUT_CODIGO_PRO BETWEEN ' + QuotedStr(CodigoInicial) + ' AND ' + QuotedStr(CodigoFinal);
  cmKingAutorizacao.cdsAUT_PRO.Open;
end;

procedure TfrmKingErp.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  StatusBar.Canvas.Font.Style := [fsBold];
  StatusBar.Canvas.Font.Size  := 10;

  if (Panel.Index = 0) then
    StatusBar.Canvas.TextOut(Rect.Left + Font.Size, Rect.Top + 1, 'Empresa: ' + RazaoSocialEmpresa);

  if (Panel.Index = 1) then
    StatusBar.Canvas.TextOut(Rect.Left + Font.Size, Rect.Top + 1, 'Usu�rio: ' + cmKingAutorizacao.cdsAUT_USU.FieldByName('AUT_NOME_USU').AsString);

  if (Panel.Index = 2) then
    StatusBar.Canvas.TextOut(Rect.Left + Font.Size, Rect.Top + 1, 'Data: ' + DateToStr(Now));

  if (Panel.Index = 3) then
    StatusBar.Canvas.TextOut(Rect.Left + Font.Size, Rect.Top + 1, 'Hora: ' + TimeToStr(Now));
end;

procedure TfrmKingErp.TimerTimer(Sender: TObject);
begin
  StatusBar.Repaint;
end;

function TfrmKingErp.VerificarProcesso(Executavel: String): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
    begin
      if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(Executavel)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(Executavel))) then
        begin
          Result := True;
        end;

      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;
  CloseHandle(FSnapshotHandle);
end;

end.
