var
  m, y: integer;

begin
  write('Введите месяц, год: ');
  readln(m, y);
  if(m < 1) OR (m > 12) OR (y < 1918) then
    writeln('error')
  else case m of
      1, 3, 5, 7, 8, 10, 12: writeln('31');
      4, 6, 9, 11: writeln('30');
      2:
        if(y mod 4 = 0) AND (y mod 100 <> 0) OR (y mod 400 = 0) then writeln('29')
        else writeln('28');
    end;
end.
