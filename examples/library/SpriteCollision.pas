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

program SpriteCollision;

uses
  SysUtils,
  GamePascal,
  uCommon;

type

  { TMyGame }
  TMyGame = class(TBaseGame)
  protected
    FFaint: TColor;
    FAvatar: TBitmap;
    FSprite: array[0..1] of TSprite;
    FEntity: array[0..1] of TEntity;
    FPage: array[0..1] of Integer;
    FGroup: array[0..1] of Integer;
    FHitPos: TVector;
    FCollide: Boolean;
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
    cDisplayTitle + 'SpriteCollision Demo');

  // load avatar
  FAvatar := Bitmap_Load(Archive, 'arc/textures/avatar.png', nil);

  // create color to draw a faint avatar in the back ground
  FFaint := Color_Createf(0.2, 0.2, 0.2, 0.2);

  // get viewport size
  Display_GetViewportSize(vp);

  // create boss sprite
  FSprite[0] := Sprite_Create;
  FPage[0] := Sprite_LoadPage(FSprite[0], Archive, 'arc/sprites/boss.png',
    @COLORKEY);
  FGroup[0] := Sprite_AddGroup(FSprite[0]);
  Sprite_AddImageFromGrid(FSprite[0], 0, 0, 0, 0, 128, 128);
  Sprite_AddImageFromGrid(FSprite[0], 0, 0, 1, 0, 128, 128);
  Sprite_AddImageFromGrid(FSprite[0], 0, 0, 0, 1, 128, 128);

  // create figure sprite
  FSprite[1] := Sprite_Create;
  FPage[1] := Sprite_LoadPage(FSprite[1], Archive, 'arc/sprites/figure.png',
    @COLORKEY);
  FGroup[1] := Sprite_AddGroup(FSprite[1]);
  Sprite_AddImageFromGrid(FSprite[1], 0, 0, 0, 0, 128, 128);

  // create boss entity
  FEntity[0] := Entity_Create(FSprite[0], FGroup[0]);
  Entity_SetPosAbs(FEntity[0], vp.Width / 2, vp.Height / 2);
  Entity_TracePolyPoint(FEntity[0]);
  Entity_SetRenderPolyPoint(FEntity[0], True);

  // create figure entity
  FEntity[1] := Entity_Create(FSprite[1], FGroup[1]);
  Entity_SetPosAbs(FEntity[1], vp.Width / 2, vp.Height / 2);
  Entity_TracePolyPoint(FEntity[1]);
  Entity_SetRenderPolyPoint(FEntity[1], True);
end;

procedure TMyGame.OnShutdown;
begin
  // destroy entities
  Entity_Destroy(FEntity[1]);
  Entity_Destroy(FEntity[0]);

  // destroy sprite
  Sprite_Destroy(FSprite[1]);
  Sprite_Destroy(FSprite[0]);

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

  // rotate figure entity
  Entity_RotateRel(FEntity[1], (1.0 * aDeltaTime));

  // animate boss entity
  Entity_NextFrame(FEntity[0]);

  // rotate and move entity toward mouse position then come to a stop
  Entity_ThrustToPos(FEntity[0], 30, 14, FMousePos.X, FMousePos.Y, 128, 32, 3,
    0.001, aDeltaTime);

  // check for polypoint collisions between entityes and return the hit pos
  if Entity_CollidePolyPoint(FEntity[0], FEntity[1], FHitPos) then
    FCollide := true
  else
    FCollide := False;

end;

procedure TMyGame.OnRender;
begin
  inherited;

  // render entities
  Entity_Render(FEntity[1], 0, 0);
  Entity_Render(FEntity[0], 0, 0);

  // if entities collide show hit position
  if FCollide then
    Display_DrawFilledRectangle(FHitPos.X, FHitPos.Y, 10, 10, RED);

  // draw avatar     
  Bitmap_Draw(FAvatar, cDisplayWidth-64, cDisplayHeight-64, nil, @Vector(0.50, 0.50), @Vector(0.15, 0.15), 
    0, FFaint, False, False);

end;

procedure TMyGame.OnRenderGUI;
begin
  inherited;
end;

{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);

end.
