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

program TestInterfaces2;

uses
  SysUtils,
  GamePascal;

type

  IMyPropInterface = interface
    function GetName: string;
  end;

  TMyPropInterface = class
  public
    function GetName: string;
  end;

  TMyClass = class(TInterfacedObject, IMyPropInterface)
  private
    fMyPropInterface: TMyPropInterface;
  public
    constructor Create;
    destructor Destroy; override;
    property MyPropInterface: TMyPropInterface
      read fMyPropInterface
      write fMyPropInterface
      implements IMyPropInterface;
  end;

function TMyPropInterface.GetName: string;
begin
  result := 'abc';
end;
                              
constructor TMyClass.Create;
begin
  inherited;            
  MyPropInterface := TMyPropInterface.Create;
end;

destructor TMyClass.Destroy;
begin
  MyPropInterface.Free;
  inherited;  
end;

var
  X: TMyClass;
  I: IMyPropInterface;
begin
  X := TMyClass.Create;
  I := X;                        
  WriteLn(I.GetName());

  Con_Pause(CON_LF + 'Press any key to continue...');
end.
