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

program Scroll;

uses
  SysUtils,
  GamePascal,
  uCommon;
  
const
  cScreenWidth = 800;
  cScreenHeight = 600;


  // player
  PLAYER_TURNRATE            = 2.7;
  PLAYER_FRICTION            = 0.005;
  PLAYER_ACCEL               = 0.1;
  PLAYER_MAGNITUDE           = 10;
  PLAYER_SIZE_HALF           = 32.0;
  PLAYER_FRAME_FPS           = 12;
  PLAYER_FRAME_NEUTRAL       = 0;
  PLAYER_FRAME_FIRST         = 1;
  PLAYER_FRAME_LAST          = 3;
  PLAYER_TURN_ACCEL          = 0.6;
  PLAYER_TURN_MAX            = 4.0;
  PLAYER_TURN_DRAG           = 0.3;  
             
type

  TViewport = record
    Move     : Single;
    Bounce   : Single;
    Dir      : TVector;
    FixOffset: TVector;
    RunAhead : TVector;
    Pos      : TVector;
  end;

  TPlayer = record
    Timer    : Single;
    Frame    : Integer;
    Thrusting: Boolean;
    Angle    : Single;
    Dir      : TVector;
    WorldPos : TVector;
    ScreenPos: TVector;
    TurnSpeed: Single;
  end;

  { TMyGame }
  TMyGame = class(TBaseGame)
  protected
    FFaint: TColor;
    FAvatar: TBitmap;
    FTimer      : Single;
    FColor      : TColor;
    FBackground : array[0..3] of TBitmap;
    FPlanet     : TBitmap;
    FViewport   : TViewport;
    FPlayer     : TPlayer;
    FSprite     : TSprite;      
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
  Display_Open(-1, -1, cScreenWidth, cScreenHeight, cDisplayFullscreen,
    cDisplayVSync, cDisplayaAntiAlias, cDisplayRenderAPI, 
    cDisplayTitle + 'Scroll Demo');
  
  // load avatar
  FAvatar := Bitmap_Load(Archive, 'arc/textures/avatar.png', nil);
  
  // create color to draw a faint avatar in the back ground
  FFaint := Color_Createf(0.2, 0.2, 0.2, 0.2);
  
  // init colors
  FColor := WHITE;
  FColor.Alpha := 128;

  // init textures
  FBackground[0] := Bitmap_Load(Archive, 'arc/backgrounds/space.png',  nil);
  FBackground[1] := Bitmap_Load(Archive, 'arc/backgrounds/nebula.png', @BLACK);
  FBackground[2] := Bitmap_Load(Archive, 'arc/backgrounds/spacelayer1.png', @BLACK);
  FBackground[3] := Bitmap_Load(Archive, 'arc/backgrounds/spacelayer2.png', @BLACK);

  FPlanet := Bitmap_Load(Archive, 'arc/backgrounds/Planet.png', nil);

  // init spirtes
  FSprite := Sprite_Create;
  Sprite_LoadPage(FSprite, Archive, 'arc/sprites/ship.png', nil);
  Sprite_AddGroup(FSprite);
  Sprite_AddImageFromGrid(FSprite, 0, 0, 0, 0, 64, 64);
  Sprite_AddImageFromGrid(FSprite, 0, 0, 1, 0, 64, 64);
  Sprite_AddImageFromGrid(FSprite, 0, 0, 2, 0, 64, 64);
  Sprite_AddImageFromGrid(FSprite, 0, 0, 3, 0, 64, 64);

  FillChar(FViewport, SizeOf(FViewport), 0);
  FillChar(FPlayer, SizeOf(FPlayer), 0);

  FViewport.Move       := 0.004;
  FViewport.Bounce     := 1.10;
  FViewport.RunAhead.X := 45;
  FViewport.RunAhead.Y := 35;
  FViewport.Pos.X      := 1000;
  FViewport.Pos.Y      := 1000;
  FPlayer.Angle        := 0;
  FPlayer.WorldPos.X   := cScreenWidth  / 2;
  FPlayer.WorldPos.Y   := cScreenHeight / 2;

  Audio_Open;
  Audio_MusicLoad(Archive, 'arc/music/deliverance.ogg');
  Audio_MusicPlay;
  Audio_MusicSetLoop(True);
  Audio_MusicSetVolume(0.7);       
end;

procedure TMyGame.OnShutdown;
begin
  Audio_Close;
  Sprite_Destroy(FSprite);
  Bitmap_Unload(FPlanet);
  Bitmap_Unload(FBackground[3]);
  Bitmap_Unload(FBackground[2]);
  Bitmap_Unload(FBackground[1]);
  Bitmap_Unload(FBackground[0]);  
  
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
  
  // update keys
  if Keyboard_Down(KEY_RIGHT) then
  begin
    SmoothMove(FPlayer.TurnSpeed, PLAYER_TURN_ACCEL*aDeltaTime, PLAYER_TURN_MAX, PLAYER_TURN_DRAG*aDeltaTime);
  end
  else if Keyboard_Down(KEY_LEFT) then
    begin
      SmoothMove(FPlayer.TurnSpeed, -PLAYER_TURN_ACCEL*aDeltaTime, PLAYER_TURN_MAX, PLAYER_TURN_DRAG*aDeltaTime);
    end
  else
    begin
      SmoothMove(FPlayer.TurnSpeed, 0, PLAYER_TURN_MAX, PLAYER_TURN_DRAG*aDeltaTime);
    end;

  FPlayer.Angle := FPlayer.Angle + (FPlayer.TurnSpeed*aDeltaTime);
  if FPlayer.Angle > 360 then
    FPlayer.Angle := FPlayer.Angle - 360
  else if FPlayer.Angle < 0 then
    FPlayer.Angle := FPlayer.Angle + 360;

  FPlayer.Thrusting := False;
  if (Keyboard_Down(KEY_UP)) then
  begin
    FPlayer.Thrusting := True;

    //if (Vector_Magnitude(FPlayer.Dir) < PLAYER_MAGNITUDE) then
    if (FPlayer.Dir.Magnitude < PLAYER_MAGNITUDE) then
    begin
      //Vector_Thrust(FPlayer.Dir, FPlayer.Angle, PLAYER_ACCEL*aDeltaTime);
      FPlayer.Dir.Trust(FPlayer.Angle, PLAYER_ACCEL*aDeltaTime);
    end;
  end;

  SmoothMove(FPlayer.Dir.X, 0, PLAYER_MAGNITUDE, PLAYER_FRICTION*aDeltaTime);
  SmoothMove(FPlayer.Dir.Y, 0, PLAYER_MAGNITUDE, PLAYER_FRICTION*aDeltaTime);

  FPlayer.WorldPos.X := FPlayer.WorldPos.X + (FPlayer.Dir.X*aDeltaTime);
  FPlayer.WorldPos.Y := FPlayer.WorldPos.Y + (FPlayer.Dir.Y*aDeltaTime);

  if (FPlayer.Thrusting) then
    begin
      if (Time_FrameSpeed(FPlayer.Timer, PLAYER_FRAME_FPS)) then
      begin
        FPlayer.Frame := FPlayer.Frame + 1;
        if (FPlayer.Frame > PLAYER_FRAME_LAST) then
        begin
          FPlayer.Frame := PLAYER_FRAME_FIRST;
        end
      end
    end
  else
    begin
      FPlayer.Timer := 0;
      FPlayer.Frame := PLAYER_FRAME_NEUTRAL;
    end;

  if Time_FrameSpeed(FTimer, Engine_GetTargetSpeed) then
  begin
    // update world
    FViewport.Dir.X := (FViewport.Dir.X+(FPlayer.WorldPos.X - FViewport.Fixoffset.X - FViewport.Pos.X + FViewport.RunAhead.X * FPlayer.Dir.X) * FViewport.Move) / FViewport.Bounce;
    FViewport.Dir.Y := (FViewport.Dir.Y+(FPlayer.WorldPos.Y - FViewport.Fixoffset.y - FViewport.Pos.Y + FViewport.RunAhead.Y * FPlayer.Dir.Y) * FViewport.Move) / FViewport.Bounce;
    FViewport.Pos.X := FViewport.Pos.X + FViewport.Dir.X;
    FViewport.Pos.Y := FViewport.Pos.Y + FViewport.Dir.Y;

    // update FPlayer
    FPlayer.ScreenPos.X := FPlayer.WorldPos.X - FViewport.Pos.X + cScreenWidth  /2;
    FPlayer.ScreenPos.Y := FPlayer.WorldPos.Y - FViewport.Pos.Y + cScreenHeight /2;
  end;      
    
end;

procedure TMyGame.OnRender;
var
  Origin: TVector;
begin
  inherited;
    
  // render FBackground
  Bitmap_DrawTiled(FBackground[0], -(FViewport.Pos.X/1.9), -(FViewport.Pos.Y/1.9));
  Display_SetBlendMode(Blend_AdditiveAlpha);
  Bitmap_DrawTiled(FBackground[1], -(FViewport.Pos.X/1.9), -(FViewport.Pos.Y/1.9));
  Display_RestoreDefaultBlendMode;
  Bitmap_DrawTiled(FBackground[2], -(FViewport.Pos.X/1.6), -(FViewport.Pos.Y/1.6));
  Bitmap_DrawTiled(FBackground[3], -(FViewport.Pos.X/1.3), -(FViewport.Pos.Y/1.3));

  Origin.X := 0.50;
  Origin.Y := 0.50;
  Bitmap_Draw(FPlanet, -(FViewport.Pos.X/1.0)+(cScreenWidth), -(FViewport.Pos.Y/1.0)+(cScreenHeight), nil, @Origin, nil, 0.0, WHITE, False, False);

  // render FPlayer
  Sprite_DrawImage(FSprite, FPlayer.Frame, 0, FPlayer.ScreenPos.X, FPlayer.ScreenPos.Y, @Origin, nil, FPlayer.Angle, WHITE, False, False, False);

  // draw avatar     
  Bitmap_Draw(FAvatar, cScreenWidth-64, cScreenHeight-64, nil, @Vector(0.50, 0.50), @Vector(0.15, 0.15), 
    0, FFaint, False, False);
    

end;

procedure TMyGame.OnRenderGUI;
begin
  inherited;
  
  PrintHudText(WHITE, Align_Left, 12, 'Left        - Rotate Left', []);
  PrintHudText(WHITE, Align_Left, 12, 'Right       - Rotate Right', []);
  PrintHudText(WHITE, Align_Left, 12, 'Up          - Trust', []);
  PrintHudText(ORANGE, Align_Left, 12, 'Pos         [X:%7.3f, Y:%7.3f]', [FPlayer.WorldPos.X, FPlayer.WorldPos.Y]);
  
end;
  
{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);
      
end.