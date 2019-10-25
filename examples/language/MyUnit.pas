// use TestUnit.pas to compile this unit

unit MyUnit;

interface

var
  I: Integer = 4;

const 
  S = 'abc';

procedure Proc(X: Integer);

implementation

var
  J: Integer = 10;

procedure Proc(X: Integer);
begin
  PrintLn(X);
end;

initialization
begin
  PrintLn('Initialization');
  I := 10;
end;
  
finalization
begin
  PrintLn('finalization');
end;

end.