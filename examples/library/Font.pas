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

program Font;

uses
  SysUtils,
  GamePascal,
  uCommon;
             
type

  { TMyGame }
  TMyGame = class(TBaseGame)
  protected
    FAvatar: TBitmap;
    FFaint : TColor;
    FFont: array[0..1] of TFont;
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
    cDisplayTitle + 'Font Demo');
  
  // load avatar
  FAvatar := Bitmap_Load(Archive, 'arc/textures/avatar.png', nil);
  
  // create color to draw a faint avatar in the back ground
  FFaint := Color_Createf(0.2, 0.2, 0.2, 0.2);     
  
  // load fonts
  FFont[0] := Font_Load(Archive, 'arc/fonts/digitalplay.ttf');
  FFont[1] := Font_Load(Archive, 'arc/fonts/redline.ttf');  
end;

procedure TMyGame.OnShutdown;
begin
  // distroy fonts
  Font_Unload(FFont[1]);
  Font_Unload(FFont[0]);

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
    
end;

procedure TMyGame.OnRender;
var
  VP: TRectangle;
  X: Single;
begin
  inherited;
  
  // draw avatar     
  Bitmap_Draw(FAvatar, cDisplayWidth-64, cDisplayHeight-64, nil, 
    @Vector(0.50, 0.50), @Vector(0.15, 0.15), 0, FFaint, False, False);
    
  Display_GetViewportSize(VP);
  X := VP.Width / 2;
  Font_Print(FFont[0], X, 200, ORANGE, Align_Center, 18, 'GamePascal™', []);
  Font_Print(FFont[1], X, 230, WHITE, Align_Center, 14, 'Game Development System', []);    

end;

procedure TMyGame.OnRenderGUI;
begin
  inherited;
end;
  
{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);
      
end.