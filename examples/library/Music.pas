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

program Music;

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
    FFilename: array[0..4] of string;
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
  FNum := aNum;
  Audio_MusicLoad(Archive, 'arc/music/' + FFilename[FNum]);
  Audio_MusicSetLoop(True);
  Audio_MusicSetVolume(aVol);
  Audio_MusicPlay;
end;

procedure TMyGame.OnStartup;
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

  // init audio
  Audio_Open;

  // init music filenames
  FFilename[0] := 'deliverance.ogg';
  FFilename[1] := 'hitman.ogg';
  FFilename[2] := 'spirit.ogg';
  FFilename[3] := 'opus.ogg';
  FFilename[4] := 'nightflyer.ogg';

  // play first song
  Play(0, 1.0);
end;

procedure TMyGame.OnShutdown;
begin
  // unload music
  Audio_MusicUnload;

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
var
  Vol: Single;
begin
  inherited;

  // get mouse pos
  Mouse_GetInfo(FMousePos);

  if Keyboard_Pressed(KEY_1) then
    Play(0, 1.0);

  if Keyboard_Pressed(KEY_2) then
    Play(1, 1.0);

  if Keyboard_Pressed(KEY_3) then
    Play(2, 1.0);

  if Keyboard_Pressed(KEY_4) then
    Play(3, 1.0);

  if Keyboard_Pressed(KEY_5) then
    Play(4, 0.5);

  if Keyboard_Pressed(KEY_PGDN) then
  begin
    Vol := Audio_MusicGetVolume;
    Vol := Vol - 0.10;
    Clip_Valuef(Vol, 0.0, 1.0, False);
    Audio_MusicSetVolume(Vol);
  end;

  if Keyboard_Pressed(KEY_PGUP) then
  begin
    Vol := Audio_MusicGetVolume;
    Vol := Vol + 0.10;
    Clip_Valuef(Vol, 0.0, 1.0, False);
    Audio_MusicSetVolume(Vol);
  end;

end;

procedure TMyGame.OnRender;
begin
  inherited;

  // draw avatar
  Bitmap_Draw(FAvatar, 240, 300, nil, @Vector(0.5, 0.5), @Vector(0.26, 0.26),
    0, FFaint, False, False);
end;

procedure TMyGame.OnRenderGUI;
begin
  inherited;

  PrintHudText(WHITE, Align_Left, 12, '1-5         - Music', []);
  PrintHudText(WHITE, Align_Left, 12, 'PgUp/PgDn   - Volume', []);
  PrintHudText(YELLOW, Align_Left, 12, 'Volume      : %02f',
    [Audio_MusicGetVolume]);
  PrintHudText(YELLOW, Align_Left, 12, 'Song        : %s (#%d)',
    [FFilename[FNum], FNum + 1]);
end;

{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);

end.
