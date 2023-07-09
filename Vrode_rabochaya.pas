var
  k, m, a, b, c, x, y: real;

begin
  write('Введите координаты точки x,y: ');
  readln(x, y);
  write('Введите коэффициенты прямой k и m: ');
  readln(k, m);
  write('Введите коэффициенты параболы a,b и c: ');
  readln(a, b, c);
  if (m <> 0) AND (a > 0) then begin
    if (y >= abs(k * x + m)) AND (y <= a * sqr(x) + b * x + c) then begin
      if (y > abs(k * x + m)) OR (y < a * sqr(x) + b * x + c) then begin
        if (y > abs(k * x + m)) AND (y < a * sqr(x) + b * x + c) then writeln('Точка лежит указанной области')
        else writeln('Точка не лежит в области определения');
      end
      else writeln('Точка лежит в пересечении графиков');
    end
    else writeln('Графики функции не образуют область пересечения');
  end
  else writeln('Параметры не задают функцию данного типа');
end.