var
  best, i, x, n: integer;

begin
  write('Введите количество участников: ');
  readln(n);
  writeln('Введите результат первого участника: ');
  readln(best);
  for i := 2 to n do 
  begin
    write('Введите результат следущего участника: ');
    readln(x);
    if x > best then
      best := x;
  end;
  writeln('Лучший результат: ', best);
end.