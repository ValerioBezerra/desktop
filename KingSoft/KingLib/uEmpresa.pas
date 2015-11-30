unit uEmpresa;

interface

type
  TEmpresa = class
  private
    FId: Integer;
    FRazaoSocial: String;
    FFantasial: String;
  public
    property Id: Integer read FId write FId;
    property RazaoSocial: String read FRazaoSocial write FRazaoSocial;
    property Fantasial: String read FFantasial write FFantasial;
end;

implementation

{ TEmpresa }



end.

