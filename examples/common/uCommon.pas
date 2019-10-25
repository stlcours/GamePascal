// Standard Unit
unit uCommon;

interface

uses
  SysUtils,
  GamePascal;
  
const
  // Engine
  cEngineTargetSpeed = 60;
    
  // Archive
  cArchivePassword = '236c5b239c81407ab08ce976a62b8d36';  
  cArchiveFilename = 'Examples.arc';
  
  // Display
  cDisplayTitle      = 'GamePascal - ';
  cDisplayWidth      = 480;
  cDisplayHeight     = 600;
  cDisplayFullscreen = False;
  cDisplayVSync      = True;
  cDisplayaAntiAlias = False;
  cDisplayRenderAPI  = Render_Direct3D;
  cDisplayClearColor: TColor = DARKGRAY;
  
type

  { TBaseGame }
  TBaseGame = class(TGame)
  protected
    FMousePos: TVector;
  public
    property MousePos: TVector read FMousePos;
    procedure OnGetArchiveFilename(var aPassword: string; var aFilename: string); override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnDisplayReady(aReady: Boolean); override;
    procedure OnUpdate(aDeltaTime: Single); override;
    procedure OnRender; override;                        
    procedure OnRenderGUI; override;
  end;

implementation

{ --- TBaseGame ------------------------------------------------------------- }
procedure TBaseGame.OnGetArchiveFilename(var aPassword: string; var aFilename: string);
begin
  //inherited;
  aPassword := cArchivePassword;
  aFilename := cArchiveFilename;
end;

procedure TBaseGame.OnStartup;
begin
  Engine_SetTargetSpeed(cEngineTargetSpeed);
end;

procedure TBaseGame.OnShutdown;
begin
end;

procedure TBaseGame.OnDisplayReady(aReady: Boolean);
begin
  if not App_HasConsole then Exit;

  if aReady then
    WriteLn('Display ready')
  else
    WriteLn('Display not ready');

end;                                                           

procedure TBaseGame.OnUpdate(aDeltaTime: Single);
begin
  if Keyboard_Pressed(KEY_ESCAPE) then
    Engine_SetTerminate(True);

  if Keyboard_Pressed(KEY_F11) then
    Display_ToggleFullscreen;

  if Keyboard_Pressed(KEY_F12) then
    Screenshot_Take;

end;

procedure TBaseGame.OnRender;
begin
  // clear display
  Display_Clear(cDisplayClearColor);
end;

procedure TBaseGame.OnRenderGUI;
begin
  SetHudTextPos(3,3,1);
  PrintHudText(GREEN, Align_Left, 12, '%d fps', [Engine_GetFrameRate]);
  PrintHudText(WHITE, Align_Left, 12, 'Esc - Quit', []);
  PrintHudText(WHITE, Align_Left, 12, 'F11 - Toggle fullscreen', []);
  PrintHudText(WHITE, Align_Left, 12, 'Esc - Take screenshot', []);

end;



end.

