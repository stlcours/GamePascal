{$REGION 'Project Directives'}
// Modual Info
{$CONSOLEAPP}
{$MODULENAME            "..\bin\"}
{.$EXEICON              ".\bin\arc\icons\icon.ico"}
{$SEARCHPATH           "..\common"}
{.$ENABLERUNTIMETHEMES}
{.$HIGHDPIAWARE}

// Version Infp
{.$ADDVERSIONINFO}
{.$COMPANYNAME          "Company XYZ"}
{.$FILEVERSION          "1.0.0.0"}
{.$FILEDESCRIPTION      "Demo XYZ"}
{.$INTERNALNAME         "Demo XYZ"}
{.$LEGALCOPYRIGHT       "Copyright (c) 2015 Company XYZ"}
{.$LEGALTRADEMARK       "All Rights Reserved."}
{.$ORIGINALFILENAME     "DemoXYZ.exe"}
{.$PRODUCTNAME          "Demo XYZ"}
{.$PRODUCTVERSION       "1.0.0.0"}
{.$COMMENTS             "http://companyxyz.com"}

{$ENDREGION}

program Polygon;

uses
  SysUtils,
  GamePascal,
  uCommon;

const
  cMinScale = 4;
  cMaxScale = 200;
  cScaleFactor = 1.1;
  cLineThickness = 8;
  cRotationSpeed = 1;

type

  { TMyGame }
  TMyGame = class(TBaseGame)
  protected
    FFaint: TColor;
    FAvatar: TBitmap;
    FPolygon: TPolygon;
    FAngle: Single;
    FPause: Boolean;
    FScale: Single;
  public
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnDisplayReady(aReady: Boolean); override;
    procedure OnUpdate(aDeltaTime: Single); override;
    procedure OnRender; override;
    procedure OnRenderGUI; override;
  end;

  { --- TMyGame --------------------------------------------------------------- }

procedure TMyGame.OnStartup;
begin
  inherited;

  // open display
  Display_Open(-1, -1, cDisplayWidth, cDisplayHeight, cDisplayFullscreen,
    cDisplayVSync, True, cDisplayRenderAPI,
    cDisplayTitle + 'Polygon Demo');

  // load avatar
  FAvatar := Bitmap_Load(Archive, 'arc/textures/avatar.png', nil);

  // create color to draw a faint avatar in the back ground
  FFaint := Color_Createf(0.2, 0.2, 0.2, 0.2);

  // polygon
  FPolygon := Polygon_Create;
  Polygon_AddLocalPoint(FPolygon, -1, -1, True);
  Polygon_AddLocalPoint(FPolygon, 1, -1, True);
  Polygon_AddLocalPoint(FPolygon, 1, 1, True);
  Polygon_AddLocalPoint(FPolygon, -1, 1, True);
  Polygon_AddLocalPoint(FPolygon, -1, -1, True);

  // Init angle
  FAngle := 0;
  FScale := 50;
end;

procedure TMyGame.OnShutdown;
begin
  // destroy polygon
  Polygon_Destroy(FPolygon);

  // destroy avatar
  Bitmap_Unload(FAvatar);

  // close display
  Display_Close;

  inherited;
end;

procedure TMyGame.OnDisplayReady(aReady: Boolean);
begin
  inherited;
end;

procedure TMyGame.OnUpdate(aDeltaTime: Single);
begin
  inherited;

  // get mouse pos
  Mouse_GetInfo(FMousePos);

  // Toggle pause
  if Keyboard_Pressed(KEY_P) then
    FPause := not FPause;

  if Keyboard_Pressed(KEY_PGUP) then
  begin
    FScale := FScale * cScaleFactor;
    Clip_Valuef(FScale, cMinScale, cMaxScale, False);
  end
  else if Keyboard_Pressed(KEY_PGDN) then
  begin
    FScale := FScale / cScaleFactor;
    Clip_Valuef(FScale, cMinScale, cMaxScale, False);
  end;

  // Update angle
  if not FPause then
  begin
    FAngle := FAngle + (cRotationSpeed * aDeltaTime);
    Clip_Valuef(FAngle, 0, 360, True);
  end;

end;

procedure TMyGame.OnRender;
var
  VP: TRectangle;
begin
  inherited;

  // get viewport size
  Display_GetViewportSize(VP);

  // Render polygon
  Polygon_Render(FPolygon, VP.Width / 2, VP.Height / 2, FScale,
    FAngle, cLineThickness, YELLOW, nil, False, False);

  // draw avatar
  Bitmap_Draw(FAvatar, cDisplayWidth - 64, cDisplayHeight - 64, nil,
    @Vector(0.50, 0.50), @Vector(0.15, 0.15),
    0, FFaint, False, False);
end;

procedure TMyGame.OnRenderGUI;
begin
  inherited;
  PrintHudText(WHITE, Align_Left, 12, 'P           - Pause', []);
  PrintHudText(WHITE, Align_Left, 12, 'PgUp/PgDn   - Scale', []);
  PrintHudText(ORANGE, Align_Left, 12, 'Scale       : %3.2f ', [FScale]);

end;

{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);

end.
