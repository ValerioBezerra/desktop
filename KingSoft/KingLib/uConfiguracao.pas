unit uConfiguracao;

interface

uses
  SysUtils, Forms, Dialogs, IniFiles;

type
  TConfiguracao = class
  private
    FServer: String;
    FDataBase: String;
    FVendorLib: String;
  public
    constructor Create;
    property Server: String read FServer write FServer;
    property DataBase: String read FDataBase write FDataBase;
    property VendorLib: String read FVendorLib write FVendorLib;
end;

implementation

{ TConfiguracao }

constructor TConfiguracao.Create;
var
  IniFile: TIniFile;
begin
  if (FileExists(ExtractFilePath(Application.ExeName) + 'config.ini')) then
    begin
      IniFile   := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
      Server    := IniFile.ReadString('Conexao', 'Server', '');
      DataBase  := IniFile.ReadString('Conexao', 'DataBase', '');
      VendorLib := IniFile.ReadString('Conexao', 'VendorLib', '');
      IniFile.Free;
    end
  else
    ShowMessage('Arquivo config.ini não encontrado');
end;

end.

