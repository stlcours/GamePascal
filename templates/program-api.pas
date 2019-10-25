
(****************************************************************************
  Demo XYZ
  Copyright (c) Company XYZ
  All Rights Reserved.
  http://companyxyz.com
****************************************************************************)

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

program test2;

uses
  SysUtils,
  GamePascal;
     
const
  cTitle              = 'Demo XYZ';   
  cDisplayWidth       = 800;
  cDisplayHeight      = 600;
  cDisplayFullscreen  = False;
  cDisplayVSync       = True;
  cConsoleFontSize    = 12;
  cDefaultFontSize    = 18;
  cRenderAPI          = Render_Direct3D;
  cAntiAlias          = False;
                       
var
  ConsoleFont: TFont;   // console font
  DefaultFont: TFont;   // default font
          
// Engine Startup event handler      
procedure StartupEvent(aSender: Pointer);
begin
  // init display
  Display_Open(-1, -1, cDisplayWidth, cDisplayHeight, cDisplayFullscreen, 
    cDisplayVSync, cAntiAlias, cRenderAPI, cTitle);
                     
  // init fonts
  ConsoleFont := Font_LoadConsole;    
  DefaultFont := Font_LoadConsole;      
end;

// Engine Shutdown event handler
procedure ShutdownEvent(aSender: Pointer);
begin
  // unload fonts
  Font_Unload(DefaultFont);
  Font_Unload(ConsoleFont);
  
  // close display
  Display_Close;
end;

// Engine DisplayReady event handler 
procedure DisplayReadyEvent(aSender: Pointer; aDisplayReady: Boolean);
begin
end;

// Engine Update event handler
procedure UpdateEvent(aSender: Pointer; aDeltaTime: Single);
begin
  // terminte on escape key
  if Keyboard_Pressed(KEY_ESCAPE) then
    Engine_SetTerminate(True);
             
end;  
  
// Engine Render event handler
procedure RenderEvent(aSender: Pointer);
begin
  // clear display background
  Display_Clear(DARKGRAY);
  
end;

// Engine RenderGUI event handler
procedure RenderGUIEvent(aSender: Pointer);
begin
  Font_Print(ConsoleFont, 3, 3,  WHITE, Align_Left, 12, 'fps %d', [Engine_GetFrameRate]);
  Font_Print(ConsoleFont, 3, 18, WHITE, Align_Left, 12, 'ESC - Quit', []);
  
end;

// Main program
begin
  // Init/run engine game loop
  Engine_RunGameLoop(nil, StartupEvent, ShutdownEvent, DisplayReadyEvent, 
    UpdateEvent, RenderEvent, RenderGUIEvent);
end.