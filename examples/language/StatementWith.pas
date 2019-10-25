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
  
  { TMyRec }
  TMyRec = record
    Id: Integer;
    LastName: String[20];
    Properties: record
                  Age: Integer; 
                  Height: Double;
                end;
  end;
  
var
  R: TMyRec;
begin
  
  with R do
  begin
    Id := 101;
    LastName := 'Benson';
    with Properties do
    begin
      Age := 23;
      Height := 1.82;
    end;
  end;
  
  WriteLn(R.Id, ' ', R.LastName, ' ', R.Properties.Age, ' ', R.Properties.Height:4:2);
  
  Con_Pause(CON_LF+'Press any key to continue...');
end.