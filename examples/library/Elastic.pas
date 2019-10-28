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

program Elastic;

uses
  SysUtils,
  GamePascal,
  uCommon;

const
  // beads
  cGravity = 0.04;
  cXDecay = 0.97;
  cYDecay = 0.97;
  cBeadCount = 10;
  cXElasticity = 0.02;
  cYElasticity = 0.02;
  cWallDecay = 0.9;
  cSlackness = 1;
  cBeadSize = 12;
  cBedHalfSize = cBeadSize / 2;
  cBeadFilled = True;

type
  { TBead }
  TBead = record
    X: Single;
    Y: Single;
    XMove: Single;
    YMove: Single;
  end;

  { TMyGame }
  TMyGame = class(TBaseGame)
  protected
    FAvatar: TBitmap;
    FFaint: TColor;
    FViewWidth: Single;
    FViewHeight: Single;
    FBead: array[0..cBeadCount] of TBead;
    FTimer: Single;
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
var
  vp: TRectangle;
begin
  inherited;
  // open display
  Display_Open(-1, -1, cDisplayWidth, cDisplayHeight, cDisplayFullscreen,
    cDisplayVSync, cDisplayaAntiAlias, cDisplayRenderAPI,
    cDisplayTitle + 'Elastic Demo');

  // load avatar
  FAvatar := Bitmap_Load(Archive, 'arc/textures/avatar.png', nil);

  // create color to draw a faint avatar in the back ground
  FFaint := Color_Createf(0.2, 0.2, 0.2, 0.2);

  // init data
  FillChar(FBead, SizeOf(FBead), 0);

  // init audio
  Audio_Open;
  Audio_MusicLoad(Archive, 'arc\music\nightmere.ogg');
  Audio_MusicSetLoop(True);
  Audio_MusicSetOffset(8);
  Audio_MusicPlay;

  // set the view port size
  Display_GetViewportSize(vp);
  FViewWidth := vp.Width;
  FViewHeight := vp.Height;

end;

procedure TMyGame.OnShutdown;
begin
  Bitmap_Unload(FAvatar);
  Audio_MusicUnload;
  Audio_Close;
  Display_Close;

  inherited;
end;

procedure TMyGame.OnDisplayReady(aReady: Boolean);
begin
  inherited;
  { TODO: Todo test 1 }
end;

procedure TMyGame.OnUpdate(aDeltaTime: Single);
var
  i: Integer;
  Dist, DistX, DistY: Single;
begin
  inherited;

  if not Time_FrameSpeed(FTimer, Engine_GetTargetSpeed) then
    Exit;

  Mouse_GetInfo(FMousePos);

  FBead[0].X := FMousePos.X;
  FBead[0].Y := FMousePos.Y;

  if FBead[0].X - (cBeadSize + 10) / 2 < 0 then
  begin
    FBead[0].X := (cBeadSize + 10) / 2;
  end;

  if FBead[0].X + ((cBeadSize + 10) / 2) > FViewWidth then
  begin
    FBead[0].X := FViewWidth - (cBeadSize + 10) / 2;
  end;

  if FBead[0].Y - ((cBeadSize + 10) / 2) < 0 then
  begin
    FBead[0].Y := (cBeadSize + 10) / 2;
  end;
  //TODO: Todo test 4
  if FBead[0].Y + ((cBeadSize + 10) / 2) > FViewHeight then
  begin
    FBead[0].Y := FViewHeight - (cBeadSize + 10) / 2;
  end;

  // loop though other beads
  for i := 1 to cBeadCount do
  begin
    // calc X and Y distance between the bead and the one before it
    DistX := FBead[i].X - FBead[i - 1].X;
    DistY := FBead[i].Y - FBead[i - 1].Y;

    // calc total distance
    Dist := sqrt(DistX * DistX + DistY * DistY);

    // if the beads are far enough apart, decrease the movement to create elasticity
    if Dist > cSlackness then
    begin
      FBead[i].XMove := FBead[i].XMove - (cXElasticity * DistX);
      FBead[i].YMove := FBead[i].YMove - (cYElasticity * DistY);
    end;

    // if bead is not last bead
    if i <> cBeadCount then
    begin
      // calc distances between the bead and the one after it
      DistX := FBead[i].X - FBead[i + 1].X;
      DistY := FBead[i].Y - FBead[i + 1].Y;
      Dist := sqrt(DistX * DistX + DistY * DistY);

      // if beads are far enough apart, decrease the movement to create elasticity
      if Dist > 1 then
      begin
        FBead[i].XMove := FBead[i].XMove - (cXElasticity * DistX);
        FBead[i].YMove := FBead[i].YMove - (cYElasticity * DistY);
      end;
    end;

    // decay the movement of the beads to simulate loss of energy
    FBead[i].XMove := FBead[i].XMove * cXDecay;
    FBead[i].YMove := FBead[i].YMove * cYDecay;

    // apply cGravity to bead movement
    FBead[i].YMove := FBead[i].YMove + cGravity;

    // move beads
    FBead[i].X := FBead[i].X + FBead[i].XMove;
    FBead[i].Y := FBead[i].Y + FBead[i].YMove;

    // ff the beads hit a wall, make them bounce off of it
    if FBead[i].X - ((cBeadSize + 10) / 2) < 0 then
    begin
      FBead[i].X := FBead[i].X + (cBeadSize + 10) / 2;
      FBead[i].XMove := -FBead[i].XMove * cWallDecay;
    end;

    if FBead[i].X + ((cBeadSize + 10) / 2) > FViewWidth then
    begin
      FBead[i].X := FViewWidth - (cBeadSize + 10) / 2;
      FBead[i].xMove := -FBead[i].XMove * cWallDecay;
    end;

    if FBead[i].Y - ((cBeadSize + 10) / 2) < 0 then
    begin
      FBead[i].YMove := -FBead[i].YMove * cWallDecay;
      FBead[i].Y := (cBeadSize + 10) / 2;
    end;

    if FBead[i].Y + ((cBeadSize + 10) / 2) > FViewHeight then
    begin
      FBead[i].YMove := -FBead[i].YMove * cWallDecay;
      FBead[i].Y := FViewHeight - (cBeadSize + 10) / 2;
    end;
  end;
end;

procedure TMyGame.OnRender;
var
  I: Integer;
begin
  inherited;
  {TODO: Todo test 2 }
  Bitmap_Draw(FAvatar, 240, 300, nil, @Vector(0.5, 0.5), @Vector(0.26, 0.26),
    0, FFaint, False, False);

  // draw last bead
  Display_DrawFilledRectangle(FBead[0].X, FBead[0].Y, cBeadSize, cBeadSize,
    GREEN);

  // loop though other beads
  for I := 1 to cBeadCount do
  begin
    // draw bead and string from it to the one before it
    Display_DrawLine(FBead[i].x + cBedHalfSize, FBead[i].y + cBedHalfSize,
      FBead[i - 1].x + cBedHalfSize, FBead[i - 1].y + cBedHalfSize, YELLOW, 1);
    Display_DrawFilledRectangle(FBead[i].X, FBead[i].Y, cBeadSize, cBeadSize,
      GREEN);
  end;

end;

procedure TMyGame.OnRenderGUI;
begin
  inherited;
end;

{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);
  // TODO: Todo test 3
end.
