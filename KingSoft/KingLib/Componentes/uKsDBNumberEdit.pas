unit uKsDBNumberEdit;

interface

uses
  Windows, SysUtils, Messages, Classes, Controls, Forms, Graphics, Menus, Variants,
  StdCtrls, DB, Mask, DBCtrls, Dialogs;

type
  TKsDBNumberEdit = class(TCustomMaskEdit)
  private
    FAlignment: TAlignment;
    FCanvas: TControlCanvas;
    FDataLink: TFieldDataLink;
    FDecimals: Byte;
    FFocused: Boolean;
    FKey: Char;
    FMaxValue: Extended;
    FMinValue: Extended;
    FShowSeparator, FNegativo: Boolean;
    FOnOutOfRange: TNotifyEvent;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure EvalDecSeparator;
    procedure EvaluateKey;
    procedure InvertValue;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure SetDecimals(Dec: Byte);
    procedure SetShowSeparator(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure ValidateKey;
    procedure CMEnter(var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Msg: TMessage); message CM_GETDATALINK;
    procedure WMCut(var Msg: TMessage); message WM_CUT;
    procedure WMMouse(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMPaste(var Msg: TMessage); message WM_PASTE;
    function CheckRange: Boolean;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    function GetValue: Extended;
    function IsActive: Boolean;
    function StrToValue(S: string): Extended;
  protected
    procedure Change; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Reset; override;
    procedure SetNegativo(Value: Boolean);
    function EditCanModify: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
    property Value: Extended read GetValue;
  published
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Decimals: Byte read FDecimals write SetDecimals;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Negativo: Boolean read FNegativo write SetNegativo;
    property MaxLength;
    property MaxValue: Extended read FMaxValue write FMaxValue;
    property MinValue: Extended read FMinValue write FMinValue;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property ShowSeparator: Boolean read FShowSeparator write SetShowSeparator;
    property TabOrder;
    property TabStop;
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
    property OnOutOfRange: TNotifyEvent read FOnOutOfRange write FOnOutOfRange;
    property OnStartDrag;
  end;

procedure Register;

implementation

{ Create }
constructor TKsDBNumberEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];
  FShowSeparator := True;
  FNegativo      := False;
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
//  FDecimals := 2;
  FAlignment := taRightJustify;
  EditText := '';
  RecreateWnd;
end;


{ Destroy }
destructor TKsDBNumberEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FCanvas.Free;
  inherited Destroy;
end;


{ CreateParams }
procedure TKsDBNumberEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'EDIT');
  Params.Style := Params.Style and not (ES_AUTOVSCROLL or ES_AUTOHSCROLL)
    or Alignments[FAlignment] ;
end;


{ Notification }
procedure TKsDBNumberEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then
    DataSource := nil;
end;


{ KeyDown }
procedure TKsDBNumberEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
end;


{ KeyPress }
procedure TKsDBNumberEdit.KeyPress(var Key: Char);
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


{ EditCanModify }
function TKsDBNumberEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;


{ Reset }
procedure TKsDBNumberEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;


{ SetFocused }
procedure TKsDBNumberEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
    begin
      FFocused := Value;
      if (FAlignment <> taLeftJustify) and not IsMasked then
        Invalidate;
      FDataLink.Reset;
    end;
end;


procedure TKsDBNumberEdit.SetNegativo(Value: Boolean);
begin
  if FNegativo <> Value then
    FNegativo := Value;
end;

{ Change }
procedure TKsDBNumberEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;


{ GetDataSource }
function TKsDBNumberEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;


{ SetDataSource }
procedure TKsDBNumberEdit.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;


{ GetDataField }
function TKsDBNumberEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;


{ SetDataField }
procedure TKsDBNumberEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;


{ GetReadOnly }
function TKsDBNumberEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;


{ SetReadOnly }
procedure TKsDBNumberEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;


{ GetField }
function TKsDBNumberEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;


{ DataChange }
procedure TKsDBNumberEdit.DataChange(Sender: TObject);
begin
Try
  if FDataLink.Field <> nil then
    begin
      if FAlignment <> FDataLink.Field.Alignment then
        begin
          EditText := '0';
          FAlignment := FDataLink.Field.Alignment;
          RecreateWnd;
          if Focused then
            PostMessage(Handle, WM_SETFOCUS, 0, 0);
        end;

      if (trim(FDataLink.Field.AsString) <> '') then
         begin
           if FFocused and FDataLink.CanModify then
              Text := FloatToStrF(FDataLink.Field.AsFloat, ffFixed, 20, FDecimals)
           else
             EditText := FloatToStrF(FDataLink.Field.AsFloat, ffNumber, 20, FDecimals);
         end
      else
         begin
           if FFocused and FDataLink.CanModify then
              Text := FloatToStrF(0, ffFixed, 20, FDecimals)
           else
             EditText := FloatToStrF(0, ffNumber, 20, FDecimals);
         end;
    end
  else
    begin
      if csDesigning in ComponentState then
        begin
          EditText := Name;
          if FAlignment <> taLeftJustify then
            begin
              FAlignment := taLeftJustify;
              RecreateWnd;
            end
        end
      else
        EditText := '';
    end;
  if Focused then
    SelectAll;
except
end;
end;


{ EditingChange }
procedure TKsDBNumberEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;


{ UpdateData }
procedure TKsDBNumberEdit.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  if CheckRange then
    FDataLink.Field.Text := FloatToStr(GetValue)
  else
    Abort;
end;


{ WMPaste }
procedure TKsDBNumberEdit.WMPaste(var Msg: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;


{ WMCut }
procedure TKsDBNumberEdit.WMCut(var Msg: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;


{ CMEnter }
procedure TKsDBNumberEdit.CMEnter(var Msg: TCMEnter);
begin
  SetFocused(True);
  SelectAll;
  inherited;
  Invalidate;
end;


{ CMExit }
procedure TKsDBNumberEdit.CMExit(var Msg: TCMExit);
begin
  if CheckRange then
    begin
      try
        if DataSource.State in [dsinsert, dsedit] then
           FDataLink.UpdateRecord;
      except
        SelectAll;
        SetFocus;
        raise;
      end;
      SetFocused(False);
      SetCursor(0);
      DoExit;
    end;
end;


{ WMPaint }
procedure TKsDBNumberEdit.WMPaint(var Msg: TWMPaint);
var
  X, Y: Integer;
  Rect: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
begin
  if FFocused and not (csPaintCopy in ControlState) then
    begin
      inherited;
      Exit;
    end;
  if (csDesigning in ComponentState) and (not IsActive) then
    S := Name
  else if FShowSeparator then
    S := FloatToStrF(GetValue, ffNumber, 20, FDecimals)
  else
    S := FloatToStrF(GetValue, ffFixed, 20, FDecimals);
  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
    S := FloatToStrF(FDataLink.Field.AsFloat, ffNumber, 20, FDecimals);
  DC := Msg.DC;
  if DC = 0 then
    DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    if not Enabled then
      FCanvas.Font.Color := clGray;
    Rect := ClientRect;
    if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
      begin
        FCanvas.Brush.Color := clWindowFrame;
        FCanvas.FrameRect(Rect);
        InflateRect(Rect, -1, -1);
      end;
    FCanvas.Brush.Color := Color;
    Y := ((Height + Font.Height) div 2) - 3;
    X := Y - 1;
    case FAlignment of
      taRightJustify: X := Rect.Right - FCanvas.TextWidth(S) - Y;
      taCenter: X := (Rect.Left + Rect.Right - FCanvas.TextWidth(S)) div 2;
    end;
    FCanvas.TextRect(Rect, X, Y, S);
  finally
    FCanvas.Handle := 0;
    if Msg.DC = 0 then
      EndPaint(Handle, PS);
  end;
end;


{ CMGetDataLink }
procedure TKsDBNumberEdit.CMGetDataLink(var Msg: TMessage);
begin
  Msg.Result := Integer(FDataLink);
end;


{ WMMouse }
procedure TKsDBNumberEdit.WMMouse(var Msg: TWMMouse);
begin
  if not Focused then
    begin
      inherited;
      SelectAll;
    end
  else
    inherited;
end;


{ GetValue }
function TKsDBNumberEdit.GetValue: Extended;
begin
  Result := StrToValue(Text);
end;


{ StrToValue }
function TKsDBNumberEdit.StrToValue(S: string): Extended;
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


{ ValidateKey }
procedure TKsDBNumberEdit.ValidateKey;
begin
  if FKey in ['.', ','] then
    FKey := FormatSettings.DecimalSeparator;
  if not (FKey in ['0'..'9', '.', ',', '-', #08, #27, ^X, ^C, ^V])
    or ((GetValue < 0) and (SelStart = 0) and (SelLength = 0) and (FKey <> '-'))
    or ((FKey = FormatSettings.DecimalSeparator) and (FDecimals = 0)) then
    begin
      MessageBeep(0);
      FKey := #0;
    end;
  if (FKey in [^H, ^V, ^X, '0'..'9', FormatSettings.DecimalSeparator]) and
     (DataSource.State in [dsinsert, dsedit]) then
     FDataLink.Edit
  else
  if FKey = #27 then
    begin
      FDataLink.Reset;
      SelectAll;
      FKey := #0;
    end;
end;


{ InvertValue }
procedure TKsDBNumberEdit.InvertValue;
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


{ EvalDecSeparator }
procedure TKsDBNumberEdit.EvalDecSeparator;
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


{ EvaluateKey }
procedure TKsDBNumberEdit.EvaluateKey;
var
  I, L: Integer;
begin
  L := Length(Text);
  I := Pos(FormatSettings.DecimalSeparator, Text );
  {edi��o dos decimais}
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


{ SetDecimals }
procedure TKsDBNumberEdit.SetDecimals(Dec: Byte);
begin
  FDecimals := Dec;
  DataChange(Self);
end;


{ IsActive }
function TKsDBNumberEdit.IsActive: Boolean;
var
  DtSrc: TDataSource;
begin
  Result := False;
  DtSrc := GetDataSource;
  if (DtSrc <> nil) and (DtSrc.Dataset <> nil) then
    Result := DtSrc.Dataset.Active
end;


{ CheckRange }
function TKsDBNumberEdit.CheckRange: Boolean;
begin
  Result := True;
  if IsActive and ((FMaxValue <> 0) or (FMinValue <> 0)) and
    ((GetValue > FMaxValue) or (GetValue < FMinValue)) then
    begin
      if Assigned(FOnOutOfRange) then
        FOnOutOfRange(Self)
      else
        MessageBeep(0);
      SelectAll;
      SetFocus;
      Result := False;
    end
end;

procedure TKsDBNumberEdit.SetShowSeparator(Value: Boolean);
begin
  if FShowSeparator <> Value then
    begin
      FShowSeparator := Value;
      Invalidate;
    end;
end;

{ Register }
procedure Register;
begin
  RegisterComponents('KingSoft', [TKsDBNumberEdit]);
end;

end.

