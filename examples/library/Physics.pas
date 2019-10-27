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

program Physics;

uses
  SysUtils,
  GamePascal,
  uCommon;
              
const
  cScreenWidth  = 800;
  cScreenHeight = 600;  
  
type

  { TMyGame }
  TMyGame = class(TBaseGame)
  protected
    FFaint: TColor;
    FAvatar: TBitmap;
    LogoX: Integer;
    LogoY: Integer;
    NeedsReset: Boolean;
    Floor: TPhysicsBody;
    Circle: TPhysicsBody;
    BodiesCount: Integer;
    Timer: Single;
    procedure ResetBodies;
    procedure CleanBodies;          
  public
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnDisplayReady(aReady: Boolean); override;
    procedure OnUpdate(aDeltaTime: Single); override;
    procedure OnRender; override;
    procedure OnRenderGUI; override;
  end;  

{ --- TMyGame --------------------------------------------------------------- }
procedure TMyGame.ResetBodies;
var
  Body: TPhysicsBody;
begin
  Body := Physics_GetFirstBody;
  while Body <> nil do
  begin
    if Physics_GetBodyType(Body) = PhysicBody_Dynamic then
    begin
      Physics_DestroyBody(Body);
    end;
    Body := Physics_GetNextBody(Body);
  end;
end;

procedure TMyGame.CleanBodies;
var
  Body: TPhysicsBody;
  Pos: TVector;
begin
  Body := Physics_GetFirstBody;
  while Body <> nil do
  begin
    if Physics_GetBodyType(Body) = PhysicBody_Dynamic then
    begin
      Pos := Physics_GetBodyPosition(Body);
      if Pos.Y > cScreenHeight + 100 then
          Physics_DestroyBody(Body);
    end;
    Body := Physics_GetNextBody(Body);
  end;
end;

procedure TMyGame.OnStartup;
begin
  inherited;
  
  // open display
  Display_Open(-1, -1, cScreenWidth, cScreenHeight, cDisplayFullscreen,
    cDisplayVSync, True, cDisplayRenderAPI, 
    cDisplayTitle + 'Physics Demo');
  
  // load avatar
  FAvatar := Bitmap_Load(Archive, 'arc/textures/avatar.png', nil);
  
  // create color to draw a faint avatar in the back ground
  FFaint := Color_Createf(0.2, 0.2, 0.2, 0.2);
  
  Physics_Open;
  Physics_CreateRectangleBody(PhysicBody_Static, Vector(420,580), 500, 20);
  Physics_CreateCircleBody(PhysicBody_Static, Vector(420,300), 50);
  Physics_CreateCircleBody(PhysicBody_Dynamic, Vector(420,50), 50);
                   
  Audio_Open;
  Audio_MusicLoad(Archive, 'arc/music/Serious_HipHop.ogg');
  Audio_MusicSetLoop(True);
  Audio_MusicSetVolume(0.5);
  Audio_MusicPlay;       
end;

procedure TMyGame.OnShutdown;

begin
  Audio_MusicUnload;
  Audio_Close;
  Physics_Close;

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
var
  size: Integer;
begin
  inherited;
               
  // get mouse pos
  Mouse_GetInfo(FMousePos);
  
  if Keyboard_Pressed(KEY_1) or Mouse_Pressed(MOUSE_BUTTON_LEFT) then
  begin
    size := Random_Rangei(16, 64);
    //CreateBox(mx, my, size, size);
    Physics_CreateRectangleBody(PhysicBody_Dynamic, FMousePos, size, size);
  end;

  if Keyboard_Pressed(KEY_2) or Mouse_Pressed(MOUSE_BUTTON_RIGHT) then
  begin
    size := Random_Rangei(16, 64);
    Physics_CreateCircleBody(PhysicBody_Dynamic, FMousePos, size);
  end;

  if Keyboard_Pressed(KEY_R) then
  begin
    ResetBodies;
  end;      
       
  Physics_Update;
  CleanBodies;  
  
end;

procedure TMyGame.OnRender;
begin
  inherited;

  // draw avatar     
  Bitmap_Draw(FAvatar, cScreenWidth-64, cScreenHeight-64, nil, 
    @Vector(0.50, 0.50), @Vector(0.15, 0.15), 0, FFaint, False, False);
                     
  // render all wireframe bodies
  Physics_DrawBodyShapes;
end;

procedure TMyGame.OnRenderGUI;
begin
  inherited;
  
  PrintHudText(WHITE, Align_Left, 12, 'R           - Reset', []);
  PrintHudText(WHITE, Align_Left, 12, 'LMB/1       - Create Polygon Body', []);
  PrintHudText(WHITE, Align_Left, 12, 'RMB/2       - Create Circle Body', []);
end;
  
{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);
end.