{$REGION 'Project Directives'}
// Modual Info
{$CONSOLEAPP}
{$MODULENAME            ".\bin\"}
{.$EXEICON              ".\bin\arc\icons\icon.ico"}
{.$SEARCHPATH           "path1;path2;path3"}
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

program MyGame;

uses
  SysUtils,
  GamePascal;
             
type

  { TMyGame }
  TMyGame = class(TGame)
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
  // open display
  Display_Open(-1, -1, 480, 600, False, True, False, Render_Direct3D, 'MyGame');
end;

procedure TMyGame.OnShutdown;
begin
  Display_Close;
end;

procedure TMyGame.OnDisplayReady(aReady: Boolean);
begin
  inherited;  
end;

procedure TMyGame.OnUpdate(aDeltaTime: Single);
begin
  inherited;  
end;

procedure TMyGame.OnRender;
begin
  // clear display
  Display_Clear(SKYBLUE);  
end;

procedure TMyGame.OnRenderGUI;
begin
  inherited;  
end;
  
{ ---  Main ----------------------------------------------------------------- }
begin
  RunGame(TMyGame);    
end.