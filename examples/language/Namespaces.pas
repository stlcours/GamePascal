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

namespace A
  procedure G;
  begin
    P;
  end;
  procedure P;
  begin
    WriteLn(123);
  end;
end;

namespace A
  procedure V;
  begin
    WriteLn('V');
  end;
end;

begin
  A.G;
  A.V;
  
  Con_Pause(CON_LF+'Press any key to continue...');
end.
