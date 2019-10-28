unit uTestbed;

interface

uses
  SysUtils,
  GamePascal;

type

  TMyGame = class(TGame)
  protected
    FBmp: TBitmap;
    FBmpAngle: Single;
  public
    procedure OnGetArchiveFilename(var aPassword: string; var aFilename: string);
      override;
    procedure OnStartup; override;
    procedure OnShutdown; override;
    procedure OnDisplayReady(aReady: Boolean); override;
    procedure OnUpdate(aDeltaTime: Single); override;
    procedure OnRender; override;
    procedure OnRenderGUI; override;
  end;

implementation

procedure TMyGame.OnGetArchiveFilename(var aPassword: string; var aFilename:
  string);
begin
  //inherited;
  aPassword := '236c5b239c81407ab08ce976a62b8d36';
  aFilename := 'Examples.arc';
end;

procedure TMyGame.OnStartup;
begin
  if Archive_IsOpen(FArchive) then
  begin
    WriteLn('Archive is opened');
    WriteLn('Filename: ', ArchiveFilename);
    WriteLn('Password: ', ArchivePassword);
  end;

  //inherited;
  Display_Open(-1, -1, 480, 600, False, True, False, Render_Direct3D, 'MyGame');

  FBmp := Bitmap_Load(Archive, 'arc/textures/avatar.png', nil);
  FBmpAngle := 0;
end;

procedure TMyGame.OnShutdown;
begin
  Bitmap_Unload(FBmp);
  inherited;
end;

procedure TMyGame.OnDisplayReady(aReady: Boolean);
begin
  inherited;
end;

procedure TMyGame.OnUpdate(aDeltaTime: Single);
begin
  inherited;
  FBmpAngle := FBmpAngle + (1.0 * aDeltaTime);
end;

procedure TMyGame.OnRender;
begin
  inherited;
  Bitmap_Draw(FBmp, 240, 300, nil, @Vector(0.5, 0.5), @Vector(0.26, 0.26),
    FBmpAngle, WHITE, False, False);

end;

procedure TMyGame.OnRenderGUI;
begin

  SetHudTextPos(3, 3, 1);
  PrintHudText(GREEN, Align_Left, 12, '%d fps', [Engine_GetFrameRate]);
  PrintHudText(WHITE, Align_Left, 12, 'Esc - Quit', []);
  PrintHudText(WHITE, Align_Left, 12, 'F11 - Toggle fullscreen', []);
  PrintHudText(WHITE, Align_Left, 12, 'Esc - Take screenshot', []);

  Font_Print(DefaultFont, 240, 400, SKYBLUE, Align_Center, 18,
    'Game Development System', []);

end;

end.
