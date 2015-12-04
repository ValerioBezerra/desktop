unit unKsDateEdit;

interface

uses
  Windows, SysUtils, Messages, Classes, Controls, Forms, Graphics, Menus,
  StdCtrls, Mask, Dialogs, ComCtrls, Grids, ExtCtrls, Buttons, Math;

type
  { TKsDateEdit }
  TRangeCentury = 0..99;
  TKsDateTime = Double;
  TKsDateEdit = class(TCustomMaskEdit)
  private
    FAlignment: TAlignment;
    FAssumeDefault: Boolean;
    FAutoHideCalendar: Boolean;
    FBaseChar: Char;
    FButton: TSpeedButton;
    FCanvas: TControlCanvas;
    FCentury: Boolean;
    FDate: TKsDateTime;
    FFocused: Boolean;
    FGlyph: TBitmap;
    FHintBtn: string;
    FShowButton: Boolean;
    FWinBack: TWinControl;
    FOverCentury: TRangeCentury;
    FOnBtnClick: TNotifyEvent;
    FOnDateError: TNotifyEvent;
    procedure ButtonClick(Sender: TObject);
    procedure ChangeGlyph(Sender: TObject);
    procedure CreateButton;
    procedure DateChange;
    procedure DateError;
    procedure DecodeStrDate(ADate: string; var Year, Month, Day: Word);
    procedure SetAlignment(Alig: TAlignment);
    procedure SetBaseChar(C: Char);
    procedure SetButtonSize;
    procedure SetCentury(Bool: Boolean);
    procedure SetClientRect;
    procedure SetDateText(S: string);
    procedure SetDateValue(ADate: TKsDateTime);
    procedure SetEnabledBtn(Value: Boolean);
    procedure SetGlyph(Value: TBitmap);
    procedure SetHintBtn(Value: string);
    procedure SetMask;
    procedure SetShowButton(const Value: Boolean);
    procedure SetShowCaret;
    procedure CMEnter(var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;
    procedure WMMouse(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMSetFocus(var Msg: TMessage); message WM_SETFOCUS;
    function AssumeDefaultDate(ADate: string): string;
    function DaysInMonth(Month, Year: Integer): Integer;
    function ExtractInvalidChar(S: string): string;
    function FormatStrDate(S: string): string;
    function GetCursorHeight: Integer;
    function GetDateEmpty: Boolean;
    function GetDateInStr(S: string): TDateTime;
    function GetDateText: string;
    function GetDateValue: TKsDateTime;
    function GetEditMask: string;
    function GetEnabledBtn: Boolean;
    function GetFormatMask: string;
    function GetMemberDate(S: string; Memb: Integer): string;
    function GetTextMargins: TPoint;
    function IsEmptyDate(S: string): Boolean;
    function IsLeapYear(Year: Word): Boolean;
    function IsValidDate(S: string): Boolean;
    function NoSpaces(S: string): string;
    function Val(S: string): Integer;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyPress(var Key: Char); override;
    procedure Change; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowCalendar;
    property DateEmpty: Boolean read GetDateEmpty;
  published
    property Anchors;
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property AssumeDefault: Boolean read FAssumeDefault write FAssumeDefault default True;
    property AutoHideCalendar: Boolean read FAutoHideCalendar write FAutoHideCalendar default True;
    property AutoSelect;
    property AutoSize;
    property BaseChar: Char read FBaseChar write SetBaseChar default '_';
    property BorderStyle;
    property Century: Boolean read FCentury write SetCentury default True;
    property Color;
    property Constraints;
    property Ctl3D;
    property DateText: string read GetDateText write SetDateText;
    property DateValue: TKsDateTime read GetDateValue write SetDateValue;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property EnabledBtn: Boolean read GetEnabledBtn write SetEnabledBtn default True;
    property Font;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property HideSelection;
    property HintBtn: string read FHintBtn write SetHintBtn;
    property OverCentury: TRangeCentury read FOverCentury write FOverCentury default 0;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property ShowButton: Boolean read FShowButton write SetShowButton default False;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnBtnClick: TNotifyEvent read FOnBtnClick write FOnBtnClick;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDateError: TNotifyEvent read FOnDateError write FOnDateError;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  { TFrmDateEdCal }
  TFrmDateEdCal = class(TForm)
    PanBack: TPanel;
    PanMonth: TPanel;
    StrGrid: TStringGrid;
    UpDownMonth: TUpDown;
    BtnClose: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure StrGridKeyPress(Sender: TObject; var Key: Char);
    procedure StrGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StrGridClick(Sender: TObject);
    procedure StrGridDblClick(Sender: TObject);
    procedure UpDownMonthClick(Sender: TObject; Button: TUDBtnType);
    procedure PanMonthMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanMonthMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BtnCloseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    FActiveDate: TDate;
    FBackColor: TColor;
    FChangingCel: Boolean;
    FLastX: Integer;
    FLastY: Integer;
    FOnwerEdt: TKsDateEdit;
    FTextColor: TColor;
    procedure MonthChanged;
    procedure SetColors(TextColor, BackColor: TColor);
    function BeginOfMonth(ADate: TDate): TDate;
    function Month(ADate: TDate): Word;
  end;

var
  FrmDateEdCal: TFrmDateEdCal;

procedure Register;

implementation

{$J+}
//{$R *.RES}
//{$R *.DFM}

const
  EMPTYDATE = -693594;
  IMAGE_RES = 'DATEED_CALEN';

{ TKsBtnDateEdit }

type
  TKsBtnDateEdit = class(TSpeedButton)
  private
    FCanvas: TControlCanvas;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;


// Create
constructor TKsBtnDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
end;


// Destroy
destructor TKsBtnDateEdit.Destroy;
begin
  FCanvas.Free;
  inherited Destroy;
end;


// Paint
procedure TKsBtnDateEdit.Paint;
var
  R: TRect;
begin
  inherited;
  if FState = bsUp then
    begin
      R := ClientRect;
      Frame3D(FCanvas, R, clBtnFace, clWindowFrame, 1);
      Frame3D(FCanvas, R, clBtnHighLight, clBtnShadow, 1);
    end;
end;


{ TKsDateEdit }

// Create
constructor TKsDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCanvas := TControlCanvas.Create;
  FCanvas.Control := Self;
  FAssumeDefault := True;
  FAutoHideCalendar := True;
  FBaseChar := '_';
  FCentury := True;
  FFocused := False;
  FDate := EMPTYDATE;
  FOverCentury := 0;
  FShowButton := False;
  CreateButton;
end;


// Destroy
destructor TKsDateEdit.Destroy;
begin
  FGlyph.Free;
  FButton.Free;
  FWinBack.Free;
  FCanvas.Free;
  inherited Destroy;
end;


// CreateParams
procedure TKsDateEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_AUTOHSCROLL or ES_MULTILINE or
    Alignments[FAlignment] or WS_CLIPCHILDREN;
end;


// CreateWnd
procedure TKsDateEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetClientRect;
end;


// SetAlignment
procedure TKsDateEdit.SetAlignment(Alig: TAlignment);
begin
  if Alig <> FAlignment then
    begin
      FAlignment := Alig;
      RecreateWnd;
      if Focused then
        SelectAll;
    end;
end;


// SetBaseChar
procedure TKsDateEdit.SetBaseChar(C: Char);
begin
  if (C <> FBaseChar) and (C <> #0) then
    begin
      FBaseChar := C;
      if not (csDesigning in ComponentState) then
        SetMask;
      DateChange;
      Invalidate;
    end;
end;


// SetCentury
procedure TKsDateEdit.SetCentury(Bool: Boolean);
begin
  if Bool <> FCentury then
    begin
      FCentury := Bool;
      if not (csDesigning in ComponentState) then
        SetMask;
      DateChange;
      Invalidate;
    end;
end;


// SetDateText
procedure TKsDateEdit.SetDateText(S: string);
begin
  FDate := GetDateInStr(FormatStrDate(S));
  DateChange;
end;


// SetDateValue
procedure TKsDateEdit.SetDateValue(ADate: TKsDateTime);
begin
  FDate := ADate;
  DateChange;
end;


// GetDateEmpty
function TKsDateEdit.GetDateEmpty: Boolean;
begin
  Result := (GetDateValue = EMPTYDATE);
end;


// GetDateText
function TKsDateEdit.GetDateText: string;
begin
  Result := FormatDateTime(GetFormatMask, FDate)
end;


// GetDateValue
function TKsDateEdit.GetDateValue: TKsDateTime;
begin
  Result := FDate;
end;


// SetGlyph
procedure TKsDateEdit.SetGlyph(Value: TBitmap);
begin
  if Value = nil then
    FGlyph.Handle := LoadBitmap(HInstance, IMAGE_RES)
  else
    FGlyph.Assign(Value);
end;


// ChangeGlyph
procedure TKsDateEdit.ChangeGlyph(Sender: TObject);
var
  NG: Byte;
begin
  FButton.Glyph := FGlyph;
  NG := 1;
  if not FGlyph.Empty then
    if (FGlyph.Width mod FGlyph.Height) = 0 then
      begin
        NG := FGlyph.Width div FGlyph.Height;
        if NG > 4 then
          NG := 1;
      end;
  FButton.NumGlyphs := NG;
end;


// GetEnabledBtn
function TKsDateEdit.GetEnabledBtn: Boolean;
begin
  Result := (FButton <> nil) and FButton.Enabled;
end;


// SetEnabledBtn
procedure TKsDateEdit.SetEnabledBtn(Value: Boolean);
begin
  if FButton <> nil then
    FButton.Enabled := Value;
end;


// SetHintBtn
procedure TKsDateEdit.SetHintBtn(Value: string);
begin
  if FHintBtn <> Value then
    begin
      FHintBtn := Value;
      FButton.Hint := Value;
    end;
end;


// SetShowButton
procedure TKsDateEdit.SetShowButton(const Value: Boolean);
begin
  FShowButton := Value;
  if not FShowButton then
    begin
      FWinBack.SetBounds(0, 0, 0, 0);
      FButton.SetBounds(0, 0, 0, 0);
      SetClientRect;
    end
  else
    begin
      SetButtonSize;
      SetClientRect;
    end;
  Invalidate;
end;


// Change
procedure TKsDateEdit.Change;
begin
  FDate := GetDateInStr(FormatStrDate(Text));
  inherited;
end;


// DateChange
procedure TKsDateEdit.DateChange;
begin
  if FDate <> EMPTYDATE then
    begin
      if FFocused then
        Text := FormatDateTime(GetFormatMask, FDate)
      else
        EditText := FormatDateTime(GetFormatMask, FDate);
    end
  else
    begin
      EditMask := '';
      if csDesigning in ComponentState then
        EditText := Name
      else
        EditText := '';
    end;
  if Focused then
    SelectAll;
end;


// KeyPress
procedure TKsDateEdit.KeyPress(var Key: Char);
var
  Form: TCustomForm;
begin
  if Ord(Key) in [VK_ESCAPE, VK_RETURN]  then
    begin
      Form := GetParentForm(Self);
      if Form <> nil then
        PostMessage(Form.Handle, CN_KEYDOWN, Ord(Key), 1);
      Key := #0;
    end
  else if CharInSet(Key, ['c', 'C']) and FButton.Enabled then
    begin
      FButton.OnClick(FButton);
      Key := #0;
    end
  else if Key = '.' then
    Key := FormatSettings.DateSeparator;
  inherited KeyPress(Key);
end;


// CMEnter
procedure TKsDateEdit.CMEnter(var Msg: TCMEnter);
begin
  if not FFocused then
    SetMask;
  inherited;
  SelectAll;
  FFocused := True;
  Invalidate;
end;


// CMExit
procedure TKsDateEdit.CMExit(var Msg: TCMExit);
var
  S: string;
begin
  S := FormatStrDate(Text);
  if (not IsValidDate(S)) and (not IsEmptyDate(S)) then
    begin
      if FAssumeDefault then
        Text := AssumeDefaultDate(S)
      else
        begin
          DateError;
          Exit;
        end;
    end
  else
    begin
      if not IsEmptyDate(S) then
        Text := AssumeDefaultDate(S);
      FFocused := False;
    end;
  FDate := GetDateInStr(Text);
  InvaliDate;
  inherited;
end;


// WMMouse
procedure TKsDateEdit.WMMouse(var Msg: TWMMouse);
begin
  if not Focused then
    begin
      inherited;
      SelectAll;
    end
  else
    inherited;
end;


// WMPaint
procedure TKsDateEdit.WMPaint(var Msg: TWMPaint);
var
  X, I: Integer;
  Rect: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
  Margins: TPoint;
begin
  if Focused and not (csPaintCopy in ControlState) then
    begin
      inherited;
      Exit;
    end;
  if (csDesigning in ComponentState) and (FDate = EMPTYDATE) then
    S := Name
  else if (FDate = EMPTYDATE) then
    S := ''
  else
    S := Text;
  DC := Msg.DC;
  if DC = 0 then
    DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    if not Enabled then
      FCanvas.Font.Color := clGrayText;
    //SendMessage(Handle, EM_GETRECT, 0, Longint(@Rect));
    Rect := ClientRect;
    if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
      begin
        FCanvas.Brush.Color := clWindowFrame;
        FCanvas.FrameRect(Rect);
        InflateRect(Rect, -1, -1);
      end;
    FCanvas.Brush.Color := Color;
    // calcula posi��o do texto
    Margins := GetTextMargins;
    X := Margins.X;
    if FShowButton then
      I := FButton.Width + 1
    else
      I := 0;
    case FAlignment of
      taRightJustify: X := Rect.Right - FCanvas.TextWidth(S) - Margins.X - 2 - I;
      taCenter: X := (Rect.Left + Rect.Right - FCanvas.TextWidth(S) - I) div 2;
    end;
    FCanvas.TextRect(Rect, X, Margins.Y, S);
  finally
    FCanvas.Handle := 0;
    if Msg.DC = 0 then
      EndPaint(Handle, PS);
  end;
end;


// WMSize
procedure TKsDateEdit.WMSize(var Msg: TWMSize);
begin
  inherited;
  SetButtonSize;
  SetClientRect;
end;


// WMSetFocus
procedure TKsDateEdit.WMSetFocus(var Msg: TMessage);
begin
  inherited;
  SetShowCaret;
end;


// SetShowCaret
procedure TKsDateEdit.SetShowCaret;
begin
  CreateCaret(Handle, 0, 1, GetCursorHeight);
  ShowCaret(Handle);
end;


// GetCursorHeight
function TKsDateEdit.GetCursorHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  try
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
  Result := Metrics.tmHeight;
end;


// FormatStrDate
function TKsDateEdit.FormatStrDate(S: string): string;
var
  D, M, Y: Word;
  Day, Month, Year: string;
begin
  S := ExtractInvalidChar(S) + FormatSettings.DateSeparator + FormatSettings.DateSeparator;
  Day := '00' + GetMemberDate(S, 1);
  Day := Copy(Day, Length(Day) - 1, 2);
  Month := '00' + GetMemberDate(S, 2);
  Month := Copy(Month, Length(Month) - 1, 2);
  Year := GetMemberDate(S, 3);
  if Year = '' then
    Year := '0000';
  DecodeDate(Date, Y, M, D);
  if (FOverCentury > 0) and (StrToInt(Year) > FOverCentury) and
    (Length(Year) < 3) then
    Y := Y - 100;
  Year := Copy(IntToStr(Y), 1, 4 - Length(Year)) + Year;
  Result := Day + FormatSettings.DateSeparator + Month + FormatSettings.DateSeparator + Year;
end;


// ExtractInvalidChar
function TKsDateEdit.ExtractInvalidChar(S: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    if CharInSet(S[I], ['0'..'9', FormatSettings.DateSeparator]) then
      Result := Result + S[I];
end;


// GetMemberDate
function TKsDateEdit.GetMemberDate(S: string; Memb: Integer): string;
var
  I, F, M: Integer;
begin
  I := 1;
  F := 1;
  M := 0;
  while Memb > M do
    begin
      while (F <= Length(S)) and (S[F] <> FormatSettings.DateSeparator) do
        Inc(F);
      Inc(M);
      if Memb > M then
        begin
          Inc(F);
          I := F;
        end;
    end;
  Result := Copy(S, I, F - I);
end;


// GetDateInStr
function TKsDateEdit.GetDateInStr(S: string): TDateTime;
var
  Day, Month, Year: Word;
begin
  if IsEmptyDate(S) then
    Result := EMPTYDATE
  else
    begin
      if not IsValidDate(S) then
        Result := EMPTYDATE
      else
        begin
          DecodeStrDate(S, Year, Month, Day);
          Result := EncodeDate(Year, Month, Day);
        end;
    end;
end;


// IsValidDate
function TKsDateEdit.IsValidDate(S: string): Boolean;
var
  Day, Month, Year: Word;
begin
  DecodeStrDate(S, Year, Month, Day);
  if (Day = 0) or (Month = 0) or (Month > 12)
    or (Day > DaysInMonth(Month, Year)) or (Year = 0) then
    Result := False
  else
    Result := True;
end;


// SetMask
procedure TKsDateEdit.SetMask;
var
  OldTime: TDateTime;
  S: string;
begin
  S := FormatStrDate(Text);
  OldTime := GetDateInStr(S);
  Text := '';
  EditMask := GetEditMask;
  if OldTime <> EMPTYDATE then
    Text := FormatDateTime(GetFormatMask, OldTime)
  else
    Text := '';
end;


// GetFormatMask
function TKsDateEdit.GetFormatMask: string;
begin
  Result := 'dd'+ FormatSettings.DateSeparator + 'mm' + FormatSettings.DateSeparator + 'yy';
  if FCentury then
    Result := Result + 'yy';
end;


// GetEditMask
function TKsDateEdit.GetEditMask: string;
begin
  Result := '!99'+ FormatSettings.DateSeparator + '99' + FormatSettings.DateSeparator + '99';
  if FCentury then
    Result := Result + '99';
  Result := Result + ';1;' + FBaseChar;
end;


// DaysInMonth
function TKsDateEdit.DaysInMonth(Month, Year: Integer): Integer;
const
  Days = '312831303130313130313031';
begin
  Result := Val(Copy(Days, (Month * 2) -1, 2));
  if (Month = 2) and IsLeapYear(Year) then
    Result := 29;
end;


// IsLeapYear
function TKsDateEdit.IsLeapYear(Year: Word): Boolean;
begin
  Result := (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0));
end;


// IsEmptyDate
function TKsDateEdit.IsEmptyDate(S: string): Boolean;
var
  I: Integer;
  N: string;
begin
  N := '';
  for I := 1 to Length(S) do
    if CharInSet(S[I], ['1'..'9']) then
      N := N + S[I];
  if N = '' then
    Result := True
  else
    Result := False;
end;


// AssumeDefaultDate
function TKsDateEdit.AssumeDefaultDate(ADate: string): string;
var
  AtDay, AtMonth, AtYear: Word;
  Day, Month, Year: Word;
begin
  DecodeDate(Date, AtYear, AtMonth, AtDay);  // data atual
  DecodeStrDate(ADate, Year, Month, Day);
  // ano
  if Year = 0 then
    Year := AtYear;
  // m�s
  if Month = 0 then
    Month := AtMonth
  else if Month > 12 then
    Month := 12;
  // dia
  if Day = 0 then
    Day := AtDay
  else if Day > DaysInMonth(Month, Year) then
    Day := DaysInMonth(Month, Year);
  // data assumida
  Result := FormatDateTime(GetFormatMask, EncodeDate(Year, Month, Day))
end;


// DecodeStrDate
procedure TKsDateEdit.DecodeStrDate(ADate: string; var Year, Month, Day: Word);
var
  D, M, Y: Word;
begin
  Day := Val(Copy(ADate, 1, 2));
  Month := Val(Copy(ADate, 4, 2));
  Year := Val(Copy(ADate, 7, 4));
  if Length(ADate) = 8 then
    begin
      DecodeDate(Date, Y, M, D);  // data atual
      Year := Year + ((Y div 100) * 100);
    end;
end;


// Val
function TKsDateEdit.Val(S: string): Integer;
begin
  S := NoSpaces(S);
  if S = '' then
    Result := 0
  else
    Result := StrToInt(S);
end;


// NoSpaces
function TKsDateEdit.NoSpaces(S: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    if S[I] <> ' ' then
      Result := Result + S[I];
end;


// DateError
procedure TKsDateEdit.DateError;
begin
  if Assigned(FOnDateError) then
    FOnDateError(Self)
  else
    MessageBeep(0);
  SelectAll;
  SetFocus;
end;


// GetTextMargins
function TKsDateEdit.GetTextMargins: TPoint;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  if NewStyleControls then
    begin
      if BorderStyle = bsNone then
        I := 0
      else if Ctl3D then
        I := 1
      else
        I := 2;
      Result.X := SendMessage(Handle, EM_GETMARGINS, 0, 0) and $0000FFFF + I;
      Result.Y := I;
    end
  else
    begin
      if BorderStyle = bsNone then
        I := 0
      else
        begin
          DC := GetDC(0);
          GetTextMetrics(DC, SysMetrics);
          SaveFont := SelectObject(DC, Font.Handle);
          GetTextMetrics(DC, Metrics);
          SelectObject(DC, SaveFont);
          ReleaseDC(0, DC);
          I := SysMetrics.tmHeight;
          if I > Metrics.tmHeight then
            I := Metrics.tmHeight;
          I := I div 4;
        end;
      Result.X := I;
      Result.Y := I;
    end;
end;


// CreateButton
procedure TKsDateEdit.CreateButton;
begin
  FWinBack := TWinControl.Create(Self);   // fundo do bot�o
  FWinBack.Parent := Self;
  FButton := TKsBtnDateEdit.Create(Self);
  FButton.Parent := FWinBack;
  FButton.OnClick := ButtonClick;
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := ChangeGlyph;
  FGlyph.Handle := LoadBitmap(HInstance, IMAGE_RES);
end;


// SetClientRect
procedure TKsDateEdit.SetClientRect;
var
  Rect: TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, Longint(@Rect));
  Rect.Bottom := ClientHeight + 1;  // +1 bug
  Rect.Right := ClientWidth - FButton.Width - 2;
  Rect.Top := 0;
  Rect.Left := 0;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Rect));
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Rect));  // debug
end;


// SetButtonSize
procedure TKsDateEdit.SetButtonSize;
begin
  if FShowButton then
    begin
      FWinBack.SetBounds(ClientWidth - ClientHeight - 1, 0,
        ClientHeight + 1, ClientHeight);
      FButton.SetBounds(1, 0, ClientHeight, ClientHeight);
    end
  else
    begin
      FWinBack.SetBounds(0, 0, 0, 0);
      FButton.SetBounds(0, 0, 0, 0);
    end;
end;


// ButtonClick
procedure TKsDateEdit.ButtonClick(Sender: TObject);
begin
  if Assigned(FOnBtnClick) then
    FOnBtnClick(Self)
  else
    ShowCalendar;
end;


// ShowCalendar
procedure TKsDateEdit.ShowCalendar;
var
  Pos: TPoint;
begin
    Application.CreateForm(TFrmDateEdCal, FrmDateEdCal);
  // define posi��o
  Pos := Point(0, 0);
  Pos := Self.ClientToScreen(Pos);
  if (Pos.X + 179) > Screen.DesktopWidth then
    FrmDateEdCal.Left := Pos.X - (FrmDateEdCal.Width - Width) - 2
  else
    FrmDateEdCal.Left := Pos.X - 2;
  if (Pos.Y + 131) > Screen.DesktopHeight then
    FrmDateEdCal.Top := Pos.Y - FrmDateEdCal.Height - 2
  else
    FrmDateEdCal.Top := Pos.Y + Height - 3;
  // mostra calculadora
  FrmDateEdCal.FOnwerEdt := Self;
  if GetDateValue = EMPTYDATE then
    FrmDateEdCal.FActiveDate := Date
  else
    FrmDateEdCal.FActiveDate := GetDateValue;
  FrmDateEdCal.MonthChanged;
  FrmDateEdCal.ShowModal;
  FrmDateEdCal.Free;
  FrmDateEdCal := nil;
end;


{ TFrmDateEdCal }

// FormCreate
procedure TFrmDateEdCal.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  FChangingCel := False;
  // cabe�alho das colunas
  for I := 0 to 6 do
    StrGrid.Cells[I, 0] := FormatSettings.ShortDayNames[I + 1];
end;


// FormActivate
procedure TFrmDateEdCal.FormActivate(Sender: TObject);
begin
  PanMonth.Color := clActiveCaption;
  PanMonth.Font.Color := clCaptionText;
end;


// FormDeactivate
procedure TFrmDateEdCal.FormDeactivate(Sender: TObject);
begin
  PanMonth.Color := clInactiveCaption;
  PanMonth.Font.Color := clInactiveCaptionText;
  if FOnwerEdt.AutoHideCalendar then
    Close;
end;


// SetColors
procedure TFrmDateEdCal.SetColors(TextColor, BackColor: TColor);
begin
  FTextColor := TextColor;
  FBackColor := BackColor;
end;


// StrGridDrawCell
procedure TFrmDateEdCal.StrGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  S: string;
  X, Y: Integer;
begin
  if gdFixed in State then
    SetColors(clActiveCaption, clBtnFace)
  else if (gdSelected in State) then
    SetColors(clCaptionText, clActiveCaption)
  else
    SetColors(clWindowText, clWindow);
  if not (gdFixed in State ) and
    (Month(Integer(StrGrid.Objects[ACol, ARow])) <> Month(FActiveDate)) then
    SetColors(clGrayText, FBackColor);
  with StrGrid do
    begin
      S := Cells[ACol, ARow];
      X := Rect.Left + ((DefaultColWidth - Canvas.TextWidth(S)) div 2);
      Y := Rect.Top + ((DefaultRowHeight - Canvas.TextHeight(S)) div 2);
      Canvas.Brush.Color := FBackColor;
      Canvas.Font.Color := FTextColor;
      Canvas.TextRect(Rect, X, Y, S);
    end;
end;


// BeginOfMonth
function TFrmDateEdCal.BeginOfMonth(ADate: TDate): TDate;
var
  Y, M, D: Word;
begin
  DecodeDate(ADate, Y, M, D);
  Result := EncodeDate(Y, M, 1);
end;


// MonthChanged
procedure TFrmDateEdCal.MonthChanged;
var
  I, J, K: Integer;
  X, Y: Byte;
  S: string;
begin
  I := DayOfWeek(BeginOfMonth(FActiveDate));
  J := Trunc(BeginOfMonth(FActiveDate)) - I + 1;
  for K := 0 to 41 do
    begin
      X := K mod 7;
      Y := (K div 7) + 1;
      StrGrid.Cells[X, Y] := FormatDateTime('d', J + K);
      StrGrid.Objects[X, Y] := TObject(J + K);
    end;
  //
  S := FormatDateTime('mmmm/yyyy', FActiveDate);
  S[1] := UpCase(S[1]);
  PanMonth.Caption := S;
  //
  FChangingCel := True;
  K := Trunc(FActiveDate - J);
  StrGrid.Col := K mod 7;
  StrGrid.Row := (K div 7) + 1;
  FChangingCel := False;
end;


// Month
function TFrmDateEdCal.Month(ADate: TDate): Word;
var
  Y, M, D: Word;
begin
  DecodeDate(ADate, Y, M, D);
  Result := M;
end;


// StrGridClick
procedure TFrmDateEdCal.StrGridClick(Sender: TObject);
var
  I: Integer;
begin
  if not FChangingCel then
    begin
      I := Integer(StrGrid.Objects[StrGrid.Col, StrGrid.Row]);
      if Month(FActiveDate) <> Month(I) then
        begin
          FActiveDate := I;
          MonthChanged;
        end
      else
        FActiveDate := I;
    end;
end;


// UpDownMonthClick
procedure TFrmDateEdCal.UpDownMonthClick(Sender: TObject; Button: TUDBtnType);
var
  Y, M, D: Word;
const
  AInc: array[TUDBtnType] of Integer = (1, -1);
  KEY_PRESSED = 128;
begin
  DecodeDate(FActiveDate, Y, M, D);
  if (GetKeyState(VK_SHIFT) and KEY_PRESSED) = KEY_PRESSED then
    Y := Y + AInc[Button]
  else if (GetKeyState(VK_CONTROL) and KEY_PRESSED) = KEY_PRESSED then
    Y := Y + (AInc[Button] * 10)
  else
    begin
      M := M + AInc[Button];
      if M > 12 then
        begin
          M := 1;
          Inc(Y);
        end
      else if M < 1 then
        begin
          M := 12;
          Dec(Y);
        end;
    end;
  D := Min(D, MonthDays[IsLeapYear(Y), M]);
  FActiveDate := EncodeDate(Y, M, D);
  MonthChanged;
end;


// PanMonthMouseDown
procedure TFrmDateEdCal.PanMonthMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FLastX := X;
  FLastY := Y;
end;


//PanMonthMouseMove
procedure TFrmDateEdCal.PanMonthMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then
    begin
      Left := Left + (X - FLastX);
      Top := Top + (Y - FLastY);
    end;
end;


// StrGridDblClick
procedure TFrmDateEdCal.StrGridDblClick(Sender: TObject);
begin
  FOnwerEdt.DateValue := FActiveDate;
  FOnwerEdt.SetFocus;
  FOnwerEdt.SelectAll;
  Close;
end;


// StrGridKeyPress
procedure TFrmDateEdCal.StrGridKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(VK_ESCAPE) then
    Close
  else if Key = Chr(VK_RETURN) then
    StrGridDblClick(Self)
end;


// BtnCloseClick
procedure TFrmDateEdCal.BtnCloseClick(Sender: TObject);
begin
  Close;
end;


// Register
procedure Register;
begin
  RegisterComponents('KingSoft', [TKsDateEdit]);
end;


//{$ENDIF}

end.
