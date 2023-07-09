var
  f1: text;
  s: string;

procedure name(f: text; st: string);
var
  n: integer;
begin
  n := 0;
  for var i := 1 to length(st) do 
  begin
    if st[i] = ' ' then begin
      n := n + 1;
    end;
    if n < 3 then
      if not (st[i] in ['А'..'Я', ' ', 'а'..'я']) then
        write('Ошибка в ФИО ');
  end;
end;

begin
  assign(f1, 'f1.txt');
  reset(f1);
  while not eoln(f1) do
  begin
    readln(f1, s);
    name(f1, s);
  end;
  close(f1);
end.