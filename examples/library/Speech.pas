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

program Speech;

uses
  SysUtils,
  GamePascal,
  uCommon;
                  
const
  SpeechText1 =
    'You are Cadet John Blake. Reports are ' +
    'showing some activity in the newly ' +
    'established "free zones" bordering the ' +
    'outer regions of the Earth Alliance ' +
    'Defense Grid.' +
    ' ' +
    'These areas were established to promote ' +
    'free commerce and attract new members to ' +
    'the Alliance. A new resistance group has ' +
    'formed and they are stirring up trouble;' +
    'Known as the New Space Resistance  or (NSR),' +
    'they are considered extremely hostile and ' +
    'you are authorized to neutralize this ' +
    'threat by any means necessary.' +
    ' ' +
    'You’ve been assigned to patrol zones one ' +
    'through seven; Your mission is called ' +
    'Operation freestrike; and you will pilot ' +
    'the LRTD-50X; This is an experimental ' +
    'long-range tactical defense ship. It is ' +
    'equipped with new advanced weaponry and ' +
    'shield technology as well as an enhanced ' +
    'quantum pulse engine.' +
    ' ' +
    'This is a top-priority mission cadet; and ' +
    'confidence is high; I repeat, confidence is high!';

  SpeechText2  = '';  
  
type

  { TMyGame }
  TMyGame = class(TBaseGame)
  protected
    FFaint: TColor;
    FAvatar: TBitmap;
    FTexture: array[0..3] of TBitmap;
    FSpeed: array[0..3] of Single;
    FPos: array[0..3] of TVector;
    SpeechWord: string;
    FFont: TFont;
          
  public
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnDisplayReady(aReady: Boolean); override;
    procedure OnUpdate(aDeltaTime: Single); override;
    procedure OnRender; override;
    procedure OnRenderGUI; override;
    procedure OnSpeakWord(aWord: string; aText: string);
  end;  

{ --- TMyGame --------------------------------------------------------------- }
procedure SpeechWordEvent(aSender: Pointer; aWord: string; aText: string);
begin
   TMyGame(aSender).OnSpeakWord(aWord, aText);
end;

procedure TMyGame.OnSpeakWord(aWord: string; aText: string);
begin
  SpeechWord := aWord;
end;

procedure TMyGame.OnStartup;
begin
  inherited;
  
  // open display
  Display_Open(-1, -1, cDisplayWidth, cDisplayHeight, cDisplayFullscreen,
    cDisplayVSync, cDisplayaAntiAlias, cDisplayRenderAPI, 
    cDisplayTitle + 'Speech Demo');
  
  // load avatar
  FAvatar := Bitmap_Load(Archive, 'arc/textures/avatar.png', nil);
  
  // create color to draw a faint avatar in the back ground
  FFaint := Color_Createf(0.2, 0.2, 0.2, 0.2);
  
  // Load bitmaps
  FTexture[0] := Bitmap_Load(Archive, 'arc/backgrounds/space.png', nil);
  FTexture[1] := Bitmap_Load(Archive, 'arc/backgrounds/nebula.png', @BLACK);
  FTexture[2] := Bitmap_Load(Archive, 'arc/backgrounds/spacelayer1.png', @BLACK);
  FTexture[3] := Bitmap_Load(Archive, 'arc/backgrounds/spacelayer2.png', @BLACK);

  // Set bitmap speeds
  FSpeed[0] := 0.3;
  FSpeed[1] := 0.5;
  FSpeed[2] := 1.0;
  FSpeed[3] := 2.0;

  // Clear pos
  FPos[0].Clear;
  FPos[1].Clear;
  FPos[2].Clear;
  FPos[3].Clear;
  
  // init audio
  Audio_Open;
  
  // init music
  Audio_MusicLoad(Archive, 'arc/music/deliverance.ogg');
  Audio_MusicSetLoop(True);
  Audio_MusicSetVolume(0.5);
  Audio_MusicPlay;  
         
end;

procedure TMyGame.OnShutdown;
begin
  // clear speech
  Speech_Clear;

  // shutdown audio
  Audio_Close;

  // Destroy textures
  Bitmap_Unload(FTexture[3]);
  Bitmap_Unload(FTexture[2]);
  Bitmap_Unload(FTexture[1]);
  Bitmap_Unload(FTexture[0]);  
  
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
  i: Integer;
begin
  inherited;
               
  // get mouse pos
  Mouse_GetInfo(FMousePos);
      
  // start speech
  if Keyboard_Pressed(KEY_S) then
  begin
    if not Speech_Active then
    begin
      Speech_SetWordEventHandler(Self, SpeechWordEvent);
      Speech_Speak(SpeechText1);
    end;
  end;      
                  
  // update bitmap position
  for i := 0 to 3 do
  begin
    FPos[i].Y := FPos[i].Y + (FSpeed[i] * aDeltaTime);
  end;  
  
end;

procedure TMyGame.OnRender;
var
  i: Integer;
begin
  inherited;
                 
  // Render bitmaps
  for i := 0 to 3 do
  begin
    if i = 1 then Display_SetBlendMode(Blend_AdditiveAlpha);
    Bitmap_DrawTiled(FTexture[i], FPos[i].X, FPos[i].Y);
    Display_RestoreDefaultBlendMode;
  end;  
  
  // draw avatar     
  Bitmap_Draw(FAvatar, cDisplayWidth-64, cDisplayHeight-64, nil, @Vector(0.50, 0.50), @Vector(0.15, 0.15), 
    0, FFaint, False, False);

end;

procedure TMyGame.OnRenderGUI;
begin
  inherited;
  PrintHudText(WHITE, Align_Left, 12,'S           - Speak', []);
  Font_Print(DefaultFont, 15, 160, ORANGE, Align_Left, 24, 'Speech:  %s ', [SpeechWord]);      
end;
  
{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);
      
end.