var a,b,c,x1,x2,D:real;
begin
write('Введите a,b,c: ');
readln(a,b,c);
if a=0 then writeln('ERROR')
else begin
D:=sqr(b)-4*a*c;
if D<0 then writeln('Нет действительных корней')
else begin
if D=0 then writeln('x1=x2=',-b/2*a)
else writeln('x1=',(-b-sqrt(D))/2*a,' x2=',(-b+sqrt(D))/2*a);
end;
end;
end. 