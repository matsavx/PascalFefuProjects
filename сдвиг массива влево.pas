const n=10;
type Mass=array[1..n] of integer;
var i,m:integer;
a:Mass;

Procedure Postroy(var a:Mass);
begin
for var i:=1 to n do
a[i]:= random(10);
for var i:=1 to n do
write(a[i]);
writeln;
end;

Procedure Sdvig(var a:Mass);
begin
m:=a[1];
for var i:=1 to n-1 do
a[i]:=a[i+1];
a[n]:=m;
end;

Procedure Vivod(var a:Mass);
begin
for var i:=1 to n do
write(a[i]);
writeln;
end;

begin
Postroy(a);
Sdvig(a);
Vivod(a);
end.