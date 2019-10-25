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
  
  TMyPoint = record
    X, Y: Single;
  end; 
  
  TMyArray = array[false..true] of TMyPoint;
  
var
  a: TMyArray;
  b: array['a'..'z'] of Integer;
begin
  b['s'] := 47;
  WriteLn(b['s']);
  a[true].Y := 5.5;
  WriteLn(a[true].Y);
  
  Con_Pause(CON_LF+'Press any key to continue...');
end.