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
  T = String[5];
  
function GetShortString: T; 
begin
  result := 'abc';
end;

procedure TestShortString(var S: ShortString); 
begin
  S := 'xyz';
end;

var
  S1, S2: ShortString;
  S: String[4];
  Q: String;
  
begin
  Q := 'pqr';
  S1 := 'abc'; 
  S2 := 'pq';
  S := Q + S1 + S2;
  WriteLn(S);
  WriteLn(GetShortString());
  TestShortString(S);
  WriteLn(S);
  WriteLn(S[1]);
  WriteLn(Length(S));
  WriteLn(Byte(S[0])); 
  
  Con_Pause(CON_LF+'Press any key to continue...');
end.