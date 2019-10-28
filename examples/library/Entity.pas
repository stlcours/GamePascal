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

program Entity;

uses
  SysUtils,
  GamePascal,
  uCommon;

type

  { TMyGame }
  TMyGame = class(TBaseGame)
  protected
    FAvatar: TBitmap;
    FFaint: TColor;
    FSprite: TSprite;
    FEntity: TEntity;
    FPage: Integer;
    FGroup: Integer;
    FOrigin: TVector;
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
  VP: TRectangle;
begin
  inherited;

  // open display
  Display_Open(-1, -1, cDisplayWidth, cDisplayHeight, cDisplayFullscreen,
    cDisplayVSync, cDisplayaAntiAlias, cDisplayRenderAPI,
    cDisplayTitle + 'Entity Demo');

  // load bitmaps
  FAvatar := Bitmap_Load(Archive, 'arc/textures/avatar.png', nil);

  // create color to draw a faint avatar in the back ground
  FFaint := Color_Createf(0.2, 0.2, 0.2, 0.2);

  // get viewport size
  Display_GetViewportSize(VP);

  // create sprite object
  FSprite := Sprite_Create;

  // FYI: sprites can be organized into groups across several pages. load in
  //      sprites onto page and then assign images into groups.

  // load a sprite with animation frame onto a page
  //FPage := Sprite_LoadPage(FSprite, Archive, 'arc/sprites/boss.png', @COLORKEY);
  FPage := Sprite_LoadPage(FSprite, Archive, 'arc/sprites/boss.png', nil);

  // create a group to organize this sprite
  FGroup := Sprite_AddGroup(FSprite);

  // add the frame of animation from the page in grid format
  Sprite_AddImageFromGrid(FSprite, 0, 0, 0, 0, 128, 128);
  Sprite_AddImageFromGrid(FSprite, 0, 0, 1, 0, 128, 128);
  Sprite_AddImageFromGrid(FSprite, 0, 0, 0, 1, 128, 128);

  // create entity from sprite group, by default animation is set to 15 fps
  FEntity := Entity_Create(FSprite, FGroup);

  // intially center entity on screen
  Entity_SetPosAbs(FEntity, Vp.Width / 2, vp.Height / 2);
end;

procedure TMyGame.OnShutdown;
begin
  // destroy entity
  Entity_Destroy(FEntity);

  // destroy sprite
  Sprite_Destroy(FSprite);

  // destrooy avatar
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

  // animate entity
  Entity_NextFrame(FEntity);

  // rotate and move entity toward mouse position then come to a stop
  Entity_ThrustToPos(FEntity, 30, 14, MousePos.X, MousePos.Y, 128, 32, 5,
    0.001, aDeltaTime);

end;

procedure TMyGame.OnRender;
begin
  inherited;

  // draw avatar
  Bitmap_Draw(FAvatar, 240, 300, nil, @Vector(0.5, 0.5), @Vector(0.26, 0.26),
    0, FFaint, False, False);

  // render entity
  Entity_Render(FEntity, 0, 0);
end;

procedure TMyGame.OnRenderGUI;
begin
  inherited;
end;

{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);

end.
