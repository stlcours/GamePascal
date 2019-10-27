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

program Video;

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
    FVideo: array[0..2] of TVideo;
    FFilename: array[0..2] of string;
    FNum: Integer;
    procedure Play(aNum: Integer; aVol: Single);      
  public
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnDisplayReady(aReady: Boolean); override;
    procedure OnUpdate(aDeltaTime: Single); override;
    procedure OnRender; override;
    procedure OnRenderGUI; override;
  end;  

{ --- TMyGame --------------------------------------------------------------- }
procedure TMyGame.Play(aNum: Integer; aVol: Single);
begin
  Video_SetPlaying(FVideo[FNum],False);
  Video_Play(FVideo[aNum], True, aVol);
  FNum := aNum;
end;

procedure TMyGame.OnStartup;
var
  i: Integer;
begin
  inherited;
  
  // open display
  Display_Open(-1, -1, cDisplayWidth, cDisplayHeight, cDisplayFullscreen,
    cDisplayVSync, cDisplayaAntiAlias, cDisplayRenderAPI, 
    cDisplayTitle + 'Entity Demo');
  
  // load avatar
  FAvatar := Bitmap_Load(Archive, 'arc/textures/avatar.png', nil);
  
  // create color to draw a faint avatar in the back ground
  FFaint := Color_Createf(0.2, 0.2, 0.2, 0.2);
  
  // init video filenams
  FFilename[0] := 'tbgintro.ogv';
  FFilename[1] := 'test.ogv';
  FFilename[2] := 'wildlife.ogv';

  // init audio
  Audio_Open;    
  
  // load videos
  for i := Low(FFilename) to High(FFilename) do
  begin
    FVideo[i] := Video_Load(Archive, 'arc/videos/' + FFilename[i]);
  end;
  
  // start video playing
  Play(0, 0.5);       
end;

procedure TMyGame.OnShutdown;
var
  I: Integer;
begin
  // destroy video
  for i := Low(FFilename) to High(FFilename) do
  begin
    Video_Unload(FVideo[i]);
  end;
               
  // close audio
  Audio_Close;
  
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
  
  if Keyboard_Pressed(KEY_1) then
    Play(0, 0.5);

  if Keyboard_Pressed(KEY_2) then
    Play(1, 1.0);

  if Keyboard_Pressed(KEY_3) then
    Play(2, 0.5);      
    
end;

procedure TMyGame.OnRender;
var
  x,y,w,h: Single;
  vp: TRectangle;
begin
  inherited;
  
  Display_GetViewportSize(vp);
  w := 0;
  h := 0;
  Video_GetSize(FVideo[FNum], @w, @h);
  x := (vp.Width  - w) / 2;
  y := (vp.Height - h) / 2;
  Video_Draw(FVideo[FNum], x, y);  
  
  // draw avatar     
  Bitmap_Draw(FAvatar, cDisplayWidth-64, cDisplayHeight-64, nil, 
    @Vector(0.50, 0.50), @Vector(0.15, 0.15), 0, FFaint, False, False);
    
end;

procedure TMyGame.OnRenderGUI;
begin
  inherited;
  PrintHudText(WHITE, Align_Left, 12, '1-3         - Video (%s)', [FFilename[FNum]]);
end;
  
{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);
      
end.