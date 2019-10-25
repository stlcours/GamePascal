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
 
 CheckFailed = class(Exception)
 end;
 
 OtherFailed = class(Exception)
 end;

begin
  try
    raise checkFailed.create('Select check failed');
    //raise OtherFailed.create('Select check failed');
    //raise exception.create('Select check failed');
  except
    on CheckFailed do
     WriteLn('checkfailed raised');
  else
     WriteLn('other raised');
  end;

  Con_Pause(CON_LF+'Press any key to continue...');
end.
