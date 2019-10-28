{$REGION 'Project Directives'}
// Modual Info
{$CONSOLEAPP}
{$MODULENAME            "..\bin\"}
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

program TestInterfaces;

uses
  SysUtils,
  GamePascal;

type

  IMyInterface = interface(IUnknown)
    ['{E7AA427A-0F4D-4A96-A914-FAB1CA336337}']
    procedure P(X, Y: Integer);
  end;

  TMyClass = class(TInterfacedObject, IMyInterface)
  public
    constructor Create;
    procedure P(X, Y: Integer);
    destructor Destroy; override;
  end;

constructor TMyClass.Create;
begin
  inherited;
  WriteLn('Created');
end;

procedure TMyClass.P(X, Y: Integer);
begin
  WriteLn(Self.ClassName);
  WriteLn(X, ' ', Y);
end;

destructor TMyClass.Destroy;
begin
  WriteLn('Done');
  inherited;
end;

var
  I: IMyInterface;
  X: TMyClass;
begin
  X := TMyClass.Create;
  I := X;
  I.P(3, 4);
  X.Free;

  Con_Pause(CON_LF + 'Press any key to continue...');
end.
