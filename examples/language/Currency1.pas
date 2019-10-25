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

procedure MyCurrProc(X, Y: Currency);
begin
  WriteLn(X);
  WriteLn(Y);
end;

function MyCurrFunc(X: Currency): Currency;
begin
  result := X;
end;

var
  X: Currency = 3;
  Y: Currency = 5;
  I: Integer = 3;
  
begin
  MyCurrProc(I, Y);
  X := MyCurrFunc(2.3);
  WriteLn(X);
  X := 1234567;
  WriteLn(X);
  X := 123456789/100;
  WriteLn(X);
  
  Con_Pause(CON_LF+'Press any key to continue...');
end.
