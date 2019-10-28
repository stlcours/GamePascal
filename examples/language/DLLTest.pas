﻿{$REGION 'Project Directives'}
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

program DLLTest;

uses
  SysUtils,
  GamePascal;

const
  cDllName = 'TestDLL.dll';

function Min(X, Y: Integer): Integer; stdcall; external cDllName;

function Max(X, Y: Integer): Integer; stdcall; external cDllName;

begin
  WriteLn('Min(50, 60): ', Min(50, 60));
  WriteLn('Max(70, 90): ', Max(70, 90));

  Con_Pause(CON_LF + 'Press any key to continue...');
end.
