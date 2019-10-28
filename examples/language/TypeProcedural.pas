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

program TypeProcedural;

uses
  SysUtils,
  GamePascal;

type
  TProc = procedure(X: Integer); cdecl;
  TFunc = function(X, Y: Integer): Integer;

procedure MyProc(X: Integer); cdecl;
begin
  writeln(X);
end;

function F(X, Y: Integer): Integer;
begin
  result := X + Y;
end;

var
  Proc1, Proc2: TProc;
  Func: TFunc;
  P: Pointer;

begin
  Proc1 := MyProc;
  Proc2 := Proc1;

  Proc1(123);
  Proc2(123);

  Func := F;
  writeln(Func(3, 5));

  P := @MyProc;
  Proc1 := TProc(P);
  Proc1(24);
  TProc(P)(55);

  Con_Pause(CON_LF + 'Press any key to continue...');
end.
