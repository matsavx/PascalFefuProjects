program files;

var
  f1, f2: text;
  s, s1: string;
  dd1, mm1, yy1: integer;


procedure One_Space(var str: string);
begin
  while pos('  ', str) > 0 do
    delete(str, pos('  ', str), 1);
  if str[1] = ' ' then
    delete(str, 1, 1);
  if str[length(str)] = ' ' then
    delete(str, length(str), 1);
end;

procedure Conversion_Into_Numbers(var files: text; st: string; var year1, mun1, day1: integer);
var
  flag, err: integer;
  ye, mu, da: string;
  year, mun, day: integer;
begin
  flag := 1;
  for var i := 1 to length(st) do
  begin
    if (st[i] <> '/') and (st[i] <> ' ') and (flag = 1) then
      da := da + st[i]
    else if (st[i] <> '/') and (st[i] <> ' ') and (flag = 2) then
      mu := mu + st[i]
    else if (st[i] <> '/') and (st[i] <> ' ') and (flag = 3) then
      ye := ye + st[i]
    else
      flag := flag + 1;
    if flag = 4 then
    begin
      val(da, day, err);
      val(mu, mun, err);
      val(ye, year, err);
      if ((year1 = year) and (mun1 = mun) and (day1 > day)) or ((year1 = year) and (mun1 > mun)) or (year1 > year) then
        write(files, da, '/', mu, '/', ye, ' ');
      flag := 1;
      da := '';
      mu := '';
      ye := '';
    end;
  end;
end;

Procedure rty(st: string);
var 
  flag, err: integer;
  ye, mu, da: string;
begin
  flag := 1;
  for var i := 1 to length(st) do
  begin
    if (st[i] <> '/') and (st[i] <> ' ') and (flag = 1) then
      da := da + st[i]
    else if (st[i] <> '/') and (st[i] <> ' ') and (flag = 2) then
      mu := mu + st[i]
    else if (st[i] <> '/') and (st[i] <> ' ') and (flag = 3) then
      ye := ye + st[i]
    else
      flag := flag + 1;
    if flag = 4 then
    begin
      val(da, dd1, err);
      val(mu, mm1, err);
      val(ye, yy1, err);
    end;
  end;  
end;

begin
  assign(f1, 'C:\Users\kokorin.ni\Desktop\текстовые файлы\file.txt');
  reset(f1);
  assign(f2, 'C:\Users\kokorin.ni\Desktop\текстовые файлы\file1.txt');
  Rewrite(f2);
  write('Введите дату: ');
  readln(s1);
  s1 := s1 + ' ';
  rty(s1);
  write(f2, 'Все даты меньше заданной: ');
  while not Eof(f1) do
  begin
    readln(f1, s);
    One_Space(s);
    s := s + ' ';
    Conversion_Into_Numbers(f2, s, yy1, mm1, dd1);
    writeln(f2, '');
  end;
  close(f1);
  close(f2);
end.