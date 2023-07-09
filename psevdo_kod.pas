Program psevdo_kod;
var k1,k2,m1,m2,x,y,b,c,a,x1,d1,d2:real;
begin
write('Введите координаты x,y: ');
readln(x,y);
write('Введите коэффициенты первой прямой k1 и m1: ');
readln(k1,d1);
write('Введите коэффициенты второй прямой k2 и m2: ');
readln(k2,d2);
write('Введите коэффициенты параболы a,b и c: ');
readln(a,b,c);
x1:=(m2-m1)/(k1-k2);
 if x1>=0 then begin
  writeln('Прямые образуют точку пересечения');
  d1:=sqr(b-k1)-4*a*(c-m1); 
  d2:=sqr(b-k2)-4*a*(c-m2); 
   if (d1>=0) AND (d2>=0) then begin
    if (d1>0)AND(d2>0) then writeln('Точка лежит внутри области')
    else writeln('Точка лежит на пересечении')
    end
   else writeln('ERROR. Введены неверные коэффициенты параболы.');
  end
 else writeln('ERROR. Введены неверные данные прямых.');
end.
 
   
