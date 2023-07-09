var
  a1, b1, c1, a2, b2, c2, x, y, d, dx, dy: real;

begin
  write('Введите a1 a2 b1 b2 c1 c2: ');
  readln(a1, a2, b1, b2, c1, c2);
  d := a1 * b1 - a2 * b1;
  dx := c1 * b2 - b1 * c2;
  dy := a1 * c2 - a2 * c1;
  if d = 0 then 
    if (dx = 0) and (dy = 0) then 
      writeln('Бесконечно много решений')
    else writeln('Нет решений')
  else begin
    x := dx / d;
    y := dy / d;
    writeln(x, y);
  end;
end.
