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

program TypeRecord;

uses
  SysUtils,
  GamePascal;

type

  TMyRec = record
    Id: Integer;
    LastName: string[20];
    Properties: record
      Age: Integer;
      Height: Double;
    end;
  end;

var
  R: TMyRec;

begin
  R.Id := 101;
  R.LastName := 'Benson';
  R.Properties.Age := 23;
  R.Properties.Height := 1.82;
  WriteLn(R.Id, ' ', R.LastName, ' ', R.Properties.Age, ' ',
    R.Properties.Height: 4: 2);

  Con_Pause(CON_LF + 'Press any key to continue...');
end.
