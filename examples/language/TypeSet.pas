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

program Demo;

uses
  SysUtils,
  GamePascal;

type
  TMySet = set of byte;
  
const
  ConstSet = [6,7] + [2..4];
  EmptySet = [];
  
var
  S, ASet: TMySet;
  I: Integer = 4;
  
begin
  S := EmptySet + [1..3];
  ASet := S * [I];
  WriteLn(S <> [1..9]);
  WriteLn(5 in [5]);
  
  Con_Pause(CON_LF+'Press any key to continue...');
end.