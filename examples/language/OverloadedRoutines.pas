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

program OverloadedRoutines;

uses
  SysUtils,
  GamePascal;

procedure Test(I: Integer; D: Double); overload;
begin
  writeln(I: 10, D: 10: 2);
end;

procedure Test(S: string); overload;
begin
  writeln(S);
end;

procedure Test(D: Double); overload;
begin
  writeln(D: 10: 2);
end;

begin
  Test('abc');
  Test(12.3);
  Test(5, 12.3);

  Con_Pause(CON_LF + 'Press any key to continue...');
end.
