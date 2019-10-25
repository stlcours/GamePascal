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
  TEnum = (one, two, three);

  TSubRangeBoolean = false..true;
  TSubRangeEnum = one..two;
  TSubRangeChar = 'a'..'z';

var 
  b: TSubrangeBoolean;
  e: TSubrangeEnum;
  c: TSubRangeChar;
  
begin
  b := true;
  WriteLn(b);
  e := two;
  WriteLn(Integer(e));
  c := 'h';
  WriteLn(Succ(c));
  
  Con_Pause(CON_LF+'Press any key to continue...');
end.