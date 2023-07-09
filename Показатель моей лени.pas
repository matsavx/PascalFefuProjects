var
  f1, f2: Text;
  s: string;
  day, month, year: integer;
  d, y, m: integer;

procedure vvod(var d3,m3,y3: integer);//Ввод даты
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
  flag := 1;
  for var i := 1 to length(st) do
  begin
    if (st[i] <> '/') and (st[i] <> ' ') and (flag = 1) then//присваивает день из строки к переменной dt, если flag=1
      dt := dt + st[i]
    else if (st[i] <> '/') and (st[i] <> ' ') and (flag = 2) then//присваивает месяц из строки к переменной mt, если flag=2
      mt := mt + st[i]
    else if (st[i] <> '/') and (st[i] <> ' ') and (flag = 3) then//присваивает год из строки к переменной yt, если flag=3
      yt := yt + st[i]
    else
      flag := flag + 1;//прибавляя к флагу 1 - переходим на следующий шаг
    if flag = 4 then//завершаем присваивание дат
    begin
      val(dt, d1, err);
      val(mt, m1, err);
      val(yt, y1, err);
      if ((y1=y)AND(m1=m)AND(d1>d))OR((y1=y)AND(m1>m))OR(y1>y)
        then write(f, d1, '/', m1, '/', y1, ' ');
      dt:='';
      mt:='';
      yt:='';
      flag:=1;
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



