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

program Starfield;

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
    FStarfield: TStarfield;  
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
    cDisplayTitle + 'Entity Demo');
  
  // load avatar
  FAvatar := Bitmap_Load(Archive, 'arc/textures/avatar.png', nil);
  
  // create color to draw a faint avatar in the back ground
  FFaint := Color_Createf(0.2, 0.2, 0.2, 0.2);
  
  // create starfield
  FStarfield := Starfield_Create;
       
end;

procedure TMyGame.OnShutdown;
begin
  // destroy starfield
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
begin
  inherited;
               
  // get mouse pos
  Mouse_GetInfo(FMousePos);
   
  // update change starfield
  if Keyboard_Pressed(KEY_1) then
  begin
    Starfield_SetXSpeed(FStarfield, 25);
    Starfield_SetYSpeed(FStarfield, 0);
    Starfield_SetZSpeed(FStarfield, -5);
    Starfield_SetVirtualPos(FStarfield, 0, 0);
  end;

  if Keyboard_Pressed(KEY_2) then
  begin
    Starfield_SetXSpeed(FStarfield, 0);
    Starfield_SetYSpeed(FStarfield, -25);
    Starfield_SetZSpeed(FStarfield, -5);
    Starfield_SetVirtualPos(FStarfield, 0, 0);

  end;

  if Keyboard_Pressed(KEY_3) then
  begin
    Starfield_SetXSpeed(FStarfield, -25);
    Starfield_SetYSpeed(FStarfield, 0);
    Starfield_SetZSpeed(FStarfield, -5);
    Starfield_SetVirtualPos(FStarfield, 0, 0);
  end;

  if Keyboard_Pressed(KEY_4) then
  begin
    Starfield_SetXSpeed(FStarfield, 0);
    Starfield_SetYSpeed(FStarfield, 25);
    Starfield_SetZSpeed(FStarfield, -5);
    Starfield_SetVirtualPos(FStarfield, 0, 0);
  end;

  if Keyboard_Pressed(KEY_5) then
  begin
    Starfield_SetXSpeed(FStarfield, 0);
    Starfield_SetYSpeed(FStarfield, 0);
    Starfield_SetZSpeed(FStarfield, 5);
    Starfield_SetVirtualPos(FStarfield, 0, 0);
  end;

  if Keyboard_Pressed(KEY_6) then
  begin
    Starfield_Init(FStarfield, 250, -1000, -1000, 10, 1000, 1000, 1000, 160);
    Starfield_SetZSpeed(FStarfield, 0);
    Starfield_SetYSpeed(FStarfield, 15);
  end;


  if Keyboard_Pressed(KEY_7) then
  begin
    Starfield_Init(FStarfield, 250, -1000, -1000, 10, 1000, 1000, 1000, 80);
    Starfield_SetXSpeed(FStarfield, 0);
    Starfield_SetYSpeed(FStarfield, 0);
    Starfield_SetZSpeed(FStarfield, -5);
    Starfield_SetVirtualPos(FStarfield, 0, 0);
  end;      
            
  // update starfield
  Starfield_Update(FStarfield, aDeltaTime);
end;

procedure TMyGame.OnRender;
begin
  // clear display black
  Display_Clear(BLACK);

  // draw avatar     
  Bitmap_Draw(FAvatar, cDisplayWidth-64, cDisplayHeight-64, nil, 
    @Vector(0.50, 0.50), @Vector(0.15, 0.15), 0, FFaint, False, False);
    
  // render starfield
  Starfield_Render(FStarfield);

end;

procedure TMyGame.OnRenderGUI;
begin
  inherited;
end;
  
{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);
      
end.