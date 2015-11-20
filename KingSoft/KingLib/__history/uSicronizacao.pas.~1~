unit uConexao;

interface

uses
  SysUtils, Forms, Dialogs, IniFiles;

type
  TConexao = class
  private
    FDataBase: String;
    FServer: String;
    FVendorLib: String;
  public
    constructor Create;
    property DataBase: String read FDataBase write FDataBase;
    property Server: String read FServer write FServer;
    property VendorLib: String read FVendorLib write FVendorLib;
end;

implementation

{ TConexao }

constructor TConexao.Create;
var
  IniFile: TIniFile;
begin
  if (FileExists(ExtractFilePath(Application.ExeName) + 'config.ini')) then
    begin
      IniFile   := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
      DataBase  := IniFile.ReadString('Conexao', 'DataBase', '');
      Server    := IniFile.ReadString('Conexao', 'Server', '');
      VendorLib := IniFile.ReadString('Conexao', 'VendorLib', '');
      IniFile.Free;
    end
  else
    ShowMessage('Arquivo config.ini não encontrado');
end;

end.

