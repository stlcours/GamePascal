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

program Sounds;

uses
  SysUtils,
  GamePascal,
  uCommon;
           
const
  cMusicFilenames: array[0..0] of string = (
    'arc/music/hitman.ogg'
  );

  cSoundFilenames: array[0..4] of string = (
    'arc/sounds/samp0.ogg',
    'arc/sounds/samp1.ogg',
    'arc/sounds/samp2.ogg',
    'arc/sounds/samp3.ogg',
    'arc/sounds/samp4.ogg'
  );  
    
type

  { TMyGame }
  TMyGame = class(TBaseGame)
  protected
    FFaint: TColor;
    FAvatar: TBitmap;
    FStarfield: TStarfield;
    FSound: array[0..4] of Integer;
    FChan: Integer;      
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
  i: Integer;
begin
  inherited;
  
  // open display
  Display_Open(-1, -1, cDisplayWidth, cDisplayHeight, cDisplayFullscreen,
    cDisplayVSync, cDisplayaAntiAlias, cDisplayRenderAPI, 
    cDisplayTitle + 'Sounds Demo');
  
  // load avatar
  FAvatar := Bitmap_Load(Archive, 'arc/textures/avatar.png', nil);
  
  // create color to draw a faint avatar in the back ground
  FFaint := Color_Createf(0.2, 0.2, 0.2, 0.2);
  
  // init starfield
  FStarfield := Starfield_Create;
               
  // init audio
  Audio_Open;
                                                    
  // init music
  Audio_MusicLoad(Archive, cMusicFilenames[0]);
  Audio_MusicSetLoop(True);
  Audio_MusicSetVolume(0.3);
  Audio_MusicPlay;
  
  // load sounds
  for i := 0 to 4 do
  begin
    FSound[I] := Audio_SoundLoad(Archive, cSoundFilenames[I]);
  end;

  // init positional sound
  Audio_ChannelSetReserved(0, True);
  Audio_ListenerSetPosition(cDisplayWidth/2, cDisplayHeight/2);

  FChan := Audio_SoundPlayEx(AUDIO_DYNAMIC_CHANNEL, FSound[4], 1, True);
  Audio_ChannelSetMinDistance(FChan, 100);
  Audio_ChannelSetAttenuation(FChan, 1);
  Audio_ChannelSetPosition(FChan, cDisplayWidth/2, cDisplayHeight/2);       
end;

procedure TMyGame.OnShutdown;
var
  I: Integer;
begin
  // unload sounds
  for i := 0 to 4 do
  begin
    Audio_SoundUnload(FSound[I]);
  end;
   
  // close audio
  Audio_Close;
  
  // destry starfield
  Starfield_Destroy(FStarfield);  
  
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
  I: Integer;
begin
  inherited;
               
  // get mouse pos
  Mouse_GetInfo(FMousePos);

  // play sound  
  if Keyboard_Pressed(KEY_1) then
  begin
    I := Audio_SoundPlay(0, FSound[0]);
  end;

  if Keyboard_Pressed(KEY_2) then
  begin
    I := Audio_SoundPlay(AUDIO_DYNAMIC_CHANNEL, FSound[1]);
  end;

  if Keyboard_Pressed(KEY_3) then
  begin
    I := Audio_SoundPlay(AUDIO_DYNAMIC_CHANNEL, FSound[2]);
  end;

  if Keyboard_Pressed(KEY_4) then
  begin
    I := Audio_SoundPlay(AUDIO_DYNAMIC_CHANNEL, FSound[3]);
  end;      
       
  // update stars
  Starfield_Update(FStarfield, aDeltaTime);

  // update positioal audio
  Audio_ChannelSetPosition(FChan, MousePos.X, MousePos.Y);
  
end;

procedure TMyGame.OnRender;
begin
  // clear screen
  Display_Clear(BLACK);

  // render stars              
  Starfield_Render(FStarfield);  
  
  // draw avatar     
  Bitmap_Draw(FAvatar, cDisplayWidth-64, cDisplayHeight-64, nil, @Vector(0.50, 0.50), @Vector(0.15, 0.15), 
    0, FFaint, False, False);

end;

procedure TMyGame.OnRenderGUI;
begin
  inherited;
  
  PrintHudText(WHITE, Align_Left, 12,'1-4         - Sound', []);
  PrintHudText(ORANGE, Align_Left, 12,'Move to hear positial audio', []);
  
end;
  
{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);
      
end.