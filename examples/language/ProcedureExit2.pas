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

program ProcedureExit2;

uses
  SysUtils,
  GamePascal;

procedure Test;
var
  s: string;
begin
  try
    try
      WriteLn(1);
      Exit;
      WriteLn(2);
    finally
      WriteLn(3);
    end;
    WriteLn(4);
  finally
    WriteLn(5);
  end;
end;

begin
  Test;
  WriteLn(10);
  try
    WriteLn(11);
    Exit;
  finally
    WriteLn(12);
    Con_Pause(CON_LF + 'Press any key to continue...');
  end;
  WriteLn(13);

end.
