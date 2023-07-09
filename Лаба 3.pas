const n=8;
const g=20;
type massive=array[1..n,1..n] of integer;
type vector = array [1..g] of integer;
  var i,j,s,k,z,min,max,imin,imax,jmin,jmax:integer;
  x:massive;
  y:vector;
  

procedure Fill (var y:vector; var x:massive); 
var d,l:integer; 
// s - size of a matrix 
begin 
d:=0; 
l:=1; 
for var j:=1 to (floor(s div 2)+1) do 
begin 
for var i:=1 to s-2*d do 
begin 
write('Введите элемент ',i,' ячейки ');
    y[i]:= readInteger;
    
x[j,i+d]:=y[l]; 
l+=1; 
end; 
d+=1; 
end; 
//reflects matrix in one direction 
for var i:=1 to s do 
for var j:=1+i to s do 
x[j,i]:= x[i,j]; 
//reflects matrix in another direction 
for var i:=2 to s do 
for var j:=s downto s-i+1 do 
x[j,i]:= x[s+1-i,s+1-j]; 
end;

procedure show(var x: massive); 
begin 
var i, j: integer; 
for i := 1 to s do 
begin 
for j := 1 to s do 
write(x[i, j]:3, '(', i, ',', j, ')'); 
writeln(); 
end; 
end; 


procedure biz(var x: massive); 
begin 
var i, j: integer; 
min := x[1, 1]; imin := 1; jmin := 1; max := x[1, 1]; imax := 1; jmax := 1; 
for j := 1 to s do 
for i := 1 to s do 
if min > x[i, j] then 
begin 
min := x[i, j]; 
imin := i; 
jmin := j; 
end; 
writeln('min ', min); 
for i := 1 to s do 
for j := 1 to s do 
if min = x[i, j] then 
writeln(' (', i, ',', j, ')'); 
for j := 1 to s do 
for i := 1 to s do 
if max < x[i, j] then 
begin 
max := x[i, j]; 
imax := i; 
jmax := j; 
end; 
writeln('max ', max); 
for i := 1 to s do 
for j := 1 to s do 
if max = x[i, j] then 
writeln(' (', i, ',', j, ')'); 
writeln('----------------------'); 
if jmin <> jmax then 
begin 
for i := 1 to s do 
begin 
x[i, jmin] := x[i, jmin] + x[i, jmax]; 
x[i, jmax] := x[i, jmin] - x[i, jmax]; 
x[i, jmin] := x[i, jmin] - x[i, jmax]; 
end; 
end 
else writeln('min и max в одном столбце'); 
show(x); 


end; 

begin 
write('Введите размер матрицы '); 
read(s); 
if (s>2) and (s<=n) then 
begin 
writeln(); 
fill(y,x); 
writeln('----------------------'); 
Fill(y,x); 
show(x); 
writeln('----------------------');
biz(x); 
end 
else writeln('Введите число большее 2 и меньшее либо равное ',n); 
end.