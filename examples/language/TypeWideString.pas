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

var
  w: WideChar;
  ws: WideString;
  c: Char;
  s: String;
  I: Integer;
  ss: ShortString;
begin
  I := 2;
  s := 'abc';
  ws := 'pqr';
  WriteLn(ws);
  WriteLn(ws[I]);
  c := 'z';
  w := 'a';
  WriteLn(w);
  w := WideChar(c);
  WriteLn(w);
  ws := s;
  WriteLn(ws);
  ws := 'd';
  WriteLn(ws);
  ws := c;
  WriteLn(ws);
  s := ws;
  WriteLn(s);
  ss := ws;
  WriteLn(ss);
  ws := ss;
  WriteLn(ws);
  ws := ws + ws;
  WriteLn(ws);
  ws := ws + 'abc';
  WriteLn(ws);
  ws := w + w;
  WriteLn(ws);
  ws := #$20AC;
  WriteLn(ws);
  
  Con_Pause(CON_LF+'Press any key to continue...');
end.