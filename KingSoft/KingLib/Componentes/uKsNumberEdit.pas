unit uKsNumberEdit;

interface

uses
  Windows, SysUtils, Messages, Classes, Controls, Forms, Graphics, Menus, Variants,
  StdCtrls, DB, Mask, DBCtrls, Dialogs;

type
  TKsNumberEdit = class(TCustomMaskEdit)
  private
    { Private declarations }
    FShowSeparator, FNegativo: Boolean;
    FKey: Char;
    FDecimals: Byte;
    procedure EvaluateKey;
    procedure EvalDecSeparator;
    procedure InvertValue;
    procedure ValidateKey;
    function  GetValue: Extended;
    function  StrToValue(S: string): Extended;
    procedure Formatar;
  protected
    { Protected declarations }
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure SetDecimals(Dec: Byte);
    procedure SetShowSeparator(Value: Boolean);
    procedure SetNegativo(Value: Boolean);
    procedure DoExit; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property Decimals: Byte read FDecimals write SetDecimals;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Negativo: Boolean read FNegativo write SetNegativo;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ReadOnly;
    property ShowHint;
    property ShowSeparator: Boolean read FShowSeparator write SetShowSeparator;
    property TabOrder;
    property TabStop;
    property Value: Extended read GetValue;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('KingSoft', [TKsNumberEdit]);
end;

{ TCustomMaskEdit1 }


constructor TKsNumberEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := False;

  FShowSeparator := True;
  FNegativo      := False;
  FNegativo      := True;
  Alignment      := taRightJustify;
  EditText       := '0';
  Text           := '0';
  Formatar;
end;

procedure TKsNumberEdit.DoExit;
begin
  Formatar;
  inherited;
end;

procedure TKsNumberEdit.EvalDecSeparator;
var
  I, L: Integer;
begin
  L := Length(Text);
  I := Pos(FormatSettings.DecimalSeparator, Text );
  if (I > 0) and (SelLength <> L) then
    begin
      SelStart := I;
      FKey := #0;
    end
  else if (SelLength <> L) and ((SelStart + FDecimals) < L) then
    begin
      {retira decimais excedentes, se houver}
      I := SelStart;
      Text := Copy(Text, 1, SelStart + FDecimals);
      SelStart := I;
    end;
end;

procedure TKsNumberEdit.EvaluateKey;
var
  I, L: Integer;
begin
  L := Length(Text);
  I := Pos(FormatSettings.DecimalSeparator, Text);
  {edição dos decimais}
  if (I <> 0) and (SelStart >= I) and ((L - I) >= FDecimals) and (SelLength = 0) then
    begin
      if (SelStart < L) then
        begin
          I := SelStart;
          Text := Copy(Text, 1, L - 1 );
          SelStart := I;
        end
      else if (FKey <> #08) then
        begin
          MessageBeep(0);
          FKey := #0;
        end;
    end;
end;

procedure TKsNumberEdit.Formatar;
var
  valor: String;
  i: Integer;
begin
  if (Text = '') then
    Text := '0';

  if (FDecimals > 0) then
    begin
      valor := '';

      for I := 0 to (FDecimals - 1) do
        valor := valor + '0';

      EditText := FormatFloat('0.' + valor, StrToFloat(VarToStr(GetValue)));
    end;
end;

function TKsNumberEdit.GetValue: Extended;
begin
  Result := StrToValue(Text);
end;

procedure TKsNumberEdit.InvertValue;
var
  I, L: Integer;
begin
  L := Length(Text);
  if SelLength <> L then
    begin
      I := SelStart;
      if (GetValue > 0) and (FNegativo) then
        Text := '-' + Text
      else if GetValue < 0 then
        Text := Copy(Text, 2, L);
      SelStart := I + Length(Text) - L;
      FKey := #0;
    end;
end;

procedure TKsNumberEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  FKey := Key;
  if FKey <> #0 then
    ValidateKey;
  if FKey = '-' then
    InvertValue;
  if FKey = FormatSettings.DecimalSeparator then
    EvalDecSeparator;
  if FKey <> #0 then
    EvaluateKey;
  Key := FKey;
end;

procedure TKsNumberEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

procedure TKsNumberEdit.SetDecimals(Dec: Byte);
begin
  FDecimals := Dec;
  Formatar;
end;

procedure TKsNumberEdit.SetNegativo(Value: Boolean);
begin
  if FNegativo <> Value then
    FNegativo := Value;
end;

procedure TKsNumberEdit.SetShowSeparator(Value: Boolean);
begin
  if FShowSeparator <> Value then
    begin
      FShowSeparator := Value;
      Invalidate;
    end;
end;

function TKsNumberEdit.StrToValue(S: string): Extended;
var
  N: string;
  I: Integer;
begin
  N := '0';
  for I := 1 to Length(S) do
    if ((S[I] = FormatSettings.DecimalSeparator) and (Pos(FormatSettings.DecimalSeparator, N) = 0))
      or (S[I] in ['0'..'9']) then
      N := N + S[I];
  Result := StrToFloat(N);
  if (N <> '0') and (Pos('-', S) = 1) then
    Result := -StrToFloat(N)
end;

procedure TKsNumberEdit.ValidateKey;
begin
  if FKey in ['.', ','] then
    FKey := FormatSettings.DecimalSeparator;
  if not (FKey in ['0'..'9', '.', ',', '-', #08, #27, ^X, ^C, ^V])
    or ((GetValue < 0) and (SelStart = 0) and (SelLength = 0) and (FKey <> '-'))
    or ((FKey = FormatSettings.DecimalSeparator) and (FDecimals = 0)) then
    begin
      MessageBeep(0);
      FKey := #0;
    end
  else
  if FKey = #27 then
    begin
      SelectAll;
      FKey := #0;
    end;
end;

end.
