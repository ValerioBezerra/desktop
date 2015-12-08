unit uSicronizacao;

interface

uses
  SysUtils, Forms, Dialogs, IniFiles;

type
  TSicronizacao = class
  private
    FHostName: String;
    FPath: String;
  public
    constructor Create;
    property HostName: String read FHostName write FHostName;
    property Path: String read FPath write FPath;
end;

implementation

{ TSicronizacao }

constructor TSicronizacao.Create;
var
  IniFile: TIniFile;
begin
  if (FileExists(ExtractFilePath(Application.ExeName) + 'sinc.ini')) then
    begin
      IniFile  := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'sinc.ini');
      HostName := IniFile.ReadString('Sincronizacao', 'HostName', '');
      Path     := IniFile.ReadString('Sincronizacao', 'Path', '');
      IniFile.Free;
    end
  else
    ShowMessage('Arquivo sinc.ini não encontrado');
end;

end.

