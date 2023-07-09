const n=8; 
const g=20; 

type 
massive=array[1..n,1..n] of integer; 

var s,min,max,imin,imax,jmin,jmax,c:integer; 
x:massive; 


procedure Fill (var x:massive); 
var k: Integer;
{Считывание значащих элементов}
	begin
		for var i := 1 to s do
			begin
				for var j := i to (s-i+1) do
					begin
						read(c);
						x[i, j]:= c;
					end;
			end;

{Заполнение матрицы вправо}
for var i := 1 to (s-1) do
			begin
				k:= i+1;
				for var j := s downto i+1 do
					begin
						x[k, j]:= x[k-i, j-i];
						k:= K+1;
					end;
			end;

{Заполнение матрицы влево}
for var i := 1 to (s-1) do
			begin
				k:= i+1;
				for var j := 1 to (s-i) do
					begin
						x[k, j]:= x[k-i, j+i];
						k:= K+1;
					end;
			end;
	end;

{Вывод матрицы}
procedure conclusion(var x:massive); 
begin
	for var i := 1 to s do
		begin
			for var j := 1 to s do
				begin
					write(x[i, j]:4);
				end;
				writeln;
				writeln;
		end;
end;

{Нахождение минимальных элементов матрицы}
procedure Findmin(const x: massive; var jmin: integer); 
begin  
	min := x[1, 1]; imin := 1; jmin := 1; max := x[1, 1]; imax := 1; jmax := 1; 
		for var j := 1 to s do 
			for var i := 1 to s do 
				if min > x[i, j] then 
					begin 
						min := x[i, j]; 
						imin := i; 
						jmin := j; 
					end; 
	writeln('min ', min); 
	end;

{Нахождение максимальных элементов матрицы}	
procedure Findmax (const x: massive; var jmax:integer);
begin
	for var i := 1 to s do 
		for var j := 1 to s do 
			if min = x[i, j] then 
				writeln(' (', i, ',', j, ')'); 
	for var j := 1 to s do 
		for var i := 1 to s do 
			if max < x[i, j] then 
				begin 
					max := x[i, j]; 
					imax := i; 
					jmax := j; 
				end; 
	writeln('max ', max); 
	for var i := 1 to s do 
		for var j := 1 to s do 
			if max = x[i, j] then 
				writeln(' (', i, ',', j, ')'); 
	writeln('----------------------');
	end;

{Замена столбцов}	
Procedure change (const jmin, jmax:integer; var x: massive);
begin
	if jmin <> jmax then 
		begin 
			for var i := 1 to s do 
				begin 
					x[i, jmin] := x[i, jmin] + x[i, jmax]; 
					x[i, jmax] := x[i, jmin] - x[i, jmax]; 
					x[i, jmin] := x[i, jmin] - x[i, jmax]; 
				end; 
		end 
	else writeln('min и max в одном столбце'); 
	conclusion(x); 
end; 

begin 
write('Введите размер матрицы: '); 
read(s); 
if (s>2) and (s<=n) then 
begin 
writeln(); 
fill(x); 
writeln('----------------------'); 
conclusion(x); 
writeln('----------------------'); 
Findmin(x, jmin);
Findmax(x, jmax);
change(jmin, jmax, x); 
end 
else writeln('Введите число большее 2 и меньшее либо равное ',n); 
end.
