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

program ExceptionHandling;

uses
  SysUtils,
  GamePascal;

procedure ErrorProc;
var
  I: Integer;
begin
  I := 0;
  I := I div I;
end;

procedure TestExcept1;
var
  S: string;
  I: Integer;
begin
  S := 'abc';
  try
    ErrorProc;
  except
    on E: EDivByZero do
    begin
      writeln(S);
      S := E.Message;
      writeln(S);
    end;
  else
    begin
      writeln(456);
    end;
  end;
end;

procedure TestExcept2;
var
  S: string;
  I: Integer;
begin
  S := 'abc';
  try
    ErrorProc;
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      writeln(S);
      //S := E.Message;
      //writeln(S);
    end;
  else
    begin
      writeln(456);
    end;
  end;
end;

begin
  //TestExcept;
  TestExcept2;
  WriteLN('ok');

  Con_Pause(CON_LF + 'Press any key to continue...');
end.
