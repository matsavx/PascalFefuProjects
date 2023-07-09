var
  x, y: integer;

begin
  readln(x, y);
  if x <> y then
    if x > y then 
      y := 0
    else
      x := 0
  else
  begin
    x := 0;
    y := 0;
  end;
  writeln(x, ' ', y);
end.