unit unKsDBGrid;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DB, DBGrids, ExtCtrls, StdCtrls, IniFiles;

type
  TKsSelColumnEvent = procedure(Sender: TObject; var Index: Integer) of object;
  TKsShowBoolean = (sbNormal, sbCheckBox, sbNewCheckBox);
  TKsGridStyle = (gsShow3D, gsColumnsColor, gsRowsColor, gsNormal);
  TKsShowScrollBar = (ssbNever, ssbAsNeeded, ssbAlways);

  TKsDBGrid = class(TCustomDBGrid)
  private
    FActiveRowColor: TColor;
    FBooleanFields: TStrings;
    FCanSelectColumn: Boolean;
    FEvenColor: TColor;
    FGridStyle: TKsGridStyle;
    FIniFile: TFileName;
    FLastColDown: Integer;
    FOddColor: TColor;
    FRowHeight: Integer;
    FSelectedColumn: Integer;
    FShowBoolean: TKsShowBoolean;
    FShowScrollBar: TKsShowScrollBar;
    FOnSelectColumn: TKsSelColumnEvent;
    procedure ChangeBoolean;
    procedure DrawCheckBox(ARect: TRect; Checked: Boolean);
    procedure GetBooleanFieldValues(AField: TField; var AFalse, ATrue: string);
    procedure SetActiveRowColor(Value: TColor);
    procedure SetBooleanFields(const Value: TStrings);
    procedure SetCanSelectColumn(Value: Boolean);
    procedure SetEvenColor(Value: TColor);
    procedure SetGridStyle(Value: TKsGridStyle);
    procedure SetOddColor(Value: TColor);
    procedure SetRowHeight(Value: Integer);
    procedure SetSelectedColumn(Value: Integer);
    procedure SetShowBoolean(Value: TKsShowBoolean);
    procedure SetShowScrollBar(const Value: TKsShowScrollBar);
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure WMChar(var Msg: TWMChar); message WM_CHAR;
    procedure WMNCCalcSize(var Msg: TMessage); message WM_NCCALCSIZE;
    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
    function IsBoolean(ACol: Longint): Boolean;
    function GetColumnIndex(FieldName: string): Integer;
    function GetIniFile: string;
    function GetFieldAsBoolean(AField: TField): Boolean;
  protected
    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    procedure DrawColumnCell(const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState); override;
    procedure LayoutChanged; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    function CanEditShow: Boolean; override;
    function DoMouseWheelDown(Shift: TShiftState;
      MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState;
      MousePos: TPoint): Boolean; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure ClearGridOptions;
    procedure RestoreGridOptions;
    procedure SaveGridOptions;
    procedure Update; override;
    property Canvas;
    property SelectedRows;
  published
    property ActiveRowColor: TColor read FActiveRowColor write SetActiveRowColor default $00FFF0F0;
    property Align;
    property Anchors;
    property BooleanFields: TStrings read FBooleanFields write SetBooleanFields;
    property BorderStyle;
    property CanSelectColumn: Boolean read FCanSelectColumn write SetCanSelectColumn default True;
    property Color default clBtnFace;
    property Columns stored StoreColumns;
    property Constraints;
    property Ctl3D;
    property DataSource;
    property DefaultDrawing;
    property DragCursor;
    property DragMode;
    property Enabled;
    property EvenColor: TColor read FEvenColor write SetEvenColor default $00ECF3F4;
    property FixedColor;
    property Font;
    property GridStyle: TKsGridStyle read FGridStyle write SetGridStyle default gsShow3D;
    property IniFile: TFileName read FIniFile write FIniFile;
    property OddColor: TColor read FOddColor write SetOddColor default $00DCE6DC;
    property Options;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property RowHeight: Integer read FRowHeight write SetRowHeight default 18;
    property SelectedColumn: Integer read FSelectedColumn write SetSelectedColumn default -1;
    property ShowBoolean: TKsShowBoolean read FShowBoolean write SetShowBoolean default sbNewCheckBox;
    property ShowScrollBar: TKsShowScrollBar read FShowScrollBar write SetShowScrollBar default ssbAsNeeded;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TitleFont;
    property Visible;
    property OnCellClick;
    property OnColEnter;
    property OnColExit;
    property OnColumnMoved;
    property OnDrawDataCell;
    property OnDrawColumnCell;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditButtonClick;
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
    property OnSelectColumn: TKsSelColumnEvent read FOnSelectColumn write FOnSelectColumn;
    property OnStartDock;
    property OnStartDrag;
    property OnTitleClick;
  end;

procedure Register;

implementation

{$J+}

const
  clEvenColor      = $00ECF3F4;
  clOddColor       = $00DCE6DC;
  clActiveRowColor = $00FFF0F0;


// Create
constructor TKsDBGrid.Create(AOwner: TComponent);
const
  bShareware: AnsiString = ':tcf:';
begin
  inherited Create(AOwner);
  Color := clWindow;
  FSelectedColumn := -1;
  FCanSelectColumn := True;
  FShowBoolean := sbNewCheckBox;
  FGridStyle := gsShow3D;
  FEvenColor := clEvenColor;
  FOddColor := clOddColor;
  FActiveRowColor := clActiveRowColor;
  FLastColDown := -1;
  FRowHeight := 16;
  FBooleanFields := TStringList.Create;
  FShowScrollBar := ssbAsNeeded;
end;


// Destroy
destructor TKsDBGrid.Destroy;
begin
  FBooleanFields.Free;
  inherited;
end;


// SetBooleanFields
procedure TKsDBGrid.SetBooleanFields(const Value: TStrings);
begin
  FBooleanFields.Assign(Value);
  Repaint;
end;


// SetCanSelectColumn
procedure TKsDBGrid.SetCanSelectColumn(Value: Boolean);
begin
  if FCanSelectColumn <> Value then
    begin
      FCanSelectColumn := Value;
      if not FCanSelectColumn then
        FSelectedColumn := -1;
      Invalidate;
    end;
end;


// SetSelectedColumn
procedure TKsDBGrid.SetSelectedColumn(Value: Integer);
begin
  if (Value >= 0) and (Value <= Columns.Count) then
    begin
      // permite ao usuáiro alterar a coluna selecionada
      if (FSelectedColumn <> Value) and Assigned(FOnSelectColumn) then
        FOnSelectColumn(Self, Value);
    end
  else
    Value := -1;
  // seleciona coluna
  if FSelectedColumn <> Value then
    begin
      FSelectedColumn := Value;
      Invalidate;
    end;
end;


// SetShowBoolean
procedure TKsDBGrid.SetShowBoolean(Value: TKsShowBoolean);
begin
  if FShowBoolean <> Value then
    begin
      FShowBoolean := Value;
      Invalidate;
    end;
end;


// SetShowScrollBar
procedure TKsDBGrid.SetShowScrollBar(const Value: TKsShowScrollBar);
begin
  if FShowScrollBar <> Value then
    begin
      FShowScrollBar := Value;
      RecreateWnd;
    end;
end;


// SetActiveRowColor
procedure TKsDBGrid.SetActiveRowColor(Value: TColor);
begin
  if FActiveRowColor <> Value then
    begin
      FActiveRowColor := Value;
      Invalidate;
    end;
end;


// SetEvenColor
procedure TKsDBGrid.SetEvenColor(Value: TColor);
begin
  if FEvenColor <> Value then
    begin
      FEvenColor := Value;
      Invalidate;
    end;
end;


// SetOddColor
procedure TKsDBGrid.SetOddColor(Value: TColor);
begin
  if FOddColor <> Value then
    begin
      FOddColor := Value;
      Invalidate;
    end;
end;


// SetGridStyle
procedure TKsDBGrid.SetGridStyle(Value: TKsGridStyle);
begin
  if FGridStyle <> Value then
    begin
      FGridStyle := Value;
      if FGridStyle = gsShow3D then
        Color := clBtnFace
      else
        Color := clWindow;
      Invalidate;
    end;
end;


// SetRowHeight
procedure TKsDBGrid.SetRowHeight(Value: Integer);
var
  K: Integer;
begin
  Canvas.Font := Font;
  K := Canvas.TextHeight('Wg') + 3;
  if dgRowLines in Options then
    Inc(K, GridLineWidth);
  if Value < K then
    Value := K;
  if (FGridStyle = gsShow3D) and Odd(Value) then
    Value := Value + 1;
  FRowHeight := Value;
  inherited DefaultRowHeight := FRowHeight;
  Invalidate;
end;


// CMFontChanged
procedure TKsDBGrid.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  SetRowHeight(FRowHeight);
end;


// DrawCell
procedure TKsDBGrid.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
  OldActRecord: Integer;
  IndOfst: Byte;
begin
  IndOfst := Byte(dgIndicator in Options);  // 1 se tem Indicator e 0 se não tem
  // títulos e colunas não booleanas
  if (gdFixed in AState) or (not IsBoolean(ACol)) or (not DefaultDrawing)
    or (FShowBoolean = sbNormal) then
    inherited
  else  // colunas booleanas
    begin
      DefaultDrawing := False;
      inherited;
      DefaultDrawing := True;
      OldActRecord := DataLink.ActiveRecord;
      try
        if dgTitles in Options then
          DataLink.ActiveRecord := ARow - 1
        else
          DataLink.ActiveRecord := ARow;
        if Assigned(Columns[ACol - IndOfst].Field) and DataLink.Active then
          DrawCheckBox(ARect, GetFieldAsBoolean(Columns[ACol - IndOfst].Field));
      finally
        DataLink.ActiveRecord := OldActRecord;
      end;
    end;
  // aspecto 3D
  if not (gdFixed in AState) and (dgColLines in Options) and (dgRowLines in Options)
    and (FGridStyle = gsShow3D) then
    begin
      ARect.Bottom := ARect.Bottom + 1;
      ARect.Right := ARect.Right + 1;
      Frame3d(Canvas, ARect, clBtnHighLight, clBtnShadow, 1);
    end
  else if (gdFixed in AState) and (ARow = 0) and (FSelectedColumn = ACol) then
    Frame3d(Canvas, ARect, clBtnShadow, clBtnHighLight, 1);  // titulo pressionado
  // foco
  if DefaultDrawing and (gdSelected in AState)
    and ((dgAlwaysShowSelection in Options) or Focused)
    and not (csDesigning in ComponentState) and not (dgRowSelect in Options) then
    begin
      Frame3d(Canvas, ARect, clActiveCaption, clActiveCaption, 1);
      InflateRect(ARect, 1, 1);
      Canvas.DrawFocusRect(ARect);
    end;
end;


// IsBoolean
function TKsDBGrid.IsBoolean(ACol: Longint): Boolean;
var
  IndOfst: Byte;
begin
  Result := False;
  IndOfst := Byte(dgIndicator in Options);  // 1 se tem Indicator e 0 se não tem
  if (ACol >= 0) and (ACol <= Columns.Count)
    and Assigned(Columns[ACol - IndOfst].Field) then
    begin
      Result := (Columns[ACol - IndOfst].Field.DataType = ftBoolean) or
        (FBooleanFields.IndexOfName(Columns[ACol - IndOfst].FieldName) >= 0);
    end;
end;


// GetFieldAsBoolean
function TKsDBGrid.GetFieldAsBoolean(AField: TField): Boolean;
var
  F, T: string;
begin
  if AField.DataType = ftBoolean then
    Result := AField.AsBoolean
  else
    begin
      GetBooleanFieldValues(AField, F, T);
      Result := (CompareText(AField.AsString, T) = 0);
    end;
end;


// GetBooleanFieldValues
procedure TKsDBGrid.GetBooleanFieldValues(AField: TField; var AFalse, ATrue: string);
var
  I: Integer;
  S: string;
begin
  S := FBooleanFields.Values[AField.FieldName];
  I := Pos(',', S);
  AFalse := Copy(S, 1, I-1);
  ATrue := Copy(S, I+1, Length(S));
end;


// DrawCheckBox
procedure TKsDBGrid.DrawCheckBox(ARect: TRect; Checked: Boolean);
var
  I, X, Y: Integer;
begin
  if not DataLink.Active then
    Exit;

  // limpa célula
  Canvas.FillRect(ARect);

  // calcula posição
  ARect.Top := (ARect.Top + ARect.Bottom - 12) div 2;
  ARect.Left := (ARect.Left + ARect.Right - 12) div 2;
  ARect.Bottom := ARect.Top + 13;
  ARect.Right := ARect.Left + 13;

  // desenha o box
  if FShowBoolean = sbNewCheckBox then
    begin
      Frame3D(Canvas, ARect, $0080511C, $0080511C, 1);
      Frame3D(Canvas, ARect, $00D6DFE2, $00EAF0F0, 1);
      Canvas.Brush.Color := $00EEF4F4;
      Canvas.FillRect(ARect);
      Canvas.Pen.Color := $0021A121;  // cor do Check
    end
  else
    begin
      Frame3D(Canvas, ARect, clBtnShadow, clBtnHighLight, 1);
      Frame3D(Canvas, ARect, clBlack, clBtnFace, 1);
      Canvas.Brush.Color := clWindow;
      Canvas.FillRect(ARect);
      Canvas.Pen.Color := clBlack;  // cor do Check
    end;

  // marca como true
  if Checked then
    for I := 1 to 3 do
      begin
        X := ARect.Left + 1;
        Y := ARect.Top + 2 + I;
        Canvas.Polyline([Point(X, Y), Point(X + 2, Y + 2), Point(X + 7, Y - 3)]);
      end;
end;


// LayoutChanged
procedure TKsDBGrid.LayoutChanged;
begin
  inherited LayoutChanged;
  SetRowHeight(FRowHeight);
end;


// CanEditShow
function TKsDBGrid.CanEditShow: Boolean;
begin
  Result := (inherited CanEditShow) and (not IsBoolean(Col));
end;


// WMChar
procedure TKsDBGrid.WMChar(var Msg: TWMChar);
begin
  if ((Msg.CharCode = VK_RETURN) or (Msg.CharCode = VK_SPACE))
    and IsBoolean(Col) and CanEditModify then
    begin
      ChangeBoolean;
      Msg.CharCode := 0;
    end;
  inherited;
end;


// MouseDown
procedure TKsDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  NCell: TGridCoord;
begin
  NCell := MouseCoord(X, Y);
  FLastColDown := NCell.X;
  // altera estado do checkbox
  if (NCell.X = Col) and (NCell.Y = Row) and IsBoolean(Col) and CanEditModify then
    ChangeBoolean
  else
    begin
      Canvas.Pen.Color := clGray;
      inherited MouseDown(Button, Shift, X, Y);
    end;
end;


// MouseUp
procedure TKsDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  NCell: TGridCoord;
begin
  NCell := MouseCoord(X, Y);
  // seleciona coluna
  if (NCell.Y = 0) and (dgTitles in Options) and FCanSelectColumn
    and (Button = mbLeft) and not (csDesigning in ComponentState) and
    not (gsColSizing = FGridState) and (NCell.X = FLastColDown) then
    SelectedColumn := NCell.X;
  inherited MouseUp(Button, Shift, X, Y);
end;


// Update
procedure TKsDBGrid.Update;
var
  OldColor: TColor;
begin
  // o Delphi e seus bugs...
  OldColor := Canvas.Pen.Color;
  inherited Update;
  Canvas.Pen.Color := OldColor;
end;


// ChangeBoolean
procedure TKsDBGrid.ChangeBoolean;
var
  IndOfst: Byte;
  F, T: string;
  I: Integer;
begin
  if DataLink.Active then
    begin
      if DataLink.DataSet.State = dsBrowse then
        DataLink.DataSet.Edit;
      IndOfst := Byte(dgIndicator in Options);  // 1 se tem Indicator e 0 se não tem
      if DataLink.DataSet.State in [dsEdit, dsInsert] then
        begin
          I := Col - IndOfst;
          if Columns[I].Field.DataType = ftBoolean then
            Columns[I].Field.AsBoolean := (not Columns[I].Field.AsBoolean)
          else
            begin
              GetBooleanFieldValues(Columns[I].Field, F, T);
              if CompareText(Columns[I].Field.AsString, T) = 0 then
                Columns[I].Field.AsString := F
              else
                Columns[I].Field.AsString := T;
            end;
        end;
      DrawCell(Col, Row, BoxRect(Col, Row, Col, Row), [gdSelected]);
    end;
end;


// ColumnMoved
procedure TKsDBGrid.ColumnMoved(FromIndex, ToIndex: Longint);
begin
  inherited ColumnMoved(FromIndex, ToIndex);
  if FCanSelectColumn then
    begin
      if FromIndex = SelectedColumn then
        SelectedColumn := ToIndex
      else if (ToIndex <= SelectedColumn) and (FromIndex > SelectedColumn) then
        SelectedColumn := SelectedColumn + 1
      else if (FromIndex <= SelectedColumn) and (ToIndex >= SelectedColumn) then
        SelectedColumn := SelectedColumn - 1;
    end;
end;


// WMNCCalcSize
procedure TKsDBGrid.WMNCCalcSize(var Msg: TMessage);
var
  Style: Integer;
begin
  if FShowScrollBar in [ssbNever, ssbAlways] then
    begin
      Style := GetWindowLong(Handle, GWL_STYLE);
      if (FShowScrollBar = ssbNever) and ((Style and WS_VSCROLL) <> 0) then
        Style := Style and not WS_VSCROLL
      else if (FShowScrollBar = ssbAlways) and ((Style and WS_VSCROLL) = 0) then
        Style := Style or WS_VSCROLL;
      SetWindowLong(Handle, GWL_STYLE, Style);
    end;
  inherited;
end;


// WMVScroll
procedure TKsDBGrid.WMVScroll(var Msg: TWMVScroll);
begin
  inherited;
  if Datalink.Active and (Msg.ScrollCode = SB_THUMBTRACK) and
    DataLink.DataSet.IsSequenced then
    DataLink.DataSet.MoveBy(Msg.Pos - DataLink.DataSet.RecNo + 0)
end;


// DrawColumnCell
procedure TKsDBGrid.DrawColumnCell(const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
var
  TitOfst: Byte;
  ARect: TRect;
  I: DWORD;
begin
  TitOfst := Byte(dgTitles in Options);  // 1 se tem título e 0 se não tem
  // sem alteração se 3D, normal ou cécula ativa (foco)
  if (FGridStyle = gsShow3D) or (FGridStyle = gsNormal) or (gdFocused in State)
    or ((DataLink.ActiveRecord = Row - TitOfst) and (dgRowSelect in Options)) then
    inherited DrawColumnCell(Rect, DataCol, Column, State)
  else
    begin
      if (DataLink.ActiveRecord = Row - TitOfst) and
        not (dgRowSelect in Options) then
        Canvas.Brush.Color := FActiveRowColor
      else if (FGridStyle = gsRowsColor) then
        begin
          if Odd(DataSource.DataSet.RecNo) then
            Canvas.Brush.Color := FOddColor
          else
            Canvas.Brush.Color := FEvenColor;
        end
      else if (FGridStyle = gsColumnsColor) then
        begin
          if Odd(DataCol + 1) then
            Canvas.Brush.Color := FOddColor
          else
            Canvas.Brush.Color := FEvenColor;
        end;
      // preenche com a cor e ajusta área do retângulo
      ARect := Rect;
      Canvas.FillRect(Rect);
      I := ColorToRGB(Canvas.Brush.Color);
      if GetNearestColor(Canvas.Handle, I) = I then
        ARect.Right := ARect.Right - 0
      else
        ARect.Right := ARect.Right - 2;
      // desenha célula
      DefaultDrawColumnCell(ARect, DataCol, Column, State);
      if Assigned(OnDrawColumnCell) then
        OnDrawColumnCell(Self, ARect, DataCol, Column, State);
    end;
end;


// DoMouseWheelDown
function TKsDBGrid.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := True;
  if Datalink.Active and (DataLink.DataSet.State in [dsBrowse]) then
    DataLink.DataSet.MoveBy(1);
end;


// DoMouseWheelUp
function TKsDBGrid.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := True;
  if Datalink.Active and (DataLink.DataSet.State in [dsBrowse]) then
    DataLink.DataSet.MoveBy(-1);
end;


// SaveGridOptions
procedure TKsDBGrid.SaveGridOptions;
var
  I: Integer;
  Section, Ident: string;
  IniCols: TIniFile;
begin
  IniCols := TIniFile.Create(GetIniFile);
  Section := TForm(Owner).ClassName + '.' + Name;
  // salva colunas
  for I := 0 to Columns.Count - 1 do
    begin
      Ident := 'Col' + IntToStr(I);
      IniCols.WriteString(Section, Ident + 'Field', Columns[I].FieldName);
      IniCols.WriteInteger(Section, Ident + 'Width', Columns[I].Width);
    end;
  // salva coluna selecionada
  IniCols.WriteInteger(Section, 'ColumnSelect', SelectedColumn);
  // salva estilos
  IniCols.WriteInteger(Section, 'Style', Integer(TKsGridStyle(FGridStyle)));
  IniCols.WriteInteger(Section, 'ActiveRowColor', FActiveRowColor);
  IniCols.WriteInteger(Section, 'EvenColor', FEvenColor);
  IniCols.WriteInteger(Section, 'OddColor', FOddColor);
  IniCols.Free;
end;


// RestoreGridOptions
procedure TKsDBGrid.RestoreGridOptions;
var
  I, ColPos, ColWidth: Integer;
  IndOfst: Byte;
  Section, Ident, FieldName: string;
  IniCols: TIniFile;
begin
  IndOfst := Byte(dgIndicator in Options);
  Section := TForm(Owner).ClassName + '.' + Name;
  IniCols := TIniFile.Create(GetIniFile);
  // restaura colunas
  for I := 0 to Columns.Count - 1 do
    begin
      Ident := 'Col' + IntToStr(I);
      FieldName := IniCols.ReadString(Section, Ident + 'Field', '');
      ColWidth := IniCols.ReadInteger(Section, Ident + 'Width', -1);
      ColPos := GetColumnIndex(FieldName);
      if ColPos >= 0 then
        begin
          MoveColumn(ColPos + IndOfst, I + IndOfst);
          Columns[I].Width := ColWidth;
        end;
    end;
  // restaura coluna selecionada
  SelectedColumn := IniCols.ReadInteger(Section, 'ColumnSelect', SelectedColumn);
  // restaura estilos
  FActiveRowColor := IniCols.ReadInteger(Section, 'ActiveRowColor', FActiveRowColor);
  FEvenColor := IniCols.ReadInteger(Section, 'EvenColor', FEvenColor);
  FOddColor := IniCols.ReadInteger(Section, 'OddColor', FOddColor);
  // muda a propriedade para outros ajustes
  GridStyle := TKsGridStyle(IniCols.ReadInteger(Section, 'Style',
    Integer(TKsGridStyle(FGridStyle))));
  IniCols.Free;
end;


// ClearGridOptions
procedure TKsDBGrid.ClearGridOptions;
begin
  with TIniFile.Create(GetIniFile) do
    EraseSection(TForm(Owner).ClassName + '.' + Name);
end;


// GetColumnIndex
function TKsDBGrid.GetColumnIndex(FieldName: string): Integer;
var
  I: Integer;
begin
  I := Columns.Count - 1;
  while (I >= 0) and (Columns[I].FieldName <> FieldName) do
    Dec(I);
  Result := I;
end;


// GetIniFile
function TKsDBGrid.GetIniFile: string;
var
  Dir: string;
begin
  Dir := ExtractFilePath(Application.ExeName);
  if Dir[Length(Dir)] <> '\' then
    Dir := Dir + '\';
  if FIniFile = '' then
    Result := Dir + ChangeFileExt(ExtractFileName(Application.ExeName), '.ini')
  else
    Result := Dir + ChangeFileExt(ExtractFileName(FIniFile), '.ini');
end;


// Register
procedure Register;
begin
  RegisterComponents('KingSoft', [TKsDBGrid]);
end;


end.

