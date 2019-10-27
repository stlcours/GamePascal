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

program TiledBitmap;

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
    FTexture: array[0..3] of TBitmap;
    FSpeed: array[0..3] of Single;
    FPos: array[0..3] of TVector;      
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
    cDisplayVSync, cDisplayaAntiAlias, cDisplayRenderAPI, 
    cDisplayTitle + 'TiledBitmap Demo');
  
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
end;

procedure TMyGame.OnShutdown;
begin
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
  
      
end;
  
{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);
      
end.