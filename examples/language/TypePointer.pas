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
  PInteger = ^Integer;

var 
  x: PInteger;
  y: Integer = 3333;
  p: Pointer;
  
begin
  GetMem(x, 4);
  x^ := 8;
  WriteLn(x^);
  FreeMem(x, 4);

  New(x);
  x^ := 8;
  WriteLn(x^);
  Dispose(x);

  x := nil;
  x := @ y;
  WriteLn(y);
  writeln(x^ + x^ + 1);

  p := @y;
  Integer(p^) := 123;
  WriteLn(Integer(p^));
  WriteLn(y);
  
  Con_Pause(CON_LF+'Press any key to continue...');
end.