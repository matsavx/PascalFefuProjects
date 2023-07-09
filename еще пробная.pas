var
  f1, f2: Text;
  s: string;
  day, month, year: integer;
  y,m,d,k:integer;

procedure vvod(var d3, m3, y3: integer);//Ввод даты
begin
  Readln(d3);
  readln(m3);
  readln(y3);
end;

procedure data(var f: text; st: string; var y2, m2, d2: integer);
var
  flag, err: integer;
  yt, mt, dt: string;
  d1, m1, y1: integer;
begin
  k:=0;
  flag := 1;
  for var i := 1 to length(st) do
  begin
    if (st[i] <> '/') and (st[i] <> ' ') and (flag = 1) then
      dt := dt + st[i]
    else 
    if (st[i] <> '/') and (st[i] <> ' ') and (flag = 2) then
      mt := mt + st[i]
    else begin
    if (st[i] <> '/') and (st[i] <> ' ') and (flag = 3) then begin
      yt := yt + st[i];
      k:=k+1;
      end
    else
      flag := flag + 1;
    if (flag = 4) and (k=4) then
    begin
      val(dt, d1, err);
      val(mt, m1, err);
      val(yt, y1, err);
      if ((y1=y)AND(m1=m)AND(d1>d))OR((y1=y)AND(m1>m))OR(y1>y)
        then write(f, d1, '/', m1, '/', y1, ' ');
      dt := '';
      mt := '';
      yt := '';
      flag := 1;
    end;
  end;
end;
end;

begin
  vvod(day, month, year);
  assign(f1, 'lol.txt');
  reset(f1);
  assign(f2, 'f2.txt');
  rewrite(f2);
  while not eof(f1) do
  begin
    readln(f1, s);
    data(f2, s, day, month, year);
  end;
  close(f1);
  close(f2);
end.



